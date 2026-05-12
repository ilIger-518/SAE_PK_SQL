# Entity-Relationship-Modell (ERM) – IT-Dienstleister Verwaltung

## 1. Vereinfachtes ERM (High-Level)

```
                    ┌──────────────┐
                    │   STANDORT   │
                    │              │
                    │ - id_ort (PK)│
                    │ - stadt      │
                    │ - plz        │
                    └──────┬───────┘
                           │ N
                           │ (1:N)
                           │
                  ┌────────────────────┐
                  │ STANDORT_HAS_KUNDE │
                  │  (Junction-Table)  │
                  └────────┬───────────┘
                           │
                           │ M
                           │ (M:N)
                           │
        ┌──────────────────┴──────────────────┐
        │                                     │
        │ 1                                   │ N
        │                                     │
    ┌───────────┐                    ┌──────────────┐
    │  KUNDE    │                    │  BESTELLUNG  │
    │           │                    │              │
    │ - id_ku.. │                    │ - bestell..  │
    │ - name    │                    │              │
    │ - branche │                    └──────┬───────┘
    │ - kundenr │                           │
    └───────────┘                           │ N
        │                                   │
        │ N                                 │
        │ (M:N via                          │
        │ Junction)                         │
        │                                   │
        └─────────────────┬─────────────────┘
                          │
               ┌──────────────────────┐
               │ KUNDE_HAS_BESTELLUNG │
               │  (Junction-Table)    │
               └──────────┬───────────┘
                          │
                          │ M
                          │
                  ┌───────────────┐
                  │   PRODUKT     │
                  │               │
                  │ - id_produkt  │
                  │ - name        │
                  │ - preis       │
                  └───────┬───────┘
                          │ N
                          │ (M:N)
                          │
               ┌──────────────────────┐
               │ PRODUKT_BESTELLUNG   │
               │  (Junction-Table)    │
               └──────────────────────┘
```

---

## 2. Detailliertes ERM (Chen-Notation)

```
                     ┌─────────────────────────┐
                     │      STANDORT           │
                     ├─────────────────────────┤
                     │ ⓟ id_ort (INT, AI, PK) │
                     │   bundesland (VARCHAR) │
                     │   stadt (VARCHAR)      │
                     │   plz (INT)            │
                     │   strasse (VARCHAR)    │
                     │   hausnummer (INT)     │
                     └──────────┬──────────────┘
                                │
                         (1 Standort : N Kunden)
                                │
        ┌───────────────────────┼───────────────────────┐
        │                       │                       │
        │           ┌─────────────────────────────┐    │
        │           │   STANDORT_HAS_KUNDE        │    │
        │           ├─────────────────────────────┤    │
        │           │ ⓟ id_standort_has_kunde     │    │
        │           │ ⓕ standort_id_ort (FK)     │    │
        │           │ ⓕ kunde_id_kunde (FK)      │    │
        │           └─────────────────────────────┘    │
        │                       │                       │
        └───────────────────────┼───────────────────────┘
                                │
                        (N Kunden : N Standorte)
                                │
        ┌───────────────────────┘
        │
        │                   ┌────────────────────────┐
        │                   │      KUNDE             │
        │                   ├────────────────────────┤
        │                   │ ⓟ id_kunde (INT, AI)   │
        │                   │   name (VARCHAR)       │
        │                   │   branche (VARCHAR)    │
        │                   │   kundennummer (VAR)   │
        │                   └──────────┬─────────────┘
        │                              │
        │                      (1 Kunde : N Bestellungen)
        │                              │
        │              ┌───────────────────────────────┐
        │              │   KUNDE_HAS_BESTELLUNG        │
        │              ├───────────────────────────────┤
        │              │ ⓟ id_kunde_has_bestellung    │
        │              │ ⓕ kunde_id_kunde (FK)        │
        │              │ ⓕ bestellung_bestellnummer   │
        │              │   (FK)                        │
        │              └───────────────────────────────┘
        │                              │
        └──────────────────────────────┘
                                │
                        (N Kunden : N Bestellungen)
                                │
                   ┌────────────────────────────────┐
                   │      BESTELLUNG                │
                   ├────────────────────────────────┤
                   │ ⓟ bestellnummer (INT, AI, PK) │
                   └────────────┬───────────────────┘
                                │
                        (1 Bestellung : N Produkte)
                                │
                   ┌────────────────────────────────┐
                   │   PRODUKT_BESTELLUNG           │
                   ├────────────────────────────────┤
                   │ ⓟ id_produkt_bestellung        │
                   │ ⓕ produkt_id_produkt (FK)     │
                   │ ⓕ bestellung_bestellnummer    │
                   │   (FK)                         │
                   │   menge (INT)                  │
                   └────────────────────────────────┘
                                │
                        (N Produkte : N Bestellungen)
                                │
                   ┌────────────────────────────────┐
                   │      PRODUKT                   │
                   ├────────────────────────────────┤
                   │ ⓟ id_produkt (INT, AI, PK)    │
                   │   name (VARCHAR)               │
                   │   preis (DECIMAL 10,2)         │
                   └────────────────────────────────┘

Legend:
ⓟ = Primary Key
ⓕ = Foreign Key
AI = Auto_Increment
FK = Foreign Key Reference
```

---

## 3. Kardinalitäten & Beziehungen

### Beziehung 1: Standort ↔ Kunde (M:N)
```
STANDORT (1) ────────→ STANDORT_HAS_KUNDE (N) ←──────── KUNDE (1)

Semantik:
- Ein Standort kann mehreren Kunden zugeordnet sein
- Ein Kunde kann mehrere Standorte haben
- Kardinalität: 1:N:M
- Beispiel: Kunde "Alpha Office GmbH" hat Büros in München und Frankfurt
```

### Beziehung 2: Kunde ↔ Bestellung (M:N)
```
KUNDE (1) ────────→ KUNDE_HAS_BESTELLUNG (N) ←──────── BESTELLUNG (1)

Semantik:
- Ein Kunde kann mehrere Bestellungen aufgeben
- Eine Bestellung gehört zu einem Kunde
- Kardinalität: 1:N (aber strukturell als M:N via Junction)
- Beispiel: Alpha Office mit Bestellungen 1, 5, 21 aus Büros in München/Frankfurt
```

### Beziehung 3: Produkt ↔ Bestellung (M:N)
```
PRODUKT (1) ────────→ PRODUKT_BESTELLUNG (N) ←──────── BESTELLUNG (1)

Semantik:
- Ein Produkt kann in vielen Bestellungen vorkommen
- Eine Bestellung kann mehrere Produkte enthalten
- Kardinalität: M:N
- Beispiel: Bestellung 1 enthält "Remote Support" und "Backup Einrichtung"
```

---

## 4. Attribut-Definitionen

### Tabelle: STANDORT
| Attribut | Typ | PK | FK | Constraint | Bedeutung |
|----------|-----|----|----|------------|-----------|
| id_ort | INT | ✅ | | AUTO_INCREMENT | Eindeutige Standort-ID |
| bundesland | VARCHAR(45) | | | | Deutsches Bundesland |
| stadt | VARCHAR(45) | | | NOT NULL | Stadtname |
| plz | INT | | | | Postleitzahl |
| strasse | VARCHAR(45) | | | | Straßenname |
| hausnummer | INT | | | | Hausnummer |

### Tabelle: KUNDE
| Attribut | Typ | PK | FK | Constraint | Bedeutung |
|----------|-----|----|----|------------|-----------|
| id_kunde | INT | ✅ | | AUTO_INCREMENT | Eindeutige Kunden-ID |
| name | VARCHAR(45) | | | NOT NULL | Kundenname |
| branche | VARCHAR(45) | | | | Industriebranche |
| kundennummer | VARCHAR(45) | | | UNIQUE | Externe Kundennummer |

### Tabelle: BESTELLUNG
| Attribut | Typ | PK | FK | Constraint | Bedeutung |
|----------|-----|----|----|------------|-----------|
| bestellnummer | INT | ✅ | | AUTO_INCREMENT | Eindeutige Bestellnummer |

### Tabelle: PRODUKT
| Attribut | Typ | PK | FK | Constraint | Bedeutung |
|----------|-----|----|----|------------|-----------|
| id_produkt | INT | ✅ | | AUTO_INCREMENT | Eindeutige Produkt-ID |
| name | VARCHAR(45) | | | NOT NULL | Produktname |
| preis | DECIMAL(10,2) | | | | Produktpreis (€) |

### Tabelle: STANDORT_HAS_KUNDE (Junction)
| Attribut | Typ | PK | FK | Constraint | Bedeutung |
|----------|-----|----|----|------------|-----------|
| id_standort_has_kunde | INT | ✅ | | AUTO_INCREMENT | Junction-ID |
| standort_id_ort | INT | | ✅ | FK → standort.id_ort | Referenz Standort |
| kunde_id_kunde | INT | | ✅ | FK → kunde.id_kunde | Referenz Kunde |

### Tabelle: KUNDE_HAS_BESTELLUNG (Junction)
| Attribut | Typ | PK | FK | Constraint | Bedeutung |
|----------|-----|----|----|------------|-----------|
| id_kunde_has_bestellung | INT | ✅ | | AUTO_INCREMENT | Junction-ID |
| kunde_id_kunde | INT | | ✅ | FK → kunde.id_kunde | Referenz Kunde |
| bestellung_bestellnummer | INT | | ✅ | FK → bestellung.bestellnummer | Referenz Bestellung |

### Tabelle: PRODUKT_BESTELLUNG (Junction)
| Attribut | Typ | PK | FK | Constraint | Bedeutung |
|----------|-----|----|----|------------|-----------|
| id_produkt_bestellung | INT | ✅ | | AUTO_INCREMENT | Junction-ID |
| produkt_id_produkt | INT | | ✅ | FK → produkt.id_produkt | Referenz Produkt |
| bestellung_bestellnummer | INT | | ✅ | FK → bestellung.bestellnummer | Referenz Bestellung |
| menge | INT | | | | Bestellmenge |

---

## 5. Integritätsbedingungen

### Referenzielle Integrität
```sql
-- STANDORT_HAS_KUNDE
ALTER TABLE standort_has_kunde 
ADD CONSTRAINT fk_shk_standort FOREIGN KEY (standort_id_ort) 
REFERENCES standort(id_ort) ON DELETE CASCADE;

ALTER TABLE standort_has_kunde 
ADD CONSTRAINT fk_shk_kunde FOREIGN KEY (kunde_id_kunde) 
REFERENCES kunde(id_kunde) ON DELETE CASCADE;

-- KUNDE_HAS_BESTELLUNG
ALTER TABLE kunde_has_bestellung 
ADD CONSTRAINT fk_khb_kunde FOREIGN KEY (kunde_id_kunde) 
REFERENCES kunde(id_kunde) ON DELETE CASCADE;

ALTER TABLE kunde_has_bestellung 
ADD CONSTRAINT fk_khb_bestellung FOREIGN KEY (bestellung_bestellnummer) 
REFERENCES bestellung(bestellnummer) ON DELETE CASCADE;

-- PRODUKT_BESTELLUNG
ALTER TABLE produkt_bestellung 
ADD CONSTRAINT fk_pb_produkt FOREIGN KEY (produkt_id_produkt) 
REFERENCES produkt(id_produkt) ON DELETE CASCADE;

ALTER TABLE produkt_bestellung 
ADD CONSTRAINT fk_pb_bestellung FOREIGN KEY (bestellung_bestellnummer) 
REFERENCES bestellung(bestellnummer) ON DELETE CASCADE;
```

### Domänen-Integrität
- `plz` muss numerisch sein (INT)
- `preis` muss >= 0 sein (DECIMAL mit Constraint)
- `kundennummer` muss eindeutig sein (UNIQUE)

### Entity-Integrität
- Alle PRIMARY KEYs sind NOT NULL
- Alle PRIMARY KEYs sind UNIQUE

---

## 6. Beziehungstabellen (N:M Decomposition)

Normalisierung der drei N:M-Beziehungen:

```
❌ FALSCH (vor Normalisierung):
┌─────────────────────────────┐
│ KUNDE                       │
├─────────────────────────────┤
│ - id_kunde                  │
│ - name                      │
│ - standort_ids (Array?)     │  ← Problem: Mehrwertig
│ - bestellung_ids (Array?)   │  ← Problem: Mehrwertig
└─────────────────────────────┘

✅ RICHTIG (nach Normalisierung):
┌──────────────────────┐      ┌──────────────────────┐
│ KUNDE                │      │ STANDORT_HAS_KUNDE   │
├──────────────────────┤      ├──────────────────────┤
│ - id_kunde (PK)      │◄────►│ - kunde_id (FK)      │
│ - name               │      │ - standort_id (FK)   │
└──────────────────────┘      └──────────────────────┘
                                      ▲
                                      │
                              ┌──────────────────────┐
                              │ STANDORT             │
                              ├──────────────────────┤
                              │ - id_ort (PK)        │
                              │ - stadt              │
                              │ - plz                │
                              └──────────────────────┘
```

---

## 7. Geschäftsregeln (Business Rules)

### Regel 1: Kunde-Standort-Zuordnung
> "Ein Kunde MUSS mindestens einen Standort haben; ein Standort kann mehrere Kunden haben."

**Implementierung:** Fremdschlüssel in `standort_has_kunde`

### Regel 2: Kunden-Bestellungen
> "Ein Kunde kann mehrere Bestellungen haben; eine Bestellung gehört zu genau einem Kunden."

**Implementierung:** `kunde_has_bestellung` Junction-Tabelle

### Regel 3: Bestellungs-Produkte
> "Eine Bestellung MUSS mindestens ein Produkt enthalten; ein Produkt kann in vielen Bestellungen vorkommen."

**Implementierung:** `produkt_bestellung` mit Menge-Attribut

### Regel 4: Eindeutige Kundennummer
> "Jede Kundennummer ist einmalig in der Datenbank."

**Implementierung:** `UNIQUE` Constraint auf `kundennummer`

---

## 8. Verwendungsbeispiele (Use Cases)

### Use Case 1: Kunde anlegen
```
Aktion: "Alpha Office GmbH" neu als Kunde registrieren
Ablauf:
1. INSERT INTO kunde (name, branche, kundennummer)
2. Erhält neue id_kunde = 1
3. INSERT INTO standort_has_kunde (standort_id, kunde_id)
   → Verknüpfe mit München (standort 1)
```

### Use Case 2: Bestellung mit Produkten erstellen
```
Aktion: Alpha Office bestellt "Remote Support" und "Backup"
Ablauf:
1. INSERT INTO bestellung () → Erhält bestellnummer = 1
2. INSERT INTO kunde_has_bestellung (1, 1) → Kunde 1 hat Bestellung 1
3. INSERT INTO produkt_bestellung (1, 1, 2) 
   → Bestellung 1 enthält Produkt 1 (Remote) x2 Stück
4. INSERT INTO produkt_bestellung (10, 1, 1)
   → Bestellung 1 enthält Produkt 10 (Backup) x1 Stück
```

### Use Case 3: Alle Bestellungen eines Kunden abfragen
```sql
SELECT b.bestellnummer, pb.produkt_id, pb.menge
FROM kunde k
JOIN kunde_has_bestellung khb ON k.id_kunde = khb.kunde_id
JOIN produkt_bestellung pb ON khb.bestellung_bestellnummer = pb.bestellung_bestellnummer
WHERE k.id_kunde = 1;
```

