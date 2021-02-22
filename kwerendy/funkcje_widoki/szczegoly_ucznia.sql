GO
CREATE FUNCTION dbo.szczegoly_ucznia (@ID AS INT)
RETURNS TABLE
AS
RETURN
SELECT O.Imię, O.Nazwisko, O.Telefon, S.NumerSzafki, R.Kwota, R.DataPoczątku, R.DataKońca
FROM Osoby O JOIN Uczniowie U
ON O.IDOsoby = U.IDUcznia
FULL JOIN SzafkiSzkolne S
ON S.IDUcznia = U.IDUcznia
FULL JOIN Stypendia R
ON R.IDUcznia = U.IDUcznia
WHERE U.IDUcznia = @ID
GO
-- przykładowe wywołanie funkcji (wypisanie danych ucznia o ID = 5):
SELECT * FROM dbo.szczegoly_ucznia(5)