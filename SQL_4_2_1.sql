USE AdventureWorks2019
GO

-- EXPRESSÃO CALCULADA MULTIPLICANDO DUAS COLUNAS
SELECT UnitPrice, OrderQty, (UnitPrice * OrderQty) AS TotalValue
FROM Sales.SalesOrderDetail;

-- Expressão Calculada Usando o Operador de divisão e multiplicação
SELECT UnitPrice, UnitPriceDiscount, UnitPriceDiscount/UnitPrice * 100 AS DiscountPercentual
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0

-- Expressão calculada usando operados de subtração
SELECT UnitPrice, UnitPriceDiscount, UnitPrice - UnitPriceDiscount AS UnitPriceWithDiscount
FROM Sales.SalesOrderDetail


-- Expressão calculada usando operador de concatenação
SELECT FirstName AS PriemeiroNome, MiddleName AS NomeDoMeio, LastName AS ÚltimoNome,
FirstName + ' ' + MIddleName + ' ' + LastName AS NomeCompleto
FROM Person.Person

-- Usando o operador de concatenação para gerar comandos Dinamicamente
SELECT 'DROP TABLE' + name +';'
FROM sys.tables

-- Alterando a ordem de avaliação dos operadores
-- Calculando o calor total com o desconto (errado: multiplicação feita primeiro, antes de clacular o valor unitário com o desconto)
-- Ex.: linhas 803/805
SELECT UnitPrice, UnitPriceDiscount, OrderQty, UnitPrice - UnitPriceDiscount * OrderQty AS TotalWithDiscount
FROM Sales.SalesOrderDetail

-- Calculando o calor total com o desconto (ok)
SELECT UnitPrice,  UnitPriceDiscount, OrderQty, (UnitPrice - UnitPriceDiscount) * OrderQty AS TotalWithDiscount
FROM Sales.SalesOrderDetail

-- Expressão calculada usando operador de concatenação
