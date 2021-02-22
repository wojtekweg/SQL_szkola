IF OBJECT_ID('usunięcie_ucznia', 'TR') IS NOT NULL
DROP TRIGGER usunięcie_ucznia
GO
CREATE TRIGGER usunięcie_ucznia ON Uczniowie
AFTER DELETE
AS BEGIN
DECLARE @msg NVARCHAR(55) = NULL
DECLARE @nr INT
SELECT @nr = COUNT(*) FROM Uczniowie
SELECT 'Uczeń usunięty pomyślnie.' [Stan operacji], CAST(@nr AS VARCHAR(10)) [Liczba uczniów w bazie]
END
GO

--przykładowe usunięcie ucznia z wywołaniem triggera
DELETE FROM Uczniowie WHERE IDUcznia = 11