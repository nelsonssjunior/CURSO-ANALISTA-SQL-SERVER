USE AdventureWorks2019
GO

-- CTE Simples
-- Quantidade de vendedores po ano
WITH Sales_CTE(SalesPersonID, SalesOrderID, SalesYear)
AS
-- DEFINE A CTE
(
	SELECT SalesPersonID, SalesOrderID, YEAR(OrderDate) AS SalesYear
	FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL
)
-- Consulta externa (outer query) referenciando a CTE
SELECT SalesPersonID, COUNT(SalesOrderID) AS TotalSales, SalesYear
FROM Sales_CTE
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear
GO

-- MULTIPLAS CTE'S
--QUANTIDADE E VALOR TOTAL DOS VENDEDORES POR ANO,
-- COM A META E O RESULTADO X META 9SE SUPEROU OU NÃO A META)
WITH Sales_CTE (SalesPersonID, TotalSales, SalesYear)
AS
-- DEFINE A QUERY DA PRIMEIRA CTE
(
	SELECT SalesPersonID, SUM(TotalDue) AS TotalSales, YEAR(OrderDate) AS SalesYear
	FROM Sales.SalesOrderHeader
	WHERE SalesPersonID IS NOT NULL
	GROUP BY SalesPersonID, YEAR(Orderdate)
),
-- USAR VIRGULA (,) PARA SEPARAR A DEFINIÇÃO DAS CTE'S
--DEFINE A QUERY DA SEGUNDA CTE, QUE PODE FAER REFERENCIA À CTE ANTERIOR
Sales_Quota_CTE (BusinessEntityID, SalesQuota, SalesQuotaYear)
AS
(
	SELECT BusinessEntityID, SUM(SalesQuota) AS SalesQuota, YEAR(QuotaDate) AS SalesQuotaYear
	FROM Sales.SalesPersonQuotaHistory
	GROUP BY BusinessEntityID, YEAR(QuotaDate)
)
-- CONSULTA EXTERNA (OUTER QUERY) RETOORNANDO COLUNAS DE AMBAS AS CTE'S
SELECT SalesPersonID
	, SalesYear
	, FORMAT (TotalSales,'C','en-us') AS TotalSales
	, SalesQuotaYear
	, FORMAT (SalesQuota, 'C', 'en-us') AS SalesQuota
	, FORMAT (TotalSales -SalesQuota, 'C', 'en-us') AS Amt_Above_or_Below_Quota
FROM Sales_CTE
JOIN Sales_Quota_CTE ON Sales_Quota_CTE.BusinessEntityID = Sales_CTE.SalesPersonID
AND Sales_CTE.SalesYear = Sales_Quota_CTE.SalesQuotaYear
ORDER BY SalesPersonID, SalesYear
GO

-- CTE RECURSIVA
WITH CTE_Recursiva (Nivel, Numero)
AS
(
	-- Ancora (nievl 1)
	SELECT 1 AS Nivel, 1 AS Numero

	UNION ALL

	-- Níveis recursivos
	SELECT Nivel + 1, Nivel AS "Nivel anterior"
	FROM CTE_Recursiva
	WHERE Numero > 100

)
SELECT *
FROM CTE_Recursiva
GO

-- Evitando loops infinitos
WITH CTE_Recursiva (Nivel, Numero)
AS
(
	-- Ancora (nievl 1)
	SELECT 1 AS Nivel, 1 AS Numero

	UNION ALL

	-- Níveis recursivos
	SELECT Nivel + 1, Nivel AS "Nivel anterior"
	FROM CTE_Recursiva
	WHERE Numero < 10

)
SELECT *
FROM CTE_Recursiva
OPTION (MAXRECURSION 50);
GO

-- CTE RECURSIVA PARA LISTAR FUNCIONÁRIOS DE FORMA HIERARQUICA
-- TABELA DE FUNCIONÁRIOS

CREATE TABLE dbo.MyEmployees
(
EmployeeID smallint NOT NULL,
FirstName nvarchar(30) NOT NULL,
LastName nvarchar(40) NOT NULL,
Title nvarchar(50) NOT NULL,
DeptID smallint NOT NULL,
ManagerID int NULL,
	CONSTRAINT PK_EmployeeID PRIMARY KEY CLUSTERED (EmployeeID ASC)
);

-- Cadastrar os funcionários
INSERT INTO dbo.MyEmployees VALUES
 (1, N'Ken', N'Sánches', N'Chief Executive Officer', 16, NULL)
,(273, N'Brian', N'Welcker', N'Vice President of Sales',3,1)
,(274, N'Stephen', N'Jiang', N'Noth America Sales Manager',3,273)
,(275, N'Michael', N'Blithe', N'Sales Representative',3,274)
,(276, N'Linda', N'Mitchell', N'Sales Representative',3,274)
,(285, N'Syed', N'Abbas', N'Pacific Sales Manager',3,273)


-- CTE RECURSIVA PARA LER OS FUNCIONÁRIOS O OS SEUS CHEFES IMEDIATOS
WITH DirectReports AS
(
	SELECT EmployeeID, Title, FirstName, LastName, ManagerID,0 AS EmployeeLevel
	FROM dbo.MyEmployees
	WHERE ManagerID IS NULL
	UNION ALL
	SELECT e.EmployeeID, e.Title, e.FirstName, e.LastName, e.ManagerID, EmployeeLevel + 1
	FROM dbo.MyEmployees AS e
		INNER JOIN DirectReports AS d
		ON e.ManagerID = d.EmployeeID
)
SELECT *
FROM DirectReports
ORDER BY EmployeeLevel;
