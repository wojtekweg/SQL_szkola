CREATE TRIGGER sprawdzenie_liczy_klas ON Klasy
AFTER INSERT
AS
IF (SELECT COUNT(IDKlasy) FROM Klasy) > (SELECT COUNT(IDUcznia) FROM Uczniowie)
ROLLBACK
RAISERROR('Nie można dodać klasy, ponieważ jest za mało uczniów.', 16, 1)
GO
--przykładowe dodanie klasy z wywołaniem triggera
INSERT INTO [Klasy](RokRozpoczęcia, LiteraPorządkowa, IDProfilu) VALUES
(2012, 'A', 1),
(2012, 'B', 1),
(2012, 'C', 2),
(2012, 'D', 2),
(2012, 'E', 3),
(2012, 'F', 3)