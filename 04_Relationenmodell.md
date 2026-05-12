# Relationenmodell – IT-Dienstleister Verwaltung

## 1. Relationale Tabellen-Notation

### Formal Definition (Relationale Algebra)

```
STANDORT (id_ort, bundesland, stadt, plz, strasse, hausnummer)
   PK: id_ort
   
KUNDE (id_kunde, name, branche, kundennummer)
   PK: id_kunde
   UNIQUE: kundennummer
   
BESTELLUNG (bestellnummer)
   PK: bestellnummer
   
PRODUKT (id_produkt, name, preis)
   PK: id_produkt
   
STANDORT_HAS_KUNDE (id_standort_has_kunde, standort_id_ort, kunde_id_kunde)
   PK: id_standort_has_kunde
   FK: standort_id_ort → STANDORT(id_ort)
   FK: kunde_id_kunde → KUNDE(id_kunde)
   
KUNDE_HAS_BESTELLUNG (id_kunde_has_bestellung, kunde_id_kunde, bestellung_bestellnummer)
   PK: id_kunde_has_bestellung
   FK: kunde_id_kunde → KUNDE(id_kunde)
   FK: bestellung_bestellnummer → BESTELLUNG(bestellnummer)
   
PRODUKT_BESTELLUNG (id_produkt_bestellung, produkt_id_produkt, bestellung_bestellnummer, menge)
   PK: id_produkt_bestellung
   FK: produkt_id_produkt → PRODUKT(id_produkt)
   FK: bestellung_bestellnummer → BESTELLUNG(bestellnummer)
```

---

## 2. Relationales Schema (SQL DDL)

```sql
-- Basisentitäten (keine Abhängigkeiten)
CREATE TABLE standort (
    id_ort INT AUTO_INCREMENT PRIMARY KEY,
    bundesland VARCHAR(45),
    stadt VARCHAR(45),
    plz INT,
    strasse VARCHAR(45),
    hausnummer INT
);

CREATE TABLE bestellung (
    bestellnummer INT AUTO_INCREMENT PRIMARY KEY
);

CREATE TABLE produkt (
    id_produkt INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45),
    preis DECIMAL(10,2)
);

-- Kernentität mit eindeutigen Attributen
CREATE TABLE kunde (
    id_kunde INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45),
    branche VARCHAR(45),
    kundennummer VARCHAR(45) UNIQUE
);

-- N:M Beziehungstabellen
CREATE TABLE standort_has_kunde (
    id_standort_has_kunde INT AUTO_INCREMENT PRIMARY KEY,
    standort_id_ort INT NOT NULL,
    kunde_id_kunde INT NOT NULL,
    FOREIGN KEY (standort_id_ort) REFERENCES standort(id_ort) ON DELETE CASCADE,
    FOREIGN KEY (kunde_id_kunde) REFERENCES kunde(id_kunde) ON DELETE CASCADE
);

CREATE TABLE kunde_has_bestellung (
    id_kunde_has_bestellung INT AUTO_INCREMENT PRIMARY KEY,
    kunde_id_kunde INT NOT NULL,
    bestellung_bestellnummer INT NOT NULL,
    FOREIGN KEY (kunde_id_kunde) REFERENCES kunde(id_kunde) ON DELETE CASCADE,
    FOREIGN KEY (bestellung_bestellnummer) REFERENCES bestellung(bestellnummer) ON DELETE CASCADE
);

CREATE TABLE produkt_bestellung (
    id_produkt_bestellung INT AUTO_INCREMENT PRIMARY KEY,
    produkt_id_produkt INT NOT NULL,
    bestellung_bestellnummer INT NOT NULL,
    menge INT DEFAULT 1,
    FOREIGN KEY (produkt_id_produkt) REFERENCES produkt(id_produkt) ON DELETE CASCADE,
    FOREIGN KEY (bestellung_bestellnummer) REFERENCES bestellung(bestellnummer) ON DELETE CASCADE
);
```

---

## 3. Normalisierung (NF1 → NF3)

### Erste Normalform (1NF): Atomare Attributwerte

**Bedingung:** Keine mehrwertigen Attribute  
**Status:** ✅ ERFÜLLT

Alle Attribute sind skalar (einzelne Werte), keine Array/Listen:
```
✅ RICHTIG:
  menge INT = 5
  
❌ FALSCH:
  menge INT[] = [5, 10, 3]  ← Mehrwertig
  standort_ids VARCHAR = "1,2,3"  ← Mehrwertig
```

### Zweite Normalform (2NF): Keine Partial Dependencies

**Bedingung:** Alle Nicht-Schlüssel-Attribute sind vom gesamten Primärschlüssel abhängig

**Status:** ✅ ERFÜLLT

Beispiel `PRODUKT_BESTELLUNG`:
```
PK = (id_produkt_bestellung)  ← Einfacher PK, keine Partial Dependencies

Alle Attribute hängen von id_produkt_bestellung ab:
- produkt_id_produkt → abhängig von id_produkt_bestellung
- bestellung_bestellnummer → abhängig von id_produkt_bestellung
- menge → abhängig von id_produkt_bestellung
```

### Dritte Normalform (3NF): Keine Transitive Dependencies

**Bedingung:** Kein Nicht-Schlüssel-Attribut ist von einem anderen Nicht-Schlüssel-Attribut abhängig

**Status:** ✅ ERFÜLLT

Beispiel: `KUNDE`
```
PK = (id_kunde)

Alle Nicht-PK-Attribute hängen DIREKT vom PK ab:
✅ id_kunde → name (direkt)
✅ id_kunde → branche (direkt)
✅ id_kunde → kundennummer (direkt)

❌ FALSCH wäre: id_kunde → branche_id → branche
   (Transitive Abhängigkeit: id_kunde → branche_id → branche)
```

---

## 4. Relationale Integritätsbedingungen

### 1. Schlüssel-Integrität (Key Integrity)

```sql
-- Primary Key Constraints
ALTER TABLE standort ADD PRIMARY KEY (id_ort);
ALTER TABLE kunde ADD PRIMARY KEY (id_kunde);
ALTER TABLE bestellung ADD PRIMARY KEY (bestellnummer);
ALTER TABLE produkt ADD PRIMARY KEY (id_produkt);

-- Unique Constraint (Super-Key)
ALTER TABLE kunde ADD UNIQUE (kundennummer);
```

### 2. Referenzielle Integrität (Referential Integrity)

```sql
-- Fremdschlüssel in STANDORT_HAS_KUNDE
ALTER TABLE standort_has_kunde
ADD FOREIGN KEY (standort_id_ort) REFERENCES standort(id_ort);

ALTER TABLE standort_has_kunde
ADD FOREIGN KEY (kunde_id_kunde) REFERENCES kunde(id_kunde);

-- Fremdschlüssel in KUNDE_HAS_BESTELLUNG
ALTER TABLE kunde_has_bestellung
ADD FOREIGN KEY (kunde_id_kunde) REFERENCES kunde(id_kunde);

ALTER TABLE kunde_has_bestellung
ADD FOREIGN KEY (bestellung_bestellnummer) REFERENCES bestellung(bestellnummer);

-- Fremdschlüssel in PRODUKT_BESTELLUNG
ALTER TABLE produkt_bestellung
ADD FOREIGN KEY (produkt_id_produkt) REFERENCES produkt(id_produkt);

ALTER TABLE produkt_bestellung
ADD FOREIGN KEY (bestellung_bestellnummer) REFERENCES bestellung(bestellnummer);
```

### 3. Domänen-Integrität (Domain Integrity)

```sql
-- Spalten mit NOT NULL
ALTER TABLE standort MODIFY stadt VARCHAR(45) NOT NULL;
ALTER TABLE kunde MODIFY name VARCHAR(45) NOT NULL;
ALTER TABLE produkt MODIFY name VARCHAR(45) NOT NULL;

-- Datentyp-Constraints
ALTER TABLE produkt MODIFY preis DECIMAL(10,2) CHECK (preis >= 0);
ALTER TABLE produkt_bestellung MODIFY menge INT CHECK (menge > 0);

-- Format-Constraint (PLZ 5-stellig)
ALTER TABLE standort ADD CONSTRAINT chk_plz CHECK (plz BETWEEN 1000 AND 99999);
```

### 4. Entität-Integrität (Entity Integrity)

```sql
-- Alle Primary Keys sind eindeutig und NOT NULL (automatisch erzwungen)
-- AUTO_INCREMENT garantiert Eindeutigkeit

SELECT COUNT(*) FROM standort WHERE id_ort IS NULL;  -- Muss 0 sein
SELECT COUNT(DISTINCT id_ort) FROM standort;  -- Muss gleich COUNT(*) sein
```

---

## 5. Beziehungs-Diagramm (Normalisierte Form)

```
┌─────────────────────────────────────────────────────────────────┐
│                     RELATIONENMODELL                            │
└─────────────────────────────────────────────────────────────────┘

┌──────────────────┐
│    STANDORT      │
├──────────────────┤
│ PK: id_ort       │
│ • bundesland     │
│ • stadt          │
│ • plz            │
│ • strasse        │
│ • hausnummer     │
└──────────────────┘
        │ 1
        │ N (M:N über Junction)
        │
        ▼
┌──────────────────────────────┐         ┌──────────────────┐
│ STANDORT_HAS_KUNDE (Junction)│──► M:N  │     KUNDE        │
├──────────────────────────────┤         ├──────────────────┤
│ PK: id_standort_has_kunde    │         │ PK: id_kunde     │
│ FK: standort_id_ort          │         │ • name           │
│ FK: kunde_id_kunde           │         │ • branche        │
└──────────────────────────────┘         │ • kundennummer   │
                                         └──────────────────┘
                                                 │ 1
                                                 │ N (M:N über Junction)
                                                 │
                                                 ▼
                                         ┌──────────────────────────────┐
                                         │ KUNDE_HAS_BESTELLUNG (Junc.) │
                                         ├──────────────────────────────┤
                                         │ PK: id_kunde_has_bestellung  │
                                         │ FK: kunde_id_kunde           │
                                         │ FK: bestellung_bestellnummer │
                                         └──────────────────────────────┘
                                                 │ 1
                                                 │ N (M:N über Junction)
                                                 │
                                                 ▼
                                         ┌──────────────────────┐
                                         │   BESTELLUNG         │
                                         ├──────────────────────┤
                                         │ PK: bestellnummer    │
                                         └──────────────────────┘
                                                 │ 1
                                                 │ N (M:N über Junction)
                                                 │
                                                 ▼
                                         ┌──────────────────────────────┐
                                         │ PRODUKT_BESTELLUNG (Junc.)   │
                                         ├──────────────────────────────┤
                                         │ PK: id_produkt_bestellung    │
                                         │ FK: produkt_id_produkt       │
                                         │ FK: bestellung_bestellnummer │
                                         │ • menge                      │
                                         └──────────────────────────────┘
                                                 │ N
                                                 │ (M:N)
                                                 │
                                                 ▼
                                         ┌──────────────────┐
                                         │    PRODUKT       │
                                         ├──────────────────┤
                                         │ PK: id_produkt   │
                                         │ • name           │
                                         │ • preis          │
                                         └──────────────────┘
```

---

## 6. Beispiel-Dateninstanzen (Tabellen-Inhalt)

### STANDORT
| id_ort | bundesland | stadt | plz | strasse | hausnummer |
|--------|-----------|-------|-----|---------|-----------|
| 1 | Bayern | München | 80331 | Arnulfstrasse | 11 |
| 2 | Hessen | Frankfurt | 60311 | Mainzer Landstrasse | 22 |
| 3 | NRW | Köln | 50667 | Hohenzollernring | 8 |

### KUNDE
| id_kunde | name | branche | kundennummer |
|----------|------|---------|--------------|
| 1 | Alpha Office GmbH | Beratung | K-2026-1001 |
| 2 | Beta Logistik AG | Logistik | K-2026-1002 |
| 3 | CityCare Klinik | Gesundheit | K-2026-1003 |

### BESTELLUNG
| bestellnummer |
|---------------|
| 1 |
| 2 |
| 3 |

### PRODUKT
| id_produkt | name | preis |
|-----------|------|-------|
| 1 | Remote Support Basic (1h) | 85.00 |
| 2 | Remote Support Premium (1h) | 119.00 |
| 3 | Onsite Support (2h) | 249.00 |

### STANDORT_HAS_KUNDE
| id_standort_has_kunde | standort_id_ort | kunde_id_kunde |
|----------------------|-----------------|----------------|
| 1 | 1 | 1 |
| 2 | 2 | 2 |
| 3 | 3 | 3 |

### KUNDE_HAS_BESTELLUNG
| id_kunde_has_bestellung | kunde_id_kunde | bestellung_bestellnummer |
|------------------------|----------------|-------------------------|
| 1 | 1 | 1 |
| 2 | 1 | 5 |
| 3 | 1 | 21 |
| 4 | 2 | 2 |
| 5 | 2 | 9 |

### PRODUKT_BESTELLUNG
| id_produkt_bestellung | produkt_id_produkt | bestellung_bestellnummer | menge |
|----------------------|-------------------|------------------------|-------|
| 1 | 1 | 1 | 2 |
| 2 | 2 | 1 | 1 |
| 3 | 3 | 2 | 1 |
| 4 | 1 | 5 | 5 |

---

## 7. Anomalien-Analyse (Normalisierung nachgewiesen)

### Insert-Anomalie (verhindert)

**Problem ohne Normalisierung:**
```sql
❌ Versuch: Neuen Standort ohne Kunde einfügen
INSERT INTO unnormalisierte_kunde_standort 
(name, standort, stadt) VALUES ('', 'Hamm', 'Hamburg');
  ↑ name ist NULL → Insert-Anomalie
```

**Lösung durch Normalisierung:**
```sql
✅ Separate Tabellen erlauben unabhängige Inserts
INSERT INTO standort (bundesland, stadt, plz) 
VALUES ('Hamburg', 'Hamburg', 20095);  -- Ohne Kunde möglich!
```

### Update-Anomalie (verhindert)

**Problem ohne Normalisierung:**
```sql
❌ Würde zu Datensätze-Redundanz führen:
Wenn "München" den Stadtnamen ändert, müssten ALLE Zeilen mit München aktualisiert werden.
```

**Lösung durch Normalisierung:**
```sql
✅ Nur eine Stelle ändern
UPDATE standort SET stadt = 'Muenchen' WHERE id_ort = 1;
```

### Delete-Anomalie (verhindert)

**Problem ohne Normalisierung:**
```sql
❌ Wenn letzter Kunde aus München gelöscht wird, 
   verlieren wir die Information über München.
```

**Lösung durch Normalisierung:**
```sql
✅ Standort bleibt erhalten
DELETE FROM kunde WHERE id_kunde = 1;
-- STANDORT München bleibt in der Datenbank
```

---

## 8. Abhängigkeitsanalyse (Functional Dependencies)

### STANDORT
```
id_ort → bundesland, stadt, plz, strasse, hausnummer
(Alle Attribute hängen vom PK ab → 3NF erfüllt)
```

### KUNDE
```
id_kunde → name, branche, kundennummer
(Alle Attribute hängen vom PK ab → 3NF erfüllt)
```

### PRODUKT_BESTELLUNG
```
id_produkt_bestellung → produkt_id, bestellung_nr, menge
(Alle Attribute hängen vom PK ab → 3NF erfüllt)

Hinweis: produkt_id und bestellung_nr sind gemeinsam auch eindeutig,
aber id_produkt_bestellung ist expliziter PK für einfachere Indexierung.
```

---

## 9. Abfrage-Beispiele (Relational Algebra)

### Q1: Alle Bestellungen eines Kunden

**SQL:**
```sql
SELECT kb.bestellung_bestellnummer
FROM kunde_has_bestellung kb
WHERE kb.kunde_id_kunde = 1;
```

**Relational Algebra:**
```
π bestellnummer (σ kunde_id=1 (KUNDE_HAS_BESTELLUNG))
```

### Q2: Alle Produkte in einer Bestellung mit Menge

**SQL:**
```sql
SELECT p.id_produkt, p.name, pb.menge
FROM produkt_bestellung pb
JOIN produkt p ON pb.produkt_id_produkt = p.id_produkt
WHERE pb.bestellung_bestellnummer = 1;
```

**Relational Algebra:**
```
π id_produkt, name, menge (
  σ bestellnummer=1 (PRODUKT_BESTELLUNG) 
  ⋈ PRODUKT
)
```

### Q3: Umsatz pro Kunde (JOIN mit Aggregate)

**SQL:**
```sql
SELECT k.id_kunde, k.name, SUM(p.preis * pb.menge) as umsatz
FROM kunde k
JOIN kunde_has_bestellung khb ON k.id_kunde = khb.kunde_id_kunde
JOIN produkt_bestellung pb ON khb.bestellung_bestellnummer = pb.bestellung_bestellnummer
JOIN produkt p ON pb.produkt_id_produkt = p.id_produkt
GROUP BY k.id_kunde, k.name;
```

**Relational Algebra:**
```
π id_kunde, name, SUM(preis*menge) (
  KUNDE ⋈ KUNDE_HAS_BESTELLUNG 
         ⋈ PRODUKT_BESTELLUNG 
         ⋈ PRODUKT
)
GROUP BY id_kunde, name
```

---

## 10. Schema-Qualitätsmetriken

| Metrik | Wert | Status |
|--------|------|--------|
| Anzahl Tabellen | 6 | ✅ |
| Anzahl Entitäten | 4 | ✅ |
| Anzahl N:M-Beziehungen | 3 | ✅ |
| Normalisierungsstufe | 3NF | ✅ |
| PK-Redundanz | Keine | ✅ |
| Transitive Dependencies | Keine | ✅ |
| Anomalien-Freiheit | Ja | ✅ |
| Referenzielle Integrität | Vollständig | ✅ |

---

## 11. Datenbankgröße (nach Befüllung)

| Tabelle | Zeilen | Größe (approx.) |
|---------|--------|-----------------|
| standort | 40 | ~2 KB |
| kunde | 40 | ~2 KB |
| bestellung | 40 | ~1 KB |
| produkt | 40 | ~2 KB |
| standort_has_kunde | 40 | ~1 KB |
| kunde_has_bestellung | ~60 | ~2 KB |
| produkt_bestellung | 80 | ~2 KB |
| **GESAMT** | **340** | **~12 KB** |

