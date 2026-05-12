# Relationenmodell – IT-Dienstleister Verwaltung

## 1. Formale Relation (Relationale Algebra)

```
STANDORT (id_ort, bundesland, stadt, plz, strasse, hausnummer)
   PK: id_ort
   
KUNDE (id_kunde, name, branche, kundennummer)
   PK: id_kunde
   
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

## 2. SQL DDL Schema

```sql
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

CREATE TABLE kunde (
    id_kunde INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45),
    branche VARCHAR(45),
    kundennummer VARCHAR(45)
);

CREATE TABLE standort_has_kunde (
    id_standort_has_kunde INT AUTO_INCREMENT PRIMARY KEY,
    standort_id_ort INT,
    kunde_id_kunde INT,
    FOREIGN KEY (standort_id_ort) REFERENCES standort(id_ort),
    FOREIGN KEY (kunde_id_kunde) REFERENCES kunde(id_kunde)
);

CREATE TABLE kunde_has_bestellung (
    id_kunde_has_bestellung INT AUTO_INCREMENT PRIMARY KEY,
    kunde_id_kunde INT,
    bestellung_bestellnummer INT,
    FOREIGN KEY (kunde_id_kunde) REFERENCES kunde(id_kunde),
    FOREIGN KEY (bestellung_bestellnummer) REFERENCES bestellung(bestellnummer)
);

CREATE TABLE produkt_bestellung (
    id_produkt_bestellung INT AUTO_INCREMENT PRIMARY KEY,
    produkt_id_produkt INT,
    bestellung_bestellnummer INT,
    menge INT,
    FOREIGN KEY (produkt_id_produkt) REFERENCES produkt(id_produkt),
    FOREIGN KEY (bestellung_bestellnummer) REFERENCES bestellung(bestellnummer)
);
```

---

## 3. Beziehungsdiagramm

```
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
        │
        ▼
┌──────────────────────────────┐         ┌──────────────────┐
│ STANDORT_HAS_KUNDE (N:M)     │         │     KUNDE        │
├──────────────────────────────┤         ├──────────────────┤
│ PK: id_standort_has_kunde    │         │ PK: id_kunde     │
│ FK: standort_id_ort ─────────┼────────►│                  │
│ FK: kunde_id_kunde ──────────┼────────►│ • name           │
└──────────────────────────────┘         │ • branche        │
                                         │ • kundennummer   │
                                         └──────────────────┘
                                                 │ 1
                                                 │
                                                 ▼
                                         ┌──────────────────────────────┐
                                         │ KUNDE_HAS_BESTELLUNG (N:M)   │
                                         ├──────────────────────────────┤
                                         │ PK: id_kunde_has_best...     │
                                         │ FK: kunde_id_kunde ──────────┼──► KUNDE
                                         │ FK: bestellung_best... ──────┼──────┐
                                         └──────────────────────────────┘      │
                                                 │ 1                           │
                                                 │                            │
                                                 ▼                            │
                                         ┌──────────────────┐                 │
                                         │   BESTELLUNG     │                 │
                                         ├──────────────────┤                 │
                                         │ PK: bestellnumer │◄────────────────┘
                                         └──────────────────┘
                                                 │ 1
                                                 │
                                                 ▼
                                         ┌──────────────────────────────┐
                                         │ PRODUKT_BESTELLUNG (N:M)     │
                                         ├──────────────────────────────┤
                                         │ PK: id_produkt_bestellung    │
                                         │ FK: produkt_id_produkt ──────┼──► PRODUKT
                                         │ FK: bestellung_best... ──────┼──► BESTELLUNG
                                         │ • menge                      │
                                         └──────────────────────────────┘
                                                 │ N
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

## 4. Attribut-Spezifikation

| Tabelle | Attribut | Typ | PK | FK | Constraint |
|---------|----------|-----|----|----|------------|
| **STANDORT** | id_ort | INT | ✅ | | AUTO_INCREMENT |
| | bundesland | VARCHAR(45) | | | |
| | stadt | VARCHAR(45) | | | |
| | plz | INT | | | |
| | strasse | VARCHAR(45) | | | |
| | hausnummer | INT | | | |
| **KUNDE** | id_kunde | INT | ✅ | | AUTO_INCREMENT |
| | name | VARCHAR(45) | | | |
| | branche | VARCHAR(45) | | | |
| | kundennummer | VARCHAR(45) | | | UNIQUE |
| **BESTELLUNG** | bestellnummer | INT | ✅ | | AUTO_INCREMENT |
| **PRODUKT** | id_produkt | INT | ✅ | | AUTO_INCREMENT |
| | name | VARCHAR(45) | | | |
| | preis | DECIMAL(10,2) | | | |
| **STANDORT_HAS_KUNDE** | id_standort_has_kunde | INT | ✅ | | AUTO_INCREMENT |
| | standort_id_ort | INT | | ✅ | FK → standort.id_ort |
| | kunde_id_kunde | INT | | ✅ | FK → kunde.id_kunde |
| **KUNDE_HAS_BESTELLUNG** | id_kunde_has_bestellung | INT | ✅ | | AUTO_INCREMENT |
| | kunde_id_kunde | INT | | ✅ | FK → kunde.id_kunde |
| | bestellung_bestellnummer | INT | | ✅ | FK → bestellung.bestellnummer |
| **PRODUKT_BESTELLUNG** | id_produkt_bestellung | INT | ✅ | | AUTO_INCREMENT |
| | produkt_id_produkt | INT | | ✅ | FK → produkt.id_produkt |
| | bestellung_bestellnummer | INT | | ✅ | FK → bestellung.bestellnummer |
| | menge | INT | | | |

---

## 5. Tabellenbeziehungen (Kardinalität)

| Beziehung | Kardinalität | Beschreibung |
|-----------|--------------|-------------|
| STANDORT ↔ KUNDE | M:N | Ein Standort hat viele Kunden; ein Kunde hat viele Standorte |
| KUNDE ↔ BESTELLUNG | M:N | Ein Kunde hat viele Bestellungen; eine Bestellung gehört zu einem Kunden |
| PRODUKT ↔ BESTELLUNG | M:N | Ein Produkt in vielen Bestellungen; eine Bestellung hat viele Produkte |

