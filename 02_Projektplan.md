# Projektplan – SAE IT-Dienstleister Datenbank

## 1. Projektübersicht

**Projektname:** Datenbank für IT-Dienstleister Verwaltung  
**Projektstart:** 12.05.2026  
**Projektende (geplant):** 26.05.2026  
**Gesamtdauer:** 2 Wochen  
**Projektleiter:** SAE-Team  
**Status:** In Bearbeitung

---

## 2. Projektstruktur (Phasen & Meilensteine)

```
PHASE 1: Anforderungsanalyse & Design (Tage 1-3)
    │
    ├─ Anforderungen sammeln
    ├─ Geschäftsprozesse definieren
    ├─ ERM entwickeln
    └─ Meilenstein 1: Design genehmigt ✓

PHASE 2: Implementierung (Tage 4-8)
    │
    ├─ DDL-Skript erstellen
    ├─ Datenmodell normalisieren
    ├─ Constraints & Fremdschlüssel testen
    └─ Meilenstein 2: Datenbank funktional ✓

PHASE 3: Daten & Tests (Tage 9-11)
    │
    ├─ DML-Skript (Beispieldaten) entwickeln
    ├─ Referenzielle Integrität prüfen
    ├─ Load-Tests durchführen
    └─ Meilenstein 3: Daten erfolgreich geladen ✓

PHASE 4: Dokumentation (Tage 12-14)
    │
    ├─ Relationenmodell dokumentieren
    ├─ Projektplan finalisieren
    ├─ README & Use Cases erstellen
    └─ Meilenstein 4: Dokumentation abgeschlossen ✓
```

---

## 3. Zeitplan mit Aufwandsschätzung

| Aktivität | Dauer | Aufwand (h) | Verantwortung | Status |
|-----------|-------|------------|---------------|--------|
| **Anforderungen analysieren** | 1 Tag | 3h | Analyst | ✅ |
| **ERM entwerfen** | 1 Tag | 4h | DB-Designer | ✅ |
| **Relationenmodell erstellen** | 1 Tag | 3h | DB-Designer | ✅ |
| **DDL-Skript kodieren** | 2 Tage | 6h | SQL-Developer | ✅ |
| **Normalisierung & Constraints** | 1 Tag | 4h | SQL-Developer | ✅ |
| **DML-Befüllung konzipieren** | 1 Tag | 3h | Data-Analyst | ✅ |
| **Beispieldaten einfügen** | 1 Tag | 4h | Data-Analyst | ✅ |
| **Integritäts-Tests** | 1 Tag | 3h | QA-Tester | ✅ |
| **Performance-Tests** | 1 Tag | 2h | QA-Tester | ✅ |
| **Dokumentation schreiben** | 2 Tage | 5h | Technical Writer | ⏳ |
| **Code-Review & Finalisierung** | 1 Tag | 2h | Lead | ⏳ |
| **→ GESAMT** | **14 Tage** | **39h** | - | - |

---

## 4. Critical Path (Kritischer Pfad)

Der kritische Pfad bestimmt die Projektdauer:

```
Anforderungen → ERM → Relationenmodell → DDL → DML → Tests → Dokumentation
    (1d)      (1d)       (1d)          (2d)  (2d)  (2d)      (2d)
    ══════════════════════════════════════════════════════════════════
                          KRITISCHER PFAD: 11 Tage
```

**Kritische Aktivitäten (keine Puffer):**
- ERM-Design
- DDL-Implementierung
- Daten-Integration
- Integritäts-Tests

---

## 5. Ressourcen & Projektmitarbeiter

### Team-Zusammensetzung

| Rolle | Name | Allokation | Verantwortung |
|-------|------|-----------|-----------------|
| **Projektleiter** | SAE-Mentor | 20% | Koordination, Timing |
| **DB-Designer** | SAE-Student | 100% | ERM, Datenmodell, Normalisierung |
| **SQL-Developer** | SAE-Student | 100% | DDL, Constraints, Fremdschlüssel |
| **Data-Analyst** | SAE-Student | 80% | DML, Beispieldaten, Validierung |
| **QA-Tester** | SAE-Student | 50% | Tests, Konsistenzprüfung |
| **Technical Writer** | SAE-Student | 30% | Dokumentation |

### Know-How-Anforderungen
- Grundkenntnisse SQL (DDL, DML, Constraints)
- Datenbank-Design (ERM, Normalisierung)
- MySQL / Relationale Modelle
- Dokumentationsfähigkeit

---

## 6. Abhängigkeiten & Reihenfolge

```
┌─────────────────────────────────────────────────────┐
│ Anforderungen & Geschäftsprozesse                   │
│ (Was muss die DB können?)                           │
└────────────────┬────────────────────────────────────┘
                 │ MUSS ABGESCHLOSSEN SEIN
                 ▼
┌─────────────────────────────────────────────────────┐
│ Entity-Relationship-Modell (ERM)                    │
│ (Wie sehen die Daten strukturiert aus?)             │
└────────────────┬────────────────────────────────────┘
                 │ MUSS ABGESCHLOSSEN SEIN
                 ▼
┌─────────────────────────────────────────────────────┐
│ Relationenmodell & Normalisierung                   │
│ (SQL-Table-Schema mit Constraints)                  │
└────────────────┬────────────────────────────────────┘
                 │ MUSS ABGESCHLOSSEN SEIN
                 ▼
         ┌───────┴────────┐
         ▼                ▼
    ┌─────────────┐  ┌──────────────┐
    │ DDL-Skript  │  │ DML-Konzept  │
    │ (CREATE)    │  │ (INSERT)     │
    └──────┬──────┘  └────────┬─────┘
           └────────────┬─────┘
                        ▼
            ┌─────────────────────────┐
            │ Testen & Validieren     │
            │ (Integrität, Konsistenz)│
            └──────────┬──────────────┘
                       │
                       ▼
            ┌─────────────────────────┐
            │ Dokumentation           │
            │ (README, Modelle)       │
            └─────────────────────────┘
```

---

## 7. Risikoanalyse & Mitigation

| Risiko | Wahrscheinlichkeit | Impact | Mitigation |
|--------|-------------------|--------|------------|
| **Anforderungen unklar** | Mittel | Hoch | Frühe Requirements-Workshops |
| **Performance-Probleme** | Niedrig | Mittel | Frühe Index-Planung, Load-Tests |
| **Datenqualität schlecht** | Niedrig | Hoch | Validierungsskripte, QA-Tests |
| **Ressourcen-Engpässe** | Niedrig | Mittel | Flexible Terminplanung |
| **Scope-Creep** | Mittel | Mittel | Strict Change Control |

---

## 8. Meilensteine & Go/No-Go Kriterien

### Meilenstein 1: Design genehmigt (Tag 3)
- ✅ ERM vollständig und verifiziert
- ✅ Relationenmodell mit Normalisierung
- ✅ Alle Entitäten und Beziehungen definiert
- **Go-Kriterium:** Design-Review erfolgreich

### Meilenstein 2: Datenbank funktional (Tag 8)
- ✅ DDL-Skript syntaktisch korrekt
- ✅ Alle Tabellen erstellt und getestet
- ✅ Fremdschlüssel funktionieren
- **Go-Kriterium:** `USE SAE_PK; SHOW TABLES;` listet alle 6 Tabellen

### Meilenstein 3: Daten erfolgreich geladen (Tag 11)
- ✅ DML-Skript lädt 40+ Zeilen pro Tabelle
- ✅ Keine Integrität-Verletzungen
- ✅ Abfragen funktionieren
- **Go-Kriterium:** `SELECT COUNT(*) FROM kunde;` = 40+

### Meilenstein 4: Dokumentation abgeschlossen (Tag 14)
- ✅ ERM, Relationenmodell, Projektplan
- ✅ README und Use Cases
- ✅ Code-Review erfolgreich
- **Go-Kriterium:** Alle Deliverables vorhanden

---

## 9. Kommunikationsplan

| Format | Häufigkeit | Teilnehmer | Inhalte |
|--------|-----------|-----------|---------|
| **Kickoff-Meeting** | 1x | Alle | Ziele, Rollen, Zeitplan |
| **Daily Standup** | Täglich (15 Min) | Team | Status, Blocker, nächste Schritte |
| **Design-Review** | 1x (Tag 3) | Lead + Team | ERM-Freigabe |
| **Testing-Review** | 1x (Tag 11) | QA + Dev | Test-Ergebnisse |
| **Final Walkthrough** | 1x (Tag 13) | Alle | Abnahmekriterien |

---

## 10. Annahmen & Constraints

### Annahmen
- MySQL 5.7+ ist verfügbar
- SQL-Kenntnisse vorhanden
- Keine zusätzlichen Sicherheitsanforderungen (keine Verschlüsselung, etc.)
- Datenbank ist für Entwicklung/Test, nicht Produktion

### Constraints
- Maximale Projektdauer: 2 Wochen
- Maximales Budget: Keine Lizenzkosten
- Kein Zugriff auf externe Systeme nötig
- Relationale DB ohne NoSQL-Anforderungen

---

## 11. Success Criteria (Erfolgsmessung)

Projekt gilt als **erfolgreich**, wenn:
- ✅ Alle 6 Tabellen mit Fremdschlüsseln erstellt
- ✅ Mindestens 3 N:M-Beziehungen implementiert
- ✅ 40+ Datensätze pro Tabelle erfolgreich geladen
- ✅ DDL + DML Skripte mehrfach ausführbar
- ✅ Alle Dokumentationen vorliegen
- ✅ Kein offene Defects kritischer Priorität

**Geplanter Abschluss:** 26.05.2026

