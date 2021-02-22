GO
CREATE FUNCTION dbo.testy_klasy (@ID AS INT)
RETURNS TABLE
AS
RETURN
(
    SELECT S.Data, S.Opis FROM Sprawdziany S
    WHERE @ID = S.IDKlasy
)
UNION ALL
(
    SELECT R.Data, R.Opis FROM Kartkówki R
    WHERE @ID = R.IDKlasy
)
GO
-- przykładowe wywołanie funkcji (wypisanie testów dla klasy o ID = 2):
SELECT * FROM dbo.testy_klasy(2)