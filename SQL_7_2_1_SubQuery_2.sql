USE AdventureWorks2019
GO

-- Subconsultas correlacionadas
-- Retornar as vendas mais recentes feitas por cada empregado
SELECT Q1.SalesOrderID, Q1.SalesPersonID, Q1.OrderDate
FROM Sales.SalesOrderHeader AS Q1
WHERE Q1.OrderDAte = (
						SELECT MAX(Q2.OrderDate)
						FROM Sales.SalesOrderHeader AS Q2
						WHERE Q2.SalesPersonID = Q1.SalesPersonID
						)
ORDER BY Q1.SalesPersonID, Q1.OrderDate;

-- Operador EXISTS
-- Retornar o ID e o Bônus das pessoas que FIZERAM vendas em 2011
SELECT P.BusinessEntityID, P.Bonus
FROM Sales.SalesPerson P
WHERE EXISTS(
			SELECT *
			FROM Sales.SalesOrderHeader V
			WHERE V.SalesPersonID = P.BusinessEntityID
			AND YEAR(OrderDate) = '2011'
			)
ORDER BY 1 ASC;

-- Operador EXISTS acima é equivalente a recuperar os resultados contando as linhas retornadas
-- e comparando essa contagem com zero
SELECT P.BusinessEntityID, P.Bonus
FROM Sales.SalesPerson P
WHERE( -- Subconsulta como expressão da cláusula WHERE
			SELECT COUNT(*)
			FROM Sales.SalesOrderHeader V
			WHERE V.SalesPersonID = P.BusinessEntityID
			AND YEAR(OrderDate) = '2011'
			) > 0
ORDER BY 1 ASC;

-- Conjunto de busca sem a correlação
SELECT DISTINCT SalesPersonID, P.Bonus
FROM Sales.SalesOrderHeader
JOIN Sales.SalesPerson P
ON SalesPersonID = P.BusinessEntityID
WHERE SalesPersonID IS NOT NULL
AND YEAR(OrderDate) = '2011'
ORDER BY 1 ASC;

-- EXISTS x IN
SELECT CustomerID, AccountNumber
FROM Sales.Customer
WHERE TerritoryID IN (
						SELECT TerritoryID
						FROM Sales.SalesTerritory
						WHERE Name = 'Australia' OR Name = 'France'
						);
SELECT CustomerID, AccountNumber
FROM Sales.Customer C
WHERE EXISTS (	SELECT *
				FROM Sales.SalesTerritory T
				WHERE T.TerritoryID = C.TerritoryID
				AND (Name = 'Australia' OR Name = 'France')
			);

-- Operador NOT EXISTS
-- Retornar o ID e o bônus das pessoas que não fizeram vendas em 2011
SELECT P.BusinessEntityID, P.Bonus
FROM Sales.SalesPerson P
WHERE NOT EXISTS (
				SELECT *
				FROM Sales.SalesOrderHeader V
				WHERE V.SalesPersonID = P.BusinessEntityID
				AND YEAR(OrderDate) = '2011'
				)
ORDER BY 1 ASC;

-- Operador NOT EXISTS acima é equivalente a recuperar os resutados contendo as linhas retornadas
-- e comparando essa contagem com zero
SELECT P.BusinessEntityID, P.Bonus
FROM Sales.SalesPerson P
WHERE ( SELECT COUNT(*)
		FROM Sales.SalesOrderHeader V
		WHERE V.SalesPersonID = P.BusinessEntityID
		AND YEAR(OrderDate) = '2013'
	) = 0
ORDER BY 1 ASC;


------------------------------ Subconsultas com operadores -----------------------
USE AdventureWorks2019
GO

--Criar tabela de luvas (Gloves) com o Wizard de Export Data
SELECT ProductModelID, Name
FROM Production.ProductModel
WHERE ProductModelID IN (3, 4);

-- Nova tabela
SELECT * 
FROM Production.Gloves
ORDER BY Name;

-- UNION elimina as linhas duplicadas (*Erro do OREDER BY na consulta)
SELECT ProductModelID, Name
FROM Production.ProductModel
ORDER BY Name
UNION
SELECT ProductModelID, Name
FROM Production.Gloves
ORDER BY Name;

-- UNION elimina as linhas duplicadas (OK - Com o OREDER BY na consulta geral)
SELECT ProductModelID, Name
FROM Production.ProductModel
UNION
SELECT ProductModelID, Name
FROM Production.Gloves
ORDER BY Name;

-- UNION quantidade diferentes de colunas (Erro)
SELECT ProductModelID, Name
FROM Production.ProductModel
UNION
SELECT ProductModelID
FROM Production.Gloves
ORDER BY Name;

-- UNION ALL Nãi elimina linhas duplicadas
SELECT ProductModelID, Name
FROM Production.ProductModel
UNION ALL
SELECT ProductModelID, Name
FROM Production.Gloves
ORDER BY Name;

-- INTERSECT
SELECT ProductModelID, Name
FROM Production.ProductModel
INTERSECT
SELECT ProductModelID, Name
FROM Production.Gloves
ORDER BY Name;

--EXCEPT
SELECT ProductModelID, Name
FROM Production.ProductModel
EXCEPT
SELECT ProductModelID, Name
FROM Production.Gloves 
ORDER BY Name;

-- EXCEPT CASO HAJA INVERSÃO DAS CONSULTAS, O RESULTADO SERÁ DIFERENTE DO MOSTRADO ANTERIORMENTE
SELECT ProductModelID, Name
FROM Production.Gloves
EXCEPT
SELECT ProductModelID, Name
FROM Production.ProductModel
ORDER BY Name;
-- Nenhum produto que esteja em GLOVES e que não esteja em Model

