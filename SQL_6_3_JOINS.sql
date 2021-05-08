USE AdventureWorks2019
GO

-- JOIN com Operador de comparação (Inner Join ANSI-89)
-- Sem alias
-- Listar categorias e subcategorias
SELECT Production.ProductCategory.Name AS Nome_da_Categoria,
	   Production.ProductSubcategory.Name AS Nome_da_Subcategoria
FROM Production.ProductCategory, Production.ProductSubcategory
WHERE Production.ProductCategory.ProductCategoryID = Production.ProductSubcategory.ProductCategoryID
ORDER BY Nome_da_Categoria ASC, Nome_da_Subcategoria ASC;

/*
Listar produtos, Categorias e Subcategorias
Joins com mais de 2 tableas (ANSI SQL-89)
Refência FQN às tabelas
Ordem das tabelas no JOIN/ Ordem dos JOINS */
SELECT Production.Product.Name AS Nome_do_Produto,
	   Production.ProductSubcategory.Name AS Nome_da_Subcategoria,
	   Production.ProductCategory.Name AS Nome_da_Categoria
FROM Production.Product, Production.ProductCategory, Production.ProductSubcategory
WHERE Production.Product.ProductSubcategoryID = Production.ProductSubcategory.ProductCategoryID
AND   Production.ProductCategory.ProductCategoryID = Production.ProductSubcategory.ProductCategoryID
ORDER BY Nome_do_Produto ASC;

-- Listar produtos, categorias e Subcatrgorias
-- JOIN ANSI - 89
-- Usando Alias
SELECT P.Name AS Nome_do_Produto,
	   S.Name AS Nome_da_SubCategoria,
	   C.Name AS Nome_da_Categoria
FROM Production.Product P, Production.ProductCategory C, Production.ProductSubcategory S
WHERE P.ProductSubcategoryID = S.ProductSubcategoryID
AND   C.ProductCategoryID = S.ProductCategoryID
ORDER BY Nome_do_Produto ASC;

-- Produto cartesiano (ANSI SQL-89)
SELECT Production.ProductCategory.Name AS Nome_da_Categoria,
	   Production.ProductSubcategory.Name AS Nome_da_Sub_Categoria
FROM Production.ProductCategory, Production.ProductSubcategory
ORDER BY Nome_da_Categoria ASC, Nome_da_Sub_Categoria ASC;

-------------------------------------------------------- JOIN PADRÃO ANSI-92 ----------------------------------------------------

-- INNER JOIN
-- Listar Categorias e SubCategorias
SELECT Production.ProductCategory.Name AS Nome_da_Categoria,
	   Production.ProductSubcategory.Name AS Nome_da_SubCategoria
FROM Production.ProductCategory
INNER JOIN Production.ProductSubcategory
ON Production.ProductCategory.ProductCategoryID = Production.ProductSubcategory.ProductCategoryID
ORDER BY Nome_da_Categoria ASC, Nome_da_SubCategoria ASC;

-- Listar Produtos, Categorias e Subcategorias
-- Padrão ANSI SQL-92
-- Usando Alias
SELECT P.Name AS Nome_do_Produto,
	   S.Name AS Nome_da_SubCategoria,
	   C.Name AS Nome_da_Categoria
FROM Production.Product P
INNER JOIN Production.ProductSubCategory S
ON P.ProductSubCategoryID = S.ProductSubcategoryID
INNER JOIN Production.ProductCategory C
ON C.ProductCategoryID = S.ProductCategoryID
ORDER BY Nome_do_Produto ASC;

--------- SELF INNER JOIN

CREATE TABLE Employee
(
ID INT PRIMARY KEY,
Name VARCHAR(50),
ID_Manager INT
);

INSERT INTO Employee(ID,Name,ID_Manager) VALUES (01,'Juliana',NULL);
INSERT INTO Employee(ID,Name,ID_Manager) VALUES (02,'Gustavo',01);
INSERT INTO Employee(ID,Name,ID_Manager) VALUES (03,'Giovana',02);
INSERT INTO Employee(ID,Name,ID_Manager) VALUES (04,'Davi',02);
INSERT INTO Employee(ID,Name,ID_Manager) VALUES (05,'Pedro',02);
INSERT INTO Employee(ID,Name,ID_Manager) VALUES (06,'Guilherme',01);

SELECT * FROM Employee;

-- Listar funcionário e o Respectivo Gerente
SELECT E1.Name AS Funcionário, E2.Name AS Gerente
FROM Employee AS E1
INNER JOIN Employee AS E2
ON E1.ID_Manager = E2.ID
ORDER BY E1.Name;

------------------ LEFT JOIN -------------------------------------------------------------------------------------------------
-- LISTAR TODOS (com vendas ou não) os produtos e seus valores venais
SELECT P.Name AS Nome_Produto, S.UnitPrice AS Valor_na_Venda
FROM Production.Product P
LEFT JOIN Sales.SalesOrderDetail S
ON P.ProductID = S.ProductID
ORDER BY Nome_Produto ASC, Valor_na_Venda ASC;

-- Aula 6.3 - 14:15 m

-- Invertendo a Ordem das tabelas: Listar TODAS as Vendas e seus produtos
SELECT P.Name AS Nome_Produto, S.UnitPrice AS Valor_na_Venda
FROM Sales.SalesOrderDetail S
LEFT JOIN Production.Product P
ON P.ProductID = S.ProductID
ORDER BY Nome_Produto ASC, Valor_na_Venda ASC;

-- RIGHT OUTER JOIN
-- LISTAR TODOS OS PRODUTOS (COM VENDAS OU NÃO) E SEUS VALORES VENAIS
SELECT P.Name AS Nome_Produto, S.UnitPrice AS Valor_na_Venda
FROM Sales.SalesOrderDetail S
RIGHT JOIN Production.Product P
ON P.ProductID = S.ProductID
ORDER BY Nome_Produto ASC, Valor_na_Venda ASC;

-- VERSUS
-- Listar TODOS os produtos (com vendas ou não) e seus Valores Venais
SELECT P.Name AS Nome_Produto, S.UnitPrice AS Valor_na_Venda
FROM Production.Product P 
RIGHT JOIN Sales.SalesOrderDetail S
ON P.ProductID = S.ProductID
ORDER BY Nome_Produto ASC, Valor_na_Venda ASC;

-- FULL OUTER JOIN
-- Listar todos os produtos e todos os modelos
SELECT P.Name AS Nome__Produto, M.Name AS Modelo
FROM Production.Product P
FULL JOIN Production.ProductModel M
ON P.ProductModelID = M.ProductModelID
ORDER BY Nome__Produto, Modelo;

--Se executar a ordem inversa neste Join teremos o mesmo resultado
