ALTER PROCEDURE dodaj_przedmiot
@nazwa VARCHAR(255)
AS
BEGIN
DECLARE @count INT
SET @count = (SELECT COUNT(*) FROM SpisPrzedmiotów)
SET @count = @count + 1;
IF NOT EXISTS (SELECT * FROM SpisPrzedmiotów WHERE NazwaPrzedmiotu=@nazwa)
INSERT INTO [SpisPrzedmiotów](IDPrzedmiotu, NazwaPrzedmiotu) VALUES (@count, @nazwa)
ELSE 
PRINT 'Taki przedmiot już istnieje'
END

CREATE PROCEDURE ile_uczniów
AS
BEGIN
SELECT COUNT(*) FROM Uczniowie
END

CREATE PROCEDURE czy_istnieje_osoba
@imie VARCHAR(255),
@nazwisko VARCHAR(255)
AS
BEGIN
IF EXISTS (SELECT * FROM Osoby WHERE Imię=@imie AND Nazwisko=@nazwisko)
PRINT 'TAK'
ELSE
PRINT 'NIE'
END

CREATE PROCEDURE ile_wywiadówek
@klasa INT
AS
BEGIN
DECLARE @count INT
SET @count = (SELECT COUNT(*) FROM Wywiadówki WHERE IDKlasy=@klasa)
PRINT @count
END

ALTER PROCEDURE dodaj_uwagę
@imię VARCHAR(255),
@nazwisko VARCHAR(255),
@uwaga VARCHAR(255),
@powaga_uwagi INT
AS
BEGIN
DECLARE @ID INT
IF EXISTS (SELECT IDOsoby FROM Osoby WHERE Imię=@imię AND Nazwisko=@nazwisko)
BEGIN
SET @ID = (SELECT IDOsoby FROM Osoby WHERE Imię=@imię AND Nazwisko=@nazwisko);
INSERT INTO [Uwagi](IDUcznia, OpisUwagi, DataUwagi, PowagaUwagi) VALUES (@ID, @uwaga, GETDATE(), @powaga_uwagi)
END
ELSE
PRINT 'Taki uczeń nie istnieje'
END
