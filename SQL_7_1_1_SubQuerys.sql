USE AdventureWorks2019
GO

-- RETORNAR OS ITENS VENDIDOS NA ÚLTIMA VENDA REALIZADA
-- Subconsulta independente
SELECT SalesOrderID, SalesOrderDetailID, OrderQty, ProductID, LineTotal
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = (SELECT MAX(SalesOrderID) AS Última_Venda
							FROM Sales.SalesOrderHeader
							)
GO

--Na prática:
SELECT SalesOrderID, SalesOrderDetailID, OrderQty, ProductID, LineTotal
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = 75123
GO

--Retornar todos os itens vendidos, exceto os da última venda realizada
SELECT SalesOrderID, SalesOrderDetailID, OrderQty, ProductID, LineTotal
FROM Sales.SalesOrderDetail
WHERE SalesOrderID !=(SELECT MAX(SalesOrderID) AS Última_Venda
						FROM Sales.SalesOrderHeader)
GO

-- Erros de subconsulta retornando mais de um valor
-- (Operadores =, !=, <, <=, e >=)
-- Substituir pelo IN para corrigir
SELECT SalesOrderID, SalesOrderDetailID, OrderQty, ProductID, LineTotal
FROM Sales.SalesOrderDetail
WHERE SalesOrderID = (SELECT TOP(5)SalesOrderID AS Última_Cinco_Vendas
						FROM Sales.SalesOrderHeader
						ORDER BY SalesOrderID)
GO

-- Subconsulta escalar com Having
-- Vendas diárias de 2013 com valores inferiores à média de vendas do ano anterior
SELECT OrderDate AS Data_de_Venda, SUM(TotalDue) AS Valor_Total_Diário_de_Vendas
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
-- Identificação e Número de conta dos clientes da Austrália e França
SELECT CustomerID, AccountNumber
FROM Sales.Customer
WHERE TerritoryID IN (
						SELECT TerritoryID
						FROM Sales.SalesTerritory
						WHERE Name = 'Austrália' OR Name = 'France'
);

-- Na prática:
SELECT CustomerID, AccountNumber
FROM Sales.Customer
WHERE TerritoryID IN (9, 7);

--Evitar Subconsulta Multivalorada que tenha o mesmo propósito de um join
-- JOIN mais performático
SELECT C.CustomerID, C.AccountNumber
FROM Sales.Customer C
JOIN Sales.SalesTerritory T
ON C.TerritoryID = t.TerritoryID
WHERE T.Name = 'Australia' OR T.Name = 'France';

-- Identificação e Número da Conta dos Clientes que Não São da Austrália e França
-- NOT IN (GASTA PERFORMANCE POR CAUSA DA CHECAGEM UNITÁRIA DE ITENS)
SELECT CustomerID, AccountNumber
FROM Sales.Customer
WHERE TerritoryID NOT IN (
						SELECT TerritoryID
						FROM Sales.SalesTerritory
						WHERE Name = 'Austrália' OR Name = 'France'
);

-- Subconsulta multivalorada com HAVING
-- Subconsulta Independente
-- Vendas por dia,  no ano de 2013, que ano anterior foram os 5 dias com maior valor de vendas
SELECT OrderDate AS Data_da_Venda, SUM(TotalDue) AS Valor_Total_Diário_de_Vendas
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

