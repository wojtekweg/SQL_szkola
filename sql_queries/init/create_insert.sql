CREATE TABLE Osoby
(
IDOsoby INT IDENTITY(1,1) PRIMARY KEY,
Imię VARCHAR(255) NOT NULL,
Nazwisko VARCHAR(255) NOT NULL,
Telefon VARCHAR(255)
)
INSERT INTO [Osoby](Imię, Nazwisko, Telefon) VALUES
('Wojciech', 'Węgrzyn', '+48 723 147 680'),
('Konrad', 'Nowak', NULL),
('Jakub', 'Łukasiewicz', NULL),
('John', 'Grady', '+01 134 423 423'),
('Adrian', 'Antkiewicz', '+48 534 322'),
('Michał', 'Gem', '+18 332 03 42'),
('Piotr', 'Niemiec', '+12 890 43 54'),
('Edward', 'Szczypka', '+12 345 54 23'),
('Jadwiga', 'Kowal', NULL),
('Iga', 'Świątek', NULL),
('Andrzej', 'Gołota', '+48 543 134 543')
CREATE TABLE ProfileKlas
(
IDProfilu INT IDENTITY(1,1) PRIMARY KEY,
NazwaProfilu VARCHAR(255)
)
INSERT INTO [ProfileKlas](NazwaProfilu) VALUES
('Mat-fiz'),
('Biol-chem'),
('Humanistyczny')
CREATE TABLE Klasy
(
IDKlasy INT IDENTITY(1,1) PRIMARY KEY,
RokRozpoczęcia INT NOT NULL,
LiteraPorządkowa VARCHAR(1),
IDProfilu INT REFERENCES ProfileKlas(IDProfilu) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL
)
INSERT INTO [Klasy](RokRozpoczęcia, LiteraPorządkowa, IDProfilu) VALUES
(2019, 'A', 1),
(2019, 'B', 1),
(2018, 'A', 1),
(2018, 'B', 2),
(2017, NULL, 3)
CREATE TABLE Nauczyciele
(
IDNauczyciela INT REFERENCES Osoby(IDOsoby)
ON UPDATE CASCADE ON DELETE CASCADE PRIMARY KEY,
WychowawcaKlasy INT REFERENCES Klasy(IDKlasy),
DataZatrudnienia DATETIME,
Stawka MONEY
)
INSERT INTO [Nauczyciele]
(IDNauczyciela, WychowawcaKlasy, DataZatrudnienia, Stawka)
VALUES
(4, NULL, GETDATE(), 5400),
(6, NULL, 2012-08-02, 3000),
(7, NULL, 2001-10-11, 15000),
(8, 1, 2013-08-01, 2300),
(9, 2, 2020-01-01, 4500)
CREATE TABLE Uczniowie
(
IDUcznia INT REFERENCES Osoby(IDOsoby) ON UPDATE CASCADE ON DELETE CASCADE PRIMARY KEY,
IDKlasy INT REFERENCES Klasy(IDKlasy) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
)
CREATE TABLE Uwagi
(
IDUwagi INT IDENTITY(1,1) PRIMARY KEY,
IDUcznia INT REFERENCES Uczniowie(IDUcznia) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
OpisUwagi VARCHAR(255),
DataUwagi DATETIME,
PowagaUwagi TINYINT NOT NULL
)
INSERT INTO [Uczniowie] (IDUcznia, IDKlasy) VALUES
(1, 1),
(2, 1),
(3, 1),
(5, 2),
(6, 2),
(10, 3),
(11, 3)
CREATE TABLE SpisPrzedmiotów
(
IDPrzedmiotu INT PRIMARY KEY,
NazwaPrzedmiotu VARCHAR(255)
)
INSERT INTO [SpisPrzedmiotów](IDPrzedmiotu, NazwaPrzedmiotu) VALUES
(1, 'Matematyka'),
(2, 'Informatyka'),
(3, 'Chemia'),
(4, 'Język Polski'),
(5, 'Biologia'),
(6, 'Fizyka')
CREATE TABLE SpisPrzedmiotówFakultatywnych
(
IDPrzedmiotuFakultatywnego INT PRIMARY KEY,
NazwaPrzedmiotu VARCHAR(255)
)
INSERT INTO [SpisPrzedmiotówFakultatywnych](IDPrzedmiotuFakultatywnego, NazwaPrzedmiotu) VALUES
(7, 'Etyka'),
(8, 'Religia')
CREATE TABLE Przedmioty
(
IDtemp INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
IDPrzedmiotu INT REFERENCES SpisPrzedmiotów(IDPrzedmiotu) NOT NULL,
IDNauczyciela INT REFERENCES Nauczyciele(IDNauczyciela)
ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
)
INSERT INTO [Przedmioty](IDPrzedmiotu, IDNauczyciela) VALUES
(1,4),
(2,6),
(3,4),
(4,6),
(5,4),
(6,4)
CREATE TABLE Oceny
(
IDOceny INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
IDUcznia INT REFERENCES Uczniowie(IDUcznia),
Ocena INT NOT NULL,
IDPrzedmiotu INT REFERENCES SpisPrzedmiotów(IDPrzedmiotu)
ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
IDNauczyciela INT REFERENCES Nauczyciele(IDNauczyciela) NOT NULL,
Data DATETIME
)
INSERT INTO [Oceny] (IDUcznia, Ocena, IDPrzedmiotu, IDNauczyciela, Data) VALUES
(1, 4, 1, 4, GETDATE()),
(1, 5, 1, 7, 2021-02-16),
(2, 2, 2, 7, 2021-02-16),
(3, 3, 2, 8, GETDATE()),
(10, 2, 3, 9, 2021-01-05)
CREATE TABLE PrzedmiotyFakultatywne
(
IDtemp INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
IDPrzedmiotuFakultatywnego INT REFERENCES SpisPrzedmiotówFakultatywnych(IDPrzedmiotuFakultatywnego),
IDNauczyciela INT REFERENCES Nauczyciele(IDNauczyciela)
ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
)
INSERT INTO [PrzedmiotyFakultatywne](IDPrzedmiotuFakultatywnego, IDNauczyciela) VALUES
(7,4),
(8,6)
CREATE TABLE Sprawdziany
(
IDKartkówki INT IDENTITY(1,1) PRIMARY KEY,
IDNauczyciela INT REFERENCES Nauczyciele(IDNauczyciela)
ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
IDKlasy INT REFERENCES Klasy(IDKlasy)
ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
Data DATETIME,
Opis VARCHAR(255),
)
INSERT INTO [Sprawdziany](IDNauczyciela, IDKlasy, Data, Opis) VALUES
(4, 1, 2021-10-12, 'Rodziały 1-6'),
(8, 2, 2020-01-10, 'Cały zakres materiału'),
(9, 2, 2021-10-29, 'Rodziały 7-9')
CREATE TABLE Kartkówki
(
IDKartkówki INT IDENTITY(1,1) PRIMARY KEY,
IDNauczyciela INT REFERENCES Nauczyciele(IDNauczyciela)
ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
IDKlasy INT REFERENCES Klasy(IDKlasy)
ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
Data DATETIME,
Opis VARCHAR(255),
CzyZapowiedziana BIT
)
INSERT INTO [Kartkówki](IDNauczyciela, IDKlasy, Data, Opis, CzyZapowiedziana) VALUES
(4, 1, GETDATE(), 'Niezapowiedziana kartkówka z poprzedniej lekcji', 0),
(8, 2, 2020-01-10, 'Poprzednie 3 tematy', 1)
INSERT INTO [Uwagi](IDUcznia, OpisUwagi, DataUwagi, PowagaUwagi) VALUES
(1, 'Bujał się na krześle', GETDATE(), 1),
(1, 'Rozmawiał na lekcji', 2021-03-02, 1),
(2, 'Ściągał na teście', GETDATE(), 2),
(3, 'Pobił kolegę', 2021-04-11, 3)
CREATE TABLE Stypendia
(
IDStypendium INT IDENTITY(1,1) PRIMARY KEY,
IDUcznia INT REFERENCES Uczniowie(IDUcznia) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
DataPoczątku DATETIME,
DataKońca DATETIME,
Kwota MONEY
)
INSERT INTO [Stypendia](IDUcznia, DataPoczątku, DataKońca, Kwota) VALUES
(1, 2020-09-01, 2021-06-30, 500),
(2, 2019-09-01, 2020-06-30, 1000),
(5, 2019-09-01, 2020-06-30, 200)
CREATE TABLE Sale
(
IDSali INT IDENTITY(1,1) PRIMARY KEY,
NazwaSali VARCHAR(255),
IDPrzedmiotu INT REFERENCES SpisPrzedmiotów(IDPrzedmiotu) ON UPDATE CASCADE ON DELETE CASCADE,
OstatniRemont DATETIME
)
INSERT INTO [Sale](NazwaSali, IDPrzedmiotu, OstatniRemont) VALUES
('23A', 1, 1993-03-04),
('1A', 2, 1895-02-13),
('1B', 3, GETDATE()),
('2', NULL, 2010-10-11),
('Świetlica', NULL, 2010-05-23)
INSERT INTO [Klasy](RokRozpoczęcia, LiteraPorządkowa, IDProfilu) VALUES
(2019, 'A', 1),
(2019, 'B', 1),
(2018, 'A', 1),
(2018, 'B', 2),
(2017, NULL, 3)
CREATE TABLE DniWolne
(
Data DATETIME,
Powód VARCHAR(255)
)
INSERT INTO [DniWolne](Data, Powód) VALUES
(2020-11-11, 'Dzień Niepodległości'),
(2020-12-23, 'Święta Bożego Narodzenia'),
(2020-12-24, 'Święta Bożego Narodzenia'),
(2020-12-25, 'Święta Bożego Narodzenia'),
(2020-12-26, 'Święta Bożego Narodzenia'),
(2020-12-31, 'Sylwester'),
(2021-01-01, 'Nowy Rok')
CREATE TABLE Wywiadówki
(
IDKlasy INT REFERENCES Klasy(IDKlasy) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
IDNauczyciela INT REFERENCES Nauczyciele(IDNauczyciela) ON UPDATE CASCADE ON DELETE CASCADE,
Data DATETIME
)
INSERT INTO [Wywiadówki](IDKlasy, IDNauczyciela, DATA) VALUES
(1, 4, 2020-10-12),
(2, 8, 2020-12-12),
(3, 4, 2021-01-20),
(4, 9, 2021-02-10)
CREATE TABLE Koła
(
IDNauczyciela INT REFERENCES Nauczyciele(IDNauczyciela) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
DataZajęć INT NOT NULL,
IDSali INT REFERENCES Sale(IDSali) NOT NULL,
NazwaKoła VARCHAR(255) NOT NULL
)
INSERT INTO [Koła](IDNauczyciela, DataZajęć, IDSali, NazwaKoła) VALUES
(4, 2021-02-10, 1, 'Koło Informatyczne'),
(4, 2021-02-12, 1, 'Koło Matematyczne')
CREATE TABLE WycieczkiSzkolne
(
IDNauczyciela INT REFERENCES Nauczyciele(IDNauczyciela) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
IDKlasy INT REFERENCES Klasy(IDKlasy) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
Data DATETIME,
LiczbaDni INT,
Miejsce VARCHAR(255)
)
INSERT INTO [WycieczkiSzkolne](IDNauczyciela, IDKlasy, Data, LiczbaDni, Miejsce) VALUES
(4, 1, 2020-10-10, 5, 'Zagrzeb'),
(4, 2, 2020-12-01, 2, 'Kraków'),
(8, 1, 2021-01-02, 1, 'Warszawa'),
(8, 3, 2020-10-20, 4, 'Berlin'),
(9, 2, 2019-10-12, 3, 'Lwów'),
(9, 1, 2019-12-30, 1, 'Zakopane')
CREATE TABLE SzafkiSzkolne
(
IDUcznia INT REFERENCES Uczniowie(IDUcznia) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
NumerSzafki INT PRIMARY KEY,
Piętro INT
)
INSERT INTO [SzafkiSzkolne](IDUcznia, NumerSzafki, Piętro) VALUES
(1, 10, 0),
(2, 11, 0),
(3, 12, 0),
(10, 33, 1),
(5, 1, 1),
(6, 2, 1),
(11, 3, 2)
CREATE TABLE ImprezySzkolne
(
Data DATETIME,
Powód VARCHAR(255)
)
INSERT INTO [ImprezySzkolne](Data, Powód) VALUES
(2021-01-02, 'Nowy Rok'),
(2020-06-15, 'Zakończenie roku szkolnego'),
(2020-10-10, 'Andrzejki'),
(2021-02-14, 'Walentynki'),
(GETDATE(), 'Spontaniczna impreza')
CREATE TABLE Urlopy
(
IDNauczyciela INT REFERENCES Nauczyciele(IDNauczyciela) ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
DataPoczątku DATETIME NOT NULL,
DataKońca DATETIME,
Powód VARCHAR(255),
CzyPłatny BIT NOT NULL,
)
INSERT INTO [Urlopy](IDNauczyciela, DataPoczątku, DataKońca, Powód, CzyPłatny) VALUES
(4, 2021-01-01, 2021-01-02, 'Kac noworoczny', 0),
(4, 2021-04-01, 2021-04-30, 'Złamana noga', 1),
(8, 2020-10-01, 2020-12-30, 'Problemy rodzinne', 0)
CREATE TABLE Usprawiedliwienia
(
IDUsprawiedliwienia INT IDENTITY(1, 1) PRIMARY KEY,
Powód VARCHAR(255),
SygnaturaLekarska VARCHAR(255)
)
CREATE TABLE Zwolnienia
(
IDZwolenienia INT IDENTITY(1,1) PRIMARY KEY,
DataPoczątku DATETIME,
DataKońca DATETIME,
IDUcznia INT REFERENCES Uczniowie(IDUcznia)ON UPDATE CASCADE ON DELETE CASCADE NOT NULL,
IDUsprawiedliwienia INT REFERENCES Usprawiedliwienia(IDUsprawiedliwienia)ON UPDATE CASCADE ON DELETE CASCADE
)
INSERT INTO [Usprawiedliwienia](Powód, SygnaturaLekarska) VALUES
('Złamana noga', 'L/13/202'),
('Osłabienie', 'L/13/201'),
('Biegunka', 'L/01/01')
INSERT INTO [Zwolnienia](DataPoczątku, DataKońca, IDUcznia, IDUsprawiedliwienia) VALUES
(2020-10-10, 2020-10-11, 1, NULL),
(2021-03-02, 2021-03-02, 2, 1)