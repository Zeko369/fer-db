CREATE TABLE VrstaJedinice
(
    SifraVrstaJedinica INT          NOT NULL,
    Naziv              VARCHAR(200) NOT NULL,

    PRIMARY KEY (SifraVrstaJedinica),
    UNIQUE (Naziv)
);

CREATE TABLE Funkcija
(
    SifraFunckija INT         NOT NULL,
    NazivFunkcija VARCHAR(25) NOT NULL,

    PRIMARY KEY (SifraFunckija)
);

CREATE TABLE Jedinica
(
    SifraJedinica             INT          NOT NULL,
    Naziv                     VARCHAR(200) NOT NULL,
    SifraVrstaJedinica        INT          NOT NULL,
    SubJedinica_SifraJedinica INT,

    PRIMARY KEY (SifraJedinica),
    FOREIGN KEY (SifraVrstaJedinica) REFERENCES VrstaJedinice (SifraVrstaJedinica),
    FOREIGN KEY (SubJedinica_SifraJedinica) REFERENCES Jedinica (SifraJedinica),
    UNIQUE (Naziv)
);

CREATE TABLE Mjesto
(
    SifraMjesto   INT          NOT NULL,
    PostanskiBroj INT          NOT NULL,
    Naziv         VARCHAR(100) NOT NULL,
    SifraJedinica INT          NOT NULL,

    PRIMARY KEY (SifraMjesto),
    FOREIGN KEY (SifraJedinica) REFERENCES Jedinica (SifraJedinica)
);

CREATE TABLE BirackoMjesto
(
    SifraBirackoMjesto INT          NOT NULL,
    Naziv              VARCHAR(200) NOT NULL,
    SifraJedinica      INT          NOT NULL,
    SifraMjesto        INT          NOT NULL,

    PRIMARY KEY (SifraBirackoMjesto),
    FOREIGN KEY (SifraJedinica) REFERENCES Jedinica (SifraJedinica),
    FOREIGN KEY (SifraMjesto) REFERENCES Mjesto (SifraMjesto)
);

CREATE TABLE Osoba
(
    SifraOsoba  INT         NOT NULL,
    Ime         VARCHAR(25) NOT NULL,
    Prezime     VARCHAR(25) NOT NULL,
    OIB         CHAR(11)    NOT NULL,
    SifraMjesto INT         NOT NULL,

    PRIMARY KEY (SifraOsoba),
    FOREIGN KEY (SifraMjesto) REFERENCES Mjesto (SifraMjesto),
    UNIQUE (OIB)
);

CREATE TABLE Imenovanje
(
    SifraImenovanje    INT  NOT NULL,
    Datum              DATE NOT NULL,
    SifraFunckija      INT  NOT NULL,
    SifraOsoba         INT  NOT NULL,
    SifraBirackoMjesto INT  NOT NULL,

    CONSTRAINT osobaBmSamoJednom UNIQUE (SifraBirackoMjesto, SifraOsoba),

    FOREIGN KEY (SifraFunckija) REFERENCES Funkcija (SifraFunckija),
    FOREIGN KEY (SifraOsoba) REFERENCES Osoba (SifraOsoba),
    FOREIGN KEY (SifraBirackoMjesto) REFERENCES BirackoMjesto (SifraBirackoMjesto)
);

CREATE TABLE Termin
(
    VrijemePocetka     TIME NOT NULL,
    VrijemeZavrsetka   TIME NOT NULL,
    SifraBirackoMjesto INT  NOT NULL,

    CONSTRAINT chekSatMinPocetakKraj CHECK (
            (VrijemePocetka BETWEEN '07:00'::TIME AND '19:00'::TIME) AND
            (VrijemeZavrsetka BETWEEN '07:00'::TIME AND '19:00'::TIME) AND
            VrijemePocetka < VrijemeZavrsetka
        ),

    CONSTRAINT uniqueTermin UNIQUE (VrijemeZavrsetka, SifraBirackoMjesto),

    PRIMARY KEY (VrijemePocetka, SifraBirackoMjesto),
    FOREIGN KEY (SifraBirackoMjesto) REFERENCES BirackoMjesto (SifraBirackoMjesto)
);

CREATE TABLE Dezurstvo
(
    VrijemePocetka     TIME NOT NULL,
    SifraBirackoMjesto INT  NOT NULL,
    SifraOsoba         INT  NOT NULL,

    PRIMARY KEY (VrijemePocetka, SifraBirackoMjesto, SifraOsoba),
    FOREIGN KEY (VrijemePocetka, SifraBirackoMjesto) REFERENCES Termin (VrijemePocetka, SifraBirackoMjesto),
    FOREIGN KEY (SifraOsoba) REFERENCES Osoba (SifraOsoba)
);