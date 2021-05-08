USE AdventureWorks2019
GO

-- Fun��es MIN E MAX COM colunas num�ricas
SELECT MIN(UnitPrice) AS Pre�o_Minimo, MAX(UnitPrice) AS Pre�o_Maximo
FROM Sales.SalesOrderDetail;

-- Fun��es MIN e MAX com colunas do tipo Date
SELECT MIN(BirthDate) AS Nascido_Mais_Antigamente, MAX(BirthDate) AS Nascido_Mais_Recentemente
FROM HumanResources.Employee;

-- Fun��es MIN e MAX com colunas tipo STRING
SELECT MIN(Name) AS Primeiro_Nome_de_Produto, MAX(Name) AS Ultimo_Nome_de_Produto
FROM Production.Product;

-- MIN e MAX em Strings => Resultado semelhante usando TOP e ORDER BY
SELECT TOP (1) Name
FROM Production.Product
ORDER BY Name ASC;

SELECT MIN(Name)
FROM Production.Product;

-- Fun��o COUNT(*) X Fun��o COUNT(express�o)
SELECT COUNT(*) AS Total_de_Produtos,
	   COUNT(Color) AS Total_de_Produtos_com_cor
FROM Production.Product;

-- Fun��o SUM e AVG
SELECT SUM(LineTotal) AS Valor_Total_de_Vendas,
       AVG(LineTotal) AS Valor_Medio_de_Vendas
FROM Sales.SalesOrderDetail;

-- Calculando m�dia sem AVG
SELECT SUM(LineTotal)/COUNT(LineTotal) AS Valor_M�dio_de_Vendas_sem_AVG,
       AVG(LineTotal) AS Valor_Medio_de_Vendas
FROM Sales.SalesOrderDetail;

-- Exemplo com coluna sem fun��o de agrega��o e sem GROUP BY (erro)
SELECT AVG(UnitPrice) AS M�dia_Pre�o, MIN(OrderQty) AS Quantidade_m�nima,
	   MAX(UnitPriceDiscount) AS Disconto_M�ximo, ProductID
FROM Sales.SalesOrderDetail;

-- Fun��o de agrega��o em conjunto com outras fun��es
SELECT MIN(YEAR(orderdate)) AS Ano_da_Compra_Mais_Antiga,
	   MAX(YEAR(orderdate)) AS Ano_da_Compra_Mais_Recente
From Sales.SalesOrderHeader;

-- DISTINCT com fun��es de agrega��o
SELECT COUNT(DISTINCT CustomerID) AS Qtde_deVendas_Para_Clientes_Distintos,
	   COUNT(CustomerID) AS Qtde_deVendas_Para_Clientes_Distintos
FROM Sales.SalesOrderHeader;

-- Valores Nulos (<> de brranco) e fun��es de agrega��o.
SELECT AVG(Weight) AS "Peso_medio_dos_Produtos (Usando AVG - ok)",
	   SUM(Weight) / COUNT(Weight) AS [Peso_Medio_dos_Produtos(Sem AVG - OK)],
	   SUM(Weight) / COUNT(*) AS [Peso_Medio_dos_Produtos(Sem AVG - N�O OK)]
FROM Production.Product;

-- Tratando Valores Nulos
SELECT Weight AS "Sem peso", COALESCE (Weight,0) AS " Peso Zerado"
FROM Production.Product;



