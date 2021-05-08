USE AdventureWorks2019;

-- View simples
CREATE VIEW VW_Clientes_Australia AS
SELECT CustomerID, AccountNumber
FROM [Sales].[Customer]
WHERE TerritoryID IN (
						SELECT TerritoryID
						FROM Sales.SalesTerritory
						WHERE Name = 'Australia'
						)
GO

SELECT * FROM VW_Clientes_Australia
GO;

-- Filtrando Views
SELECT * FROM VW_Clientes_Australia
WHERE CustomerID BETWEEN 1 AND 100
GO

-- VIEWS COM ORDER BY GERAM ERRO

CREATE VIEW VW_Clientes_Australia_All_Info AS
SELECT *
FROM [Sales].[Customer]
WHERE TerritoryID IN (
						SELECT TerritoryID
						FROM Sales.SalesTerritory
						WHERE Name = 'Australia'
						)
GO

SELECT * FROM VW_Clientes_Australia_All_Info;

-- ORDENANDO DADOS PELA VIEW
SELECT *
FROM VW_Clientes_Australia_All_Info
ORDER BY CustomerID DESC
GO

-- ATENÇÃO PARA VIEWS DEFINIDAS COM SELECT *
ALTER TABLE Sales.Customer ADD Ind_Status bit NULL
GO

SELECT *
FROM Sales.Customer
GO

SELECT *
FROM VW_Clientes_Australia_All_Info
GO

-- Para atualizar a VIEW use os comandos abaixo
-- Visualizando os campos da tabela
EXEC SP_HELP 'VW_Clientes_Australia_All_Info'
GO

--Verificando o código da view
EXEC SP_HELPTEXT 'VW_Clientes_Australia_All_Info'
GO

-- RECOMPILANDO A VIEW
EXEC SP_REFRESHVIEW VW_Clientes_Australia_All_Info
GO
-- ou executar ALTER VIEW com o mesmo código
