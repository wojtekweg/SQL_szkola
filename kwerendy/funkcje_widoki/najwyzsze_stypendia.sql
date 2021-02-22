GO
CREATE VIEW najwyzsze_stypendia
AS
SELECT TOP 3 S.Kwota FROM Stypendia S
ORDER BY S.Kwota DESC
GO

SELECT * FROM najwyzsze_stypendia