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