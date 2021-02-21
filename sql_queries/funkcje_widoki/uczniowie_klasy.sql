GO
CREATE FUNCTION dbo.wypisz_uczniow_danej_klasy (@ID AS INT)
RETURNS TABLE
AS
RETURN
SELECT O.Imię, O.Nazwisko, O.Telefon, K.RokRozpoczęcia
FROM Osoby O JOIN Uczniowie U
ON O.IDOsoby = U.IDUcznia
JOIN [Klasy] K
ON U.IDKlasy = K.IDKlasy
WHERE U.IDKlasy = @ID
GO
-- przykładowe wywołanie funkcji (wypisanie danych uczniów z klasy o ID == 1):
SELECT * FROM dbo.wypisz_uczniow_danej_klasy(1)