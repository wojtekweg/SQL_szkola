CREATE FUNCTION dbo.liczba_nauczycieli_o_zarobkach
(@Zarobki MONEY)
RETURNS INT
AS BEGIN
RETURN (
    SELECT COUNT(N.IDNauczyciela)
    FROM Nauczyciele N
    WHERE N.Stawka >= @Zarobki
)
END
GO

--poniższe wywołanie dla przykładowych danych zwróci liczbę 3
SELECT dbo.liczba_nauczycieli_o_zarobkach(4000)