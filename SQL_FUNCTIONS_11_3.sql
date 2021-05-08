USE AdventureWorks2019
GO

-- FUNCÇÃO ESCALAR
CREATE FUNCTION dbo.ISOweek (@DATE datetime)
RETURNS INT
AS
BEGIN
	DECLARE @ISOweek INT;
	SET @ISOweek= DATEPART(wk, @DATE)+1
		-DATEPART(wk,CAST(DATEPART(yy,@DATE) as CHAR(4))+'0104')
-- SPECIAL CASES: JAN 1-3 MAY BELONG TO THE PREVIOUS YEAR
	IF (@ISOweek=0)
		SET @ISOweek=dbo.ISOweek(CAST(DATEPART(yy,@Date)-1
			AS CHAR (4))+'12'+ CAST (24+DATEPART(DAY,@DATE) AS CHAR(2)))+1
-- SPECIAL CASE: DEC 29-31 MAY BELONG TO THE NEXT YEAR
IF ((DATEPART(mm,@DATE)=12) AND
	((DATEPART(dd,@DATE)-DATEPART(dw,@DATE))>=28))
	SET @ISOweek=1
	RETURN(@ISOweek)
END
GO

SELECT dbo.ISOweek(CONVERT(DATETIME,'12/26/2019',101)) AS 'ISOweek'
GO


-- Creates the login AbolrousHazem with password '340$Uuxwp7Mcxo7Khy'.  
CREATE LOGIN Jupyter  
    WITH PASSWORD = 'bolado@3891';  
GO  

-- Creates a database user for the login created above.  
CREATE USER Jupyter FOR LOGIN Jupyter;  
GO  