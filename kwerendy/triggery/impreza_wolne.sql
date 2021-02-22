CREATE TRIGGER impreza_wolne ON ImprezySzkolne
AFTER INSERT
AS 
DECLARE
@Data INT
BEGIN
IF NOT EXISTS (
    SELECT Data FROM DniWolne
    WHERE DniWolne.Data = @Data
    )
ROLLBACK
RAISERROR('Nie można zorganizować imprezy w dzień nauki.', 16, 1)
END

--usuniecie przykladowej klasy
INSERT INTO [ImprezySzkolne](Data, Powód) VALUES
(2021-03-30, 'Bo nie chce się nam uczyć')