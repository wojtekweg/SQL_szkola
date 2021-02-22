CREATE TRIGGER srednia_ocen ON Oceny
AFTER INSERT
AS
BEGIN
    SELECT AVG(O.Ocena) AS [Średnia ocen], O.IDUcznia 
    FROM Oceny AS O
    GROUP BY O.IDUcznia
END

--przykładowe dodanie oceny, zmieniające średnią
INSERT INTO [Oceny]
(IDUcznia, Ocena, IDPrzedmiotu, IDNauczyciela, Data)
VALUES
(1, 1, 2, 4, GETDATE())