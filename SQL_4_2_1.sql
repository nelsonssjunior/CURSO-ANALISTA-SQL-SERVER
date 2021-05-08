USE AdventureWorks2019
GO

-- EXPRESS�O CALCULADA MULTIPLICANDO DUAS COLUNAS
SELECT UnitPrice, OrderQty, (UnitPrice * OrderQty) AS TotalValue
FROM Sales.SalesOrderDetail;

-- Express�o Calculada Usando o Operador de divis�o e multiplica��o
SELECT UnitPrice, UnitPriceDiscount, UnitPriceDiscount/UnitPrice * 100 AS DiscountPercentual
FROM Sales.SalesOrderDetail
WHERE UnitPriceDiscount > 0

-- Express�o calculada usando operados de subtra��o
SELECT UnitPrice, UnitPriceDiscount, UnitPrice - UnitPriceDiscount AS UnitPriceWithDiscount
FROM Sales.SalesOrderDetail


-- Express�o calculada usando operador de concatena��o
SELECT FirstName AS PriemeiroNome, MiddleName AS NomeDoMeio, LastName AS �ltimoNome,
FirstName + ' ' + MIddleName + ' ' + LastName AS NomeCompleto
FROM Person.Person

-- Usando o operador de concatena��o para gerar comandos Dinamicamente
SELECT 'DROP TABLE' + name +';'
FROM sys.tables

-- Alterando a ordem de avalia��o dos operadores
-- Calculando o calor total com o desconto (errado: multiplica��o feita primeiro, antes de clacular o valor unit�rio com o desconto)
-- Ex.: linhas 803/805
SELECT UnitPrice, UnitPriceDiscount, OrderQty, UnitPrice - UnitPriceDiscount * OrderQty AS TotalWithDiscount
FROM Sales.SalesOrderDetail

-- Calculando o calor total com o desconto (ok)
SELECT UnitPrice,  UnitPriceDiscount, OrderQty, (UnitPrice - UnitPriceDiscount) * OrderQty AS TotalWithDiscount
FROM Sales.SalesOrderDetail

-- Express�o calculada usando operador de concatena��o
