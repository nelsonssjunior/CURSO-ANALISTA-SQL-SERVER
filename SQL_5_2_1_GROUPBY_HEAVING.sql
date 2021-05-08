USE AdventureWorks2019
GO

-- Agrupar quantidade de Vendas por funcion�rio
SELECT SalesPersonID AS ID_do_Vendedor, COUNT(SalesOrderID) AS Total_de_Vendas
FROM Sales.SalesOrderHeader
GROUP BY SalesPersonID
ORDER BY 2 DESC;

-- AGRUPAR QUANTIDADE DE VENDAS DOS FUNCION�RIOS POR DIA (N�O OK - COLUNA N�O DEFINIDA NO AGRUPAMENTO)
SELECT SalesPersonID AS ID_do_Vendedor, OrderDate AS DAta_da_Venda,
	   COUNT(SalesOrderID) AS total_de_Vendas
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID
ORDER BY OrderDate DESC;

-- Agrupar quantidade de vendas dos funcion�rios por dia (OK)
SELECT SalesPersonID AS ID_do_Vendedor, OrderDate AS DAta_da_Venda,
	   COUNT(SalesOrderID) AS total_de_Vendas
FROM Sales.SalesOrderHeader
WHERE SalesPersonID IS NOT NULL
GROUP BY SalesPersonID, OrderDate
ORDER BY OrderDate DESC;

-- Fun��o de agrega��o x Outras fun��es no SELECT
-- AGRUPAR QUANTIDAE DE VENDAS DOS FUNCIONARIOS POR ANO (N�O OK - COLUNA COM FUN��O DE DATA N�O DEFINIDA NO AGRUPAMENTO)
SELECT SalesPersonID AS ID_do_vendedor, YEAR(OrderDate) AS Ano_da_Venda,
		COUNT(SalesOrderID) AS Total_de_Vendas
FROM Sales.SalesOrderHeader
GROUP BY SalesPersonID
ORDER BY YEAR(OrderDate) DESC;

-- Agrupar quantidade de vendas dos funcionarios por ano (OK)
SELECT SalesPersonID AS ID_do_vendedor, YEAR(OrderDate) AS Ano_da_Venda,
		COUNT(SalesOrderID) AS Total_de_Vendas
FROM Sales.SalesOrderHeader
GROUP BY SalesPersonID, YEAR(OrderDate)
ORDER BY YEAR(OrderDate) DESC;

-- Alias no GROUP BY
-- Valor total de vendas por dia
SELECT OrderDate AS Data_da_Venda, SUM(TotalDue) AS Valor_Total_de_Vendas
FROM Sales.SalesOrderHeader
GROUP BY Data_da_Venda
ORDER BY 1 ASC;

-- VALOR TOTAL DE VENDAS POR DIA (OK)
SELECT OrderDate AS Data_da_Venda, SUM(TotalDue) AS Valor_Total_de_Vendas
FROM Sales.SalesOrderHeader
GROUP BY OrderDate
ORDER BY 1 ASC;

------------------------ Filtrando agrupamentos com HAVING --------------------

-- Valor total de vendas por dia em 2013
SELECT OrderDate AS Data_da_Venda, SUM(TotalDue) AS Valor_Total_de_Di�rio_de_Vendas
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = '2013'
GROUP BY OrderDate
ORDER BY 1 ASC;

-- Valor total de vendas por M�s em 2013
SELECT MONTH(OrderDate) AS M�s_da_Venda, SUM(TotalDue) AS Valor_Total_de_Di�rio_de_Vendas
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = '2013'
GROUP BY MONTH(OrderDate)
ORDER BY 1 ASC;

-- Filtrando com Heaving os dias  com vendas superiores a 4 milh�es, no ano de 2013.
SELECT MONTH(OrderDate) AS M�s_da_Venda, SUM(TotalDue) AS Valor_Total_de_Di�rio_de_Vendas
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = '2013'
GROUP BY MONTH(OrderDate)
HAVING SUM(TotalDue)>4000000
ORDER BY 1 ASC;

/* Quantidade de Vendas por funcion�rio com ID maior que 280
Sem Fun��o de agrega��o na clausula HAVING
HAVING atuando como WHERE */
SELECT SalesPersonID AS ID_do_Vendedor, COUNT(SalesOrderID) AS Total_de_vendas
FROM Sales.SalesOrderHeader
GROUP BY SalesPersonID
HAVING SalesPersonID > 280
ORDER BY 2 DESC;

/* 
Lembrar que o WHERE limita as linhas passadas para o GROUP BY, podendo reduzir a quantidade de grupos a serem formados
Nesse exemplo, como a coluna no WHERE/HAVING e GROUP BY � a mesma, fica semelhante a HAVING SalesPersonID > 280
Resultado igual ao anterior (acima)
*/
SELECT SalesPersonID AS ID_do_Vendedor, COUNT(SalesOrderID) AS Total_de_vendas
FROM Sales.SalesOrderHeader
WHERE SalesPersonID > 280
GROUP BY SalesPersonID
ORDER BY 2 DESC;

-- Clientes que fizeram mais de 10 compras em 2013:
-- HAVING COM WHERE
SELECT CustomerID AS ID_do_Cliente, COUNT(SalesOrderID) AS Total_de_Compras
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate)='2013'
GROUP BY CustomerID
HAVING COUNT(SalesOrderID) > 10
ORDER BY COUNT(SalesOrderID) DESC;

-- Colunas na Cl�usula HAVING
SELECT CustomerID AS ID_do_Cliente, COUNT(SalesOrderID) AS Total_de_Compras
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate)='2013'
GROUP BY CustomerID
HAVING COUNT(SalesOrderID) > 10
-- HAVING CustomerID) > 10
-- HAVING COUNT(SalesOrderID) > 22814
ORDER BY COUNT(SalesOrderID) DESC;

-- Clientes que fizeram mais de 10 compras em 2013:
-- Alias n�o permitido no Having
SELECT CustomerID AS ID_do_Cliente, COUNT(SalesOrderID) AS Total_de_Compras
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate)='2013'
GROUP BY CustomerID
HAVING Total_de_Compras > 10
ORDER BY COUNT(SalesOrderID) DESC;