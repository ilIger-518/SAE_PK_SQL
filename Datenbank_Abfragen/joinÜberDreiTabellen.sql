SELECT kunde.name, bestellung.bestellnummer, produkt_bestellung.menge 
FROM kunde, bestellung, produkt_bestellung 
WHERE kunde.bestellung_bestellnummer = bestellung.bestellnummer AND bestellung.bestellnummer = produkt_bestellung.bestellung_bestellnummer;