--Skript zur Erstellung der Datenbank und Tabellen für das SAE-Projekt

CREATE DATABASE IF NOT EXISTS SAE_PK;
 
USE SAE_PK;
 
CREATE TABLE IF NOT EXISTS standort (
    id_ort INT AUTO_INCREMENT PRIMARY KEY,
    bundesland VARCHAR(45),
    stadt VARCHAR(45),
    plz INT,
    strasse VARCHAR(45),
    hausnummer INT
);
 
CREATE TABLE IF NOT EXISTS bestellung (
    bestellnummer INT AUTO_INCREMENT PRIMARY KEY
);
 
CREATE TABLE IF NOT EXISTS produkt (
    id_produkt INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45),
    preis DECIMAL(10,2)
);
 
CREATE TABLE IF NOT EXISTS kunde (
    id_kunde INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(45),
    branche VARCHAR(45),
    kundennummer VARCHAR(45),
    bestellung_bestellnummer INT,
    FOREIGN KEY (bestellung_bestellnummer) REFERENCES bestellung(bestellnummer)
);
 
CREATE TABLE IF NOT EXISTS standort_has_kunde (
    id_standort_has_kunde INT AUTO_INCREMENT PRIMARY KEY,
    standort_id_ort INT,
    kunde_id_kunde INT,
    FOREIGN KEY (standort_id_ort) REFERENCES standort(id_ort),
    FOREIGN KEY (kunde_id_kunde) REFERENCES kunde(id_kunde)
);
 
CREATE TABLE IF NOT EXISTS produkt_bestellung (
    id_produkt_bestellung INT AUTO_INCREMENT PRIMARY KEY,
    produkt_id_produkt INT,
    bestellung_bestellnummer INT,
    menge INT,
    FOREIGN KEY (produkt_id_produkt) REFERENCES produkt(id_produkt),
    FOREIGN KEY (bestellung_bestellnummer) REFERENCES bestellung(bestellnummer)
);