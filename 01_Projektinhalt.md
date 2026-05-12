# Projektinhalt – SAE IT-Dienstleister Verwaltungssystem

## Projekttitel
**Entwicklung einer Datenbank zur Verwaltung von IT-Dienstleistungen und Kundenbeziehungen**

---

## Zweck und Zielsetzung

Das Projekt hat zum Ziel, eine **relationale Datenbank** zu konzipieren und zu implementieren, die IT-Dienstleister befähigt, ihre **Kundenbeziehungen, Standorte, Bestellungen und Produkte/Dienstleistungen zentral zu verwalten**.

### Hauptziele:
1. **Zentrale Verwaltung** von Kunden mit ihren Standorten und Kontaktinformationen
2. **Verfolgung von Bestellungen** und der darin enthaltenen IT-Produkte und Dienstleistungen
3. **Skalierbare Struktur** für N:M-Beziehungen (ein Kunde → viele Bestellungen; eine Bestellung → viele Produkte)
4. **Datenintegrität** durch Fremdschlüssel und relationale Constraints
5. **Basis für Business Intelligence** und Reporting über Kundenverhalten und Umsätze

---

## Auftraggeber

**Fiktiver Auftraggeber:** IT-Dienstleister „TechSolutions GmbH"
- **Geschäftsbereich:** IT-Services, Cloud-Migration, Managed IT Services, Security & Support
- **Anforderung:** Ersatz eines veralteten Excel-basierten Systems durch eine moderne Datenbank

---

## Liefergegenstände (Deliverables)

### Phase 1: Analyse & Design
- ✅ Entity-Relationship-Modell (ERM) – vereinfacht und vollständig
- ✅ Logisches Relationenmodell mit Normalisierung
- ✅ Tabellenspezifikationen und Constraints

### Phase 2: Implementierung
- ✅ **DDL-Skript** (`SAE-Projektarbeit.sql`)
  - Automatisierte Datenbankerstellung
  - Mehrfach ausführbar (idempotent mit `IF NOT EXISTS`)
  - Fremdschlüssel und Integritäts-Constraints

- ✅ **DML-Skript** (`befuellen_beispieldaten.sql`)
  - 40+ Datensätze pro Tabelle
  - Realistische IT-Service-Beispieldaten
  - Konsistente Fremdschlüssel-Referenzen

### Phase 3: Dokumentation
- ✅ Projektplan mit Zeitschätzungen
- ✅ Datenmodell-Dokumentation
- ✅ Schema-Übersicht

---

## Mesbare Erfolgskriterien

| Kriterium | Status | Erfüllt? |
|-----------|--------|----------|
| Mindestens 3 Entitätstypen | 4 Entitäten (standort, bestellung, produkt, kunde) | ✅ |
| Mindestens 1 N:M-Beziehung | 3 N:M-Beziehungen implementiert | ✅ |
| Fehlerfreier SQL-Code | DDL + DML ohne Syntax-Fehler | ✅ |
| Datenbank mehrfach ausführbar | `IF NOT EXISTS` in allen Statements | ✅ |
| Mindestens 40 Zeilen pro Tabelle | 40 Zeilen pro Tabelle | ✅ |
| Konsistente Fremdschlüssel | Alle FK-Referenzen gültig | ✅ |
| Realistische Beispieldaten | IT-Service-fokussierte Daten | ✅ |
| Dokumentation vollständig | ERM, Relationenmodell, Projektplan | ✅ |

---

## Geschäftskontext

### Problemstellung (Vorher)
- Excel-Listen für Kunden, Bestellungen und Produkte
- Manuelle Duplikatprüfung
- Keine zentralen Abfragen möglich
- Fehleranfälligkeit bei Datenänderungen

### Lösung (Nachher)
- **Zentrale Datenbank** mit konsistenten Daten
- **Automatische Integrität** durch Constraints
- **Flexible Abfragen** für Geschäftsanalysen
- **Skalierbarkeit** für wachsende Kundenbasen

### Nutzen
- 📊 Bessere Kundeninsights
- 🚀 Schnellere Bestellverwaltung
- 🔒 Höhere Datensicherheit
- 💰 Reduzierte Verwaltungskosten

---

## Datenbankübersicht

### Entitäten
1. **standort** – Geografische Standorte (PLZ, Stadt, Straße)
2. **kunde** – Kundendaten (Name, Branche, Kundennummer)
3. **bestellung** – Bestellungen (Verweis auf Kunde via Junction)
4. **produkt** – IT-Services und Produkte (Name, Preis)

### N:M-Beziehungen
1. **standort_has_kunde** – Kunde an mehrere Standorte
2. **kunde_has_bestellung** – Kunde hat mehrere Bestellungen
3. **produkt_bestellung** – Bestellung enthält mehrere Produkte

---

## Technische Spezifikation

| Eigenschaft | Wert |
|-------------|------|
| **DBMS** | MySQL 5.7+ |
| **Normalisierung** | 3. Normalform (3NF) |
| **Datensätze (Seed)** | 40 Kunden, 40 Standorte, 40 Produkte, 40 Bestellungen |
| **Beziehungen** | 3 N:M via Junction-Tabellen |
| **Sicherheit** | Fremdschlüssel-Integrität, Constraints |

