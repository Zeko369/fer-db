INSERT INTO vrstajedinice (sifravrstajedinica, naziv) VALUES (1, 'Default');
INSERT INTO jedinica (sifrajedinica, naziv, sifravrstajedinica)  VALUES (1, 'Fer', 1);
INSERT INTO mjesto (siframjesto, postanskibroj, naziv, sifrajedinica) VALUES (1, 10000, 'Zagreb', 1);

INSERT INTO funkcija (sifrafunckija, nazivfunkcija) VALUES (1, 'default');

INSERT INTO osoba (SifraOsoba, Ime, Prezime, OIB, SifraMjesto) VALUES (1, 'Foo', 'Bar', '01234567891', 1);

INSERT INTO birackomjesto (sifrabirackomjesto, naziv, sifrajedinica, siframjesto) VALUES (1, 'Fer D1', 1, 1);
INSERT INTO birackomjesto (sifrabirackomjesto, naziv, sifrajedinica, siframjesto) VALUES (2, 'Fer D2', 1, 1);

INSERT INTO imenovanje (sifraimenovanje, datum, sifrafunckija, sifraosoba, sifrabirackomjesto) VALUES (1, now(), 1, 1, 1);
INSERT INTO imenovanje (sifraimenovanje, datum, sifrafunckija, sifraosoba, sifrabirackomjesto) VALUES (2, now(), 1, 1, 2);

-- This one throws an error
INSERT INTO imenovanje (sifraimenovanje, datum, sifrafunckija, sifraosoba, sifrabirackomjesto) VALUES (3, now(), 1, 1, 1);


-- pass
INSERT INTO termin (vrijemepocetka, vrijemezavrsetka, sifrabirackomjesto) VALUES ('7:00'::TIME, '18:00'::TIME, 1);
-- all fail
INSERT INTO termin (vrijemepocetka, vrijemezavrsetka, sifrabirackomjesto) VALUES ('6:00'::TIME, '18:00'::TIME, 1);
INSERT INTO termin (vrijemepocetka, vrijemezavrsetka, sifrabirackomjesto) VALUES ('8:00'::TIME, '21:00'::TIME, 1);
INSERT INTO termin (vrijemepocetka, vrijemezavrsetka, sifrabirackomjesto) VALUES ('18:00'::TIME, '9:00'::TIME, 1);

-- fail uniqueness constraint
INSERT INTO termin (vrijemepocetka, vrijemezavrsetka, sifrabirackomjesto) VALUES ('9:00'::TIME, '18:00'::TIME, 1);
INSERT INTO termin (vrijemepocetka, vrijemezavrsetka, sifrabirackomjesto) VALUES ('7:00'::TIME, '17:00'::TIME, 1);
