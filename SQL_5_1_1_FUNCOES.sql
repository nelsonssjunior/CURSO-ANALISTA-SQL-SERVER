USE AdventureWorks2019
GO

-- Funções MIN E MAX COM colunas numéricas
SELECT MIN(UnitPrice) AS Preço_Minimo, MAX(UnitPrice) AS Preço_Maximo
FROM Sales.SalesOrderDetail;

-- Funções MIN e MAX com colunas do tipo Date
SELECT MIN(BirthDate) AS Nascido_Mais_Antigamente, MAX(BirthDate) AS Nascido_Mais_Recentemente
FROM HumanResources.Employee;

-- Funções MIN e MAX com colunas tipo STRING
SELECT MIN(Name) AS Primeiro_Nome_de_Produto, MAX(Name) AS Ultimo_Nome_de_Produto
FROM Production.Product;

-- MIN e MAX em Strings => Resultado semelhante usando TOP e ORDER BY
SELECT TOP (1) Name
FROM Production.Product
ORDER BY Name ASC;

SELECT MIN(Name)
FROM Production.Product;

-- Função COUNT(*) X Função COUNT(expressão)
SELECT COUNT(*) AS Total_de_Produtos,
	   COUNT(Color) AS Total_de_Produtos_com_cor
FROM Production.Product;

-- Função SUM e AVG
SELECT SUM(LineTotal) AS Valor_Total_de_Vendas,
       AVG(LineTotal) AS Valor_Medio_de_Vendas
FROM Sales.SalesOrderDetail;

-- Calculando média sem AVG
SELECT SUM(LineTotal)/COUNT(LineTotal) AS Valor_Médio_de_Vendas_sem_AVG,
       AVG(LineTotal) AS Valor_Medio_de_Vendas
FROM Sales.SalesOrderDetail;

-- Exemplo com coluna sem função de agregação e sem GROUP BY (erro)
SELECT AVG(UnitPrice) AS Média_Preço, MIN(OrderQty) AS Quantidade_mínima,
	   MAX(UnitPriceDiscount) AS Disconto_Máximo, ProductID
FROM Sales.SalesOrderDetail;

-- Função de agregação em conjunto com outras funções
SELECT MIN(YEAR(orderdate)) AS Ano_da_Compra_Mais_Antiga,
	   MAX(YEAR(orderdate)) AS Ano_da_Compra_Mais_Recente
From Sales.SalesOrderHeader;

-- DISTINCT com funções de agregação
SELECT COUNT(DISTINCT CustomerID) AS Qtde_deVendas_Para_Clientes_Distintos,
	   COUNT(CustomerID) AS Qtde_deVendas_Para_Clientes_Distintos
FROM Sales.SalesOrderHeader;

-- Valores Nulos (<> de brranco) e funções de agregação.
SELECT AVG(Weight) AS "Peso_medio_dos_Produtos (Usando AVG - ok)",
	   SUM(Weight) / COUNT(Weight) AS [Peso_Medio_dos_Produtos(Sem AVG - OK)],
	   SUM(Weight) / COUNT(*) AS [Peso_Medio_dos_Produtos(Sem AVG - NÃO OK)]
FROM Production.Product;

-- Tratando Valores Nulos
SELECT Weight AS "Sem peso", COALESCE (Weight,0) AS " Peso Zerado"
FROM Production.Product;



