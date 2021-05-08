USE AdventureWorks2019
GO

-- Classificando Ascendente pelo primeiro nome com a instrução ORDER BY (DEFAULT ASC)
SELECT FirstName, MiddleName, LastName
FROM Person.Person
ORDER BY FirstName;

-- Classificando de modo descendente pelo primeiro Nome com a instrução ORDER BY
SELECT FirstName, MiddleName, LastName
FROM Person.Person
ORDER BY FirstName DESC;

-- CLassificação Ascendente pelo primeiro nome e descendente pelo último
SELECT FirstName, MiddleName, LastName
FROM Person.Person
ORDER BY FirstName ASC, LastName DESC;

-- Usando campo que não está na tabela ou listas de colunas para ordenar
SELECT FirstName, MiddleName, LastName
FROM Person.Person
ORDER BY ModifiedDate ASC;

-- Usando ALIAS de coluna no Order BY
SELECT Name AS Nome_do_Produto, ProductNumber AS Número_do_Produto
FROM Production.Product
ORDER BY Nome_do_Produto ASC;

-- Usando numero da coluna no ORDER BY
SELECT Name AS Nome_do_Produto, ProductNumber AS Número_do_Produto
FROM Production.Product
ORDER BY 1 ASC;

SELECT FirstName, MiddleName, LastName
FROM Person.Person
ORDER BY 1 ASC, 3 ASC;
-- Igual à:
-- SELECT FirstName, MiddleName, LastName
-- FROM Person.Person
-- ORDER BY FirstName ASC, LastName DESC;

-------------------------------------- Filtrando Dados ------------------------------------
USE AdventureWorks2019
GO

-- Exemplo de filtros com operadores de comparação

-- Listar Produtos da cor preta (Black)
SELECT Name, Color
FROM Production.Product
WHERE Color = 'Black'
ORDER BY Name;

-- Listar Produtos que não são da cor preta (Black)
SELECT Name, Color
FROM Production.Product
WHERE Color <> 'Black'
ORDER BY Name;

-- Listar Produtos com valor de venda superior a 1.000
SELECT Name AS Produto, Color AS Cor, ListPrice AS "Preço de Lista"
FROM Production.Product
WHERE ListPrice > 1000
ORDER BY Name;


-- Exemplo de filtros com operadores lógicos.

-- Operador LIKE + %
-- Listar Produtos com Nome que Iniciam com 'Chain'
SELECT Name, Color
FROM Production.Product
WHERE Name LIKE 'Chain%'
ORDER BY Name;

-- Listar produtos com nome que tenham 'Chainring' no Nome (em qualquer posição)
SELECT Name, Color
FROM Production.Product
WHERE Name LIKE '%Chainring%'
ORDER BY Name;

-- Operador LIKE +_
-- Listar produtos cujo Nome possua a letra "a" como segunda letra
SELECT Name, Color
FROM Production.Product
WHERE Name LIKE '_a%'
ORDER BY Name;

-- Ordem de avaliação de operadores
-- Listar produtos com Nome que iniciam com 'Chain' e que sejam da cor preta ou prata
SELECT Name, Color
FROM Production.Product
WHERE Name LIKE 'Chain%'
AND (Color = 'Black' OR Color = 'Silver')
ORDER BY Name;

/*
Se não tivessem os parênteses "forçando a ordem de avaliação" seria:
Listar produtos com Nome que iniciam com 'Chain' e que sejam da cor preta (AND avaliando prmeiro que o OR)
ou todos produtos da cor preta
*/
SELECT Name, Color
FROM Production.Product
WHERE Name LIKE 'Chain%'
AND Color = 'Black' OR Color = 'Silver'
ORDER BY Color;

-- Mesmo resultado acima pois o AND foi processado primeiro
SELECT Name, Color
FROM Production.Product
WHERE (Name LIKE 'Chain%'
AND Color = 'Black') OR Color = 'Silver'
ORDER BY Color;

-- Alias de coluna na clausula WHERE (ERRO)
SELECT Name AS Nome_Produto, Color AS Cor
FROM Production.Product
WHERE Nome_Produto LIKE 'Chain%'
ORDER BY Nome_produto, Cor;


-- Uso de TOP para retornar os primeiros valores
SELECT TOP (5) Name AS Nome_Produto
FROM Production.Product
ORDER BY Nome_Produto;

-- Impacto do ORDER BY na clausula TOP
SELECT TOP (5) Name AS Nome_Produto
FROM Production.Product
ORDER BY Nome_Produto DESC;

-- USO de TOP para retornar 10% do total de produtos
SELECT TOP (10) PERCENT Name AS Nome_Produto
FROM Production.Product
ORDER BY Nome_Produto;

-- Uso de OFFSET - FETCH para "Paginar" Dados
-- Retornar os primeiros 50 registros
SELECT Name AS Nome_Produto
FROM Production.Product
ORDER BY Nome_Produto
OFFSET 0 ROWS FETCH FIRST 50 ROWS ONLY;

-- Retornar do 51° ao 100° produto
SELECT Name AS Nome_Produto
FROM Production.Product
ORDER BY Nome_Produto
OFFSET 50 ROWS FETCH FIRST 50 ROWS ONLY;

-- Uso de DISTINCT para retornar as cores existentes de produtos eliminando as repetidas
SELECT DISTINCT Color AS [Cores_de_Produto]
FROM Production.Product
WHERE Color IS NOT NULL
ORDER BY [Cores_de_Produto];

-- Sem o DISTINCT
SELECT Color AS [Cores_de_Produto]
FROM Production.Product
WHERE Color IS NOT NULL
ORDER BY [Cores_de_Produto];

-- Uso de DISTINC em Multiplas Colunas
SELECT DISTINCT Name AS Nome_Produto, Color AS [Cores_de_Produto]
FROM Production.Product
WHERE Color IS NOT NULL
ORDER BY Nome_Produto, Cores_de_Produto;

SELECT FirstName, MiddleName, LastName
FROM Person.Person
ORDER BY FirstName, MiddleName, LastName;