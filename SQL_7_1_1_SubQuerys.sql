USE AdventureWorks2019
GO

-- RETORNAR OS ITENS VENDIDOS NA �LTIMA VENDA REALIZADA
-- Subconsulta independente
SELECT SalesOrderID, SalesOrderDetailID, OrderQty, ProductID, LineTotal
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = (SELECT MAX(SalesOrderID) AS �ltima_Venda
							FROM Sales.SalesOrderHeader
							)
GO

--Na pr�tica:
SELECT SalesOrderID, SalesOrderDetailID, OrderQty, ProductID, LineTotal
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 75123
GO

--Retornar todos os itens vendidos, exceto os da �ltima venda realizada
SELECT SalesOrderID, SalesOrderDetailID, OrderQty, ProductID, LineTotal
FROM Sales.SalesOrderDetail
WHERE SalesOrderID !=(SELECT MAX(SalesOrderID) AS �ltima_Venda
						FROM Sales.SalesOrderHeader)
GO

-- Erros de subconsulta retornando mais de um valor
-- (Operadores =, !=, <, <=, e >=)
-- Substituir pelo IN para corrigir
SELECT SalesOrderID, SalesOrderDetailID, OrderQty, ProductID, LineTotal
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = (SELECT TOP(5)SalesOrderID AS �ltima_Cinco_Vendas
						FROM Sales.SalesOrderHeader
						ORDER BY SalesOrderID)
GO

-- Subconsulta escalar com Having
-- Vendas di�rias de 2013 com valores inferiores � m�dia de vendas do ano anterior
SELECT OrderDate AS Data_de_Venda, SUM(TotalDue) AS Valor_Total_Di�rio_de_Vendas
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate)='2013'
GROUP BY OrderDate
HAVING SUM(TotalDue) < (SELECT AVG(TotalDue)
						FROM Sales.SalesOrderHeader --Subconculta recursiva
						WHERE YEAR(OrderDate) = '2012'
						)
ORDER BY 1 ASC;


---------------------------------- SUBCONSULTA MULTIVALORADA --------------------------

USE AdventureWorks2019
GO

-- Subconsulta Multivalorada
-- Subconsulta Independente
-- Identifica��o e N�mero de conta dos clientes da Austr�lia e Fran�a
SELECT CustomerID, AccountNumber
FROM Sales.Customer
WHERE TerritoryID IN (
						SELECT TerritoryID
						FROM Sales.SalesTerritory
						WHERE Name = 'Austr�lia' OR Name = 'France'
);

-- Na pr�tica:
SELECT CustomerID, AccountNumber
FROM Sales.Customer
WHERE TerritoryID IN (9, 7);

--Evitar Subconsulta Multivalorada que tenha o mesmo prop�sito de um join
-- JOIN mais perform�tico
SELECT C.CustomerID, C.AccountNumber
FROM Sales.Customer C
JOIN Sales.SalesTerritory T
ON C.TerritoryID = t.TerritoryID
WHERE T.Name = 'Australia' OR T.Name = 'France';

-- Identifica��o e N�mero da Conta dos Clientes que N�o S�o da Austr�lia e Fran�a
-- NOT IN (GASTA PERFORMANCE POR CAUSA DA CHECAGEM UNIT�RIA DE ITENS)
SELECT CustomerID, AccountNumber
FROM Sales.Customer
WHERE TerritoryID NOT IN (
						SELECT TerritoryID
						FROM Sales.SalesTerritory
						WHERE Name = 'Austr�lia' OR Name = 'France'
);

-- Subconsulta multivalorada com HAVING
-- Subconsulta Independente
-- Vendas por dia,  no ano de 2013, que ano anterior foram os 5 dias com maior valor de vendas
SELECT OrderDate AS Data_da_Venda, SUM(TotalDue) AS Valor_Total_Di�rio_de_Vendas
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = '2013'
GROUP BY OrderDate
HAVING CAST (DAY(OrderDate) AS VARCHAR(2)) + '-' + CAST(MONTH(OrderDate) AS VARCHAR(2))
IN (
	SELECT TOP (5) CAST (DAY(OrderDate) AS VARCHAR(2)) + '-' + CAST(MONTH(OrderDate) AS VARCHAR(2))
	FROM Sales.SalesOrderHeader
	GROUP BY OrderDate
	ORDER BY SUM(TotalDue) DESC
	)
ORDER BY 1 ASC;

