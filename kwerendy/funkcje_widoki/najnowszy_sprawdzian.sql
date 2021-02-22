GO
CREATE VIEW najnowszy_sprawdzian
AS
SELECT TOP 1 * FROM Sprawdziany AS S
ORDER BY S.Data DESC
GO

--użycie widoku
SELECT * FROM najnowszy_sprawdzian