IF OBJECT_ID('dodano_nauczyciela', 'TR') IS NOT NULL
DROP TRIGGER dodano_nauczyciela
GO
CREATE TRIGGER dodano_nauczyciela ON Nauczyciele
AFTER INSERT
AS BEGIN
DECLARE @msg NVARCHAR(55) = NULL
DECLARE @nr INT
SELECT @nr = COUNT(*) FROM Nauczyciele
SELECT 'Nauczyciel dodany pomyślnie.' [Stan operacji], CAST(@nr AS VARCHAR(10)) [Liczba nauczycieli w bazie]
END
GO

--przykładowe dodanie nauczyciela z wywołaniem triggera
INSERT INTO [Osoby](Imię, Nazwisko, Telefon) VALUES
('Adam', 'Nowonauczycielski', '+48 132 147 444')

INSERT INTO [Nauczyciele]
(IDNauczyciela, WychowawcaKlasy, DataZatrudnienia, Stawka)
VALUES
(15, 3, GETDATE(), 8000)