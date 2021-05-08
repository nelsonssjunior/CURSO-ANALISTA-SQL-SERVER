
USE AdventureWorks2019
GO

SELECT * FROM Production.Product;

--SELECIONAR TODAS AS LINHAS DAS COLUNAS NAME E PRODUCTNUMBER DA TABELA PRODUCT
SELECT Name, ProductNumber
FROM Production.Product
GO

--SELECIONAR TODAS AS LINHAS E TODAS AS COLUNAS DA TABELA PRODUCT
SELECT *
FROM Production.Product
GO

-- ADICIONAR COLUNA E REPETIR O COMANDO
ALTER TABLE Production.Product
ADD SpecialEdition bit NULL
GO

-- OBJETO INEXISTENTE
SELECT Name, ProductNumber
FROM master.Production.Product
GO

SELECT Name, ProductNumber
FROM AdventureWorks2019.Production.Product
GO

-- COLUNA INEXISTENTE
SELECT ProductName, ProductNumber
FROM AdventureWorks2019.Production.Product
GO

-------------------------------------------   ALIAS -----------------------------------------------------------

USE AdventureWorks2019
GO

--ALIAS PARA COLUNAS
SELECT Name AS Nome_do_Produto,
ProductNumber AS Número_do_Produto
FROM Production.Product
GO

SELECT Name, Name AS Nome_do_Produto, ProductNumber, ProductNumber AS Número_do_Produto
FROM Production.Product
GO

-- OUTRA FORMA DE CRIAR ALIAS NO SQL
SELECT Nome_do_Produto = Name,
Número_do_Produto = ProductNumber
FROM Production.Product
GO

-- ALIAS COM ESPAÇOS
SELECT Name AS "Nome do Produto", Name AS [Nome do Produto]
FROM Production.Product
GO

-- ALIAS DE COLUNA ACIDENTAL
SELECT Name ProductNumber
FROM Production.Product
GO

--ALIAS DE TABELA CRIADO COM CLÁUSULA AS 
SELECT Name, ProductNumber
FROM Production.Product AS P
GO

-- alias de tabela criado sem clausula AS
SELECT Name, ProductNumber
FROM Production.Product P
GO

-- ALIAS DE TABELA
SELECT P.Name, P.ProductNumber
FROM Production.Product P
GO

-- NÃO Obrigatoriedade de usar ALIAS de tabela nas colunas
SELECT Name, ProductNumber
FROM Production.Product P
GO

-- Alias de Tabela não definido
SELECT P.Name, P.ProductNumber, C.Name
FROM Production.Product P
GO

-- Alias de tabela + Alias de coluna
SELECT P.Name AS Nome_do_Produto, P.ProductNumber AS Número_do_Produto
FROM Production.Product P
GO

-- Ambiguidade de Colunas
SELECT Name, ProductNumber
FROM Production.Product, Production.Location
GO

SP_HELP [Production.Product];
SP_HELP [Production.Location];

-- ALIAS DE TABELAS PARA REMOVER AMBIGUIDADE DE NOME DE COLUNAS
SELECT P.Name, P.ProductNumber, L.Name
FROM Production.Product AS P, Production.Location AS L
GO

-- OU PREFIXAR COLUNAS COM NOME DE TABELAS
SELECT Product.Name, ProductNumber, Location.Name
FROM Production.Product, Production.Location
GO

-- CASE SIMPLES
USE AdventureWorks2019
GO

SELECT ProductID, Name, ProductSubcategoryID,
CASE ProductSubcategoryID
	WHEN 1 THEN 'Mountain Bikes'
	WHEN 2 THEN 'Road Bikes'
	WHEN 3 THEN 'Touring Bikes'
	ELSE 'Unknown Category'
END AS SubcategoryName
FROM Production.Product
GO

-- CASE COM PESQUISA BOOLEANA
SELECT ProductNumber AS "Número do Produto", Name AS "Nome do Produto", ListPrice AS "Preço",
"Faixa de Preço" =
	CASE
		WHEN ListPrice = 0 THEN 'Não Disponível para Venda'
		WHEN ListPrice < 50 THEN 'Abaixo de $50'
		WHEN ListPrice >= 50  AND ListPrice <250 THEN 'Abaixo de $250'
		WHEN ListPrice >= 250 AND ListPrice < 1000 THEN 'Abaixo $1000'
		ELSE 'Acima de $1000'
	END
FROM Production.Product
GO