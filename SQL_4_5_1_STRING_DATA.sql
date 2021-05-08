USE AdventureWorks2019
GO

-- FUNÇÕES DE CARACTERES
-- LOWER com Strings
SELECT LOWER ('Aplicações com Linguagem SQL') AS Nome_Disciplina
GO

-- LOWER com Coluna
SELECT Name AS Nome_Original, LOWER (Name) AS Nome_Minusculo
From Production.Product
Order By Name
GO

-- UPPER
SELECT UPPER ('Aplicações com Linguagem SQL') AS Nome_Disciplina
GO

SELECT Name AS Nome_Original, UPPER (Name) AS Nome_Minusculo
From Production.Product
Order By Name
GO

-- SUBSTRING
SELECT SUBSTRING ('Aplicações com Linguagem SQL', 16,13) AS Parte_da_String
GO

SELECT Name AS Nome_Original, SUBSTRING (Name,5,15) AS Parte_do_Nome
FROM Production.Product
ORDER BY Name
GO

-- LEFT
SELECT LEFT ('Aplicações com Linguagem SQL', 10) AS Parte_Esquerda
GO

SELECT Name AS Nome_Original, LEFT (Name,5) AS Parte_do_Nome
FROM Production.Product
ORDER BY Name
GO

-- RIGHT
SELECT RIGHT ('Aplicações com Linguagem SQL', 10) AS Parte_Direita
GO

SELECT Name AS Nome_Original, RIGHT (Name,5) AS Parte_do_Nome
FROM Production.Product
ORDER BY Name
GO

-- LEN
SELECT LEN ('Aplicações com Linguagem SQL') AS QTD_Caracteres
GO

SELECT LEN ('Aplicações com Linguagem SQL    ') AS QTD_Caracteres
GO

SELECT Name AS Nome_Original, LEN (Name) AS Total_Caracteres_Nome
FROM Production.Product
ORDER BY Name
GO

-- DATALENGTH
SELECT DATALENGTH ('Aplicações com Linguagem SQL') AS QTD_Com_DATALENGTH,
LEN ('Aplicações com Linguagem SQL') AS QTD_Caracteres_LEN
GO

SELECT DATALENGTH ('Aplicações com Linguagem SQL   ') AS QTD_Com_DATALENGTH,
			  LEN ('Aplicações com Linguagem SQL   ') AS QTD_Caracteres_LEN
GO

-- CHARINDEX
SELECT CHARINDEX ('SQL', 'Aplicações com Linguagem SQL   ') AS Inicio_String_SQL,
	   CHARINDEX ('T-SQL', 'Aplicações com Linguagem SQL   ') AS Inicio_String_T_SQL
GO
-- Especificando uma posição de inicio para a brusca
SELECT CHARINDEX ('SQL', 'Aplicações com Linguagem SQL', 27) AS A_Partir_da_27
GO

-- REPLACE
SELECT REPLACE ('Aplicações com Linguagem ABC', 'ABC', 'SQL') AS String_Trocada
GO

--Retirar espaço em branco dos nomes
SELECT Name AS Nome_Original, REPLACE (Name, ' ', '') AS Nome_Sem_Espaço
FROM Production.Product
ORDER BY Name
GO

-- REPLICATE
SELECT REPLICATE ('SQL', 5) AS String_Replicada
GO

-- EXIBIR ZEROS À ESQUERDA DE UMA COLUNA
SELECT Name AS Nome, ProductNumber,
		REPLICATE ('0', 5) + '-' + ProductNumber AS New_ProductNumber
FROM Production.Product
ORDER BY Name
GO

-- REPLICATE
SELECT REPLICATE ('SQL', 5) AS String_Replicada
GO

-- Exibir Zeros à esquerda de uma coluna
SELECT Name AS Nome, Productnumber,
	REPLICATE ('0',5) + '-' + ProductNumber AS New_productNumber
FROM Production.Product
ORDER BY Name
GO

-- REVERSE
SELECT REVERSE ('Linguagem SQL') AS String_Invertida
GO

-- LTRIM
SELECT LTRIM ('  Aplicações com linguagem SQL') AS Espaços_removidos_a_esquerda
GO

-- RTRIM
SELECT RTRIM ('Aplicações com linguagem SQL    ') AS Espaços_removidos_a_DIREITA
GO

-- TRIM
SELECT TRIM ('  linguagem SQL    ') AS Espaços_removidos
GO

-- TRIM COM FROM
SELECT TRIM ('#!' FROM '##  Linguagem SQL  !##') AS TRIMcomFROM
GO

-- CONCAT
SELECT CONCAT ('Aplicações','com','Linguagem','SQL') AS StringConcatenada
GO

-- CONCAT X Operador de concatenação (*NULOS)
SELECT FirstName + ' ' + MiddleName + ' ' + LastName AS NomeCompleto_com_Operador,
		CONCAT (FirstName,' ', MiddleName, ' ', LastName) AS Nome_completo_com_CONCAT
FROM Person.Person
GO

-- USO DE FUNÇÕES DE CARACTERES EM CONJUNTO
SELECT FirstName, MiddleName, LastName,
		REPLACE(UPPER(CONCAT(FirstName, ' ',MiddleName,' ', LastName)),' ','_') AS NomeMaíusculoCom_
FROM PersOn.Person
Go

-- Fazendo TRIM com LTRIM + RTRIM
SELECT LTRIM(RTRIM('    Linguagem SQL   ')) AS Removidos
GO

--------------------------------------- DATA E HORAS ------------------------------------
USE AdventureWorks2019
GO

-- Separando Dia, Mês, e Ano da Data
SELECT DISTINCT DueDate AS Data_e_hora_Vencimento,
		DAY (DueDate) AS Dia_Vencimento,
		MONTH (DueDate) AS Mês_Vencimento,
		YEAR (DueDate) AS Ano_Vencimento
FROM Purchasing.PurchaseOrderDetail
ORDER BY DueDate DESC
GO

-- Data e Hora do sistema (ANSI/ SQL)
SELECT CURRENT_TIMESTAMP AS Data_Hora_Sistema,
	   GETDATE() AS Data_Hora_Sistema
GO

SELECT DAY (CURRENT_TIMESTAMP) AS Dia_Hoje,
	   MONTH (CURRENT_TIMESTAMP) AS Mês_Hoje,
	   YEAR (CURRENT_TIMESTAMP) AS Ano_Hoje
GO

-- DATENAME
SELECT DATENAME (weekday,GETDATE()) AS Dia_da_Semana,
	   DATENAME (hh,GETDATE()) AS Hora,
	   DATENAME (minute,GETDATE()) AS Minutos
GO

SET LANGUAGE Português
GO
SELECT @@LANGUAGE
GO
SELECT DATENAME (weekday,GETDATE()) AS Dia_da_Semana,
	   DATENAME (hh,GETDATE()) AS Hora,
	   DATENAME (minute,GETDATE()) AS Minutos
GO

-- Funções de Data e Hora com operador de concatenação
SELECT DATENAME(weekday,GETDATE()) + ', ' + DATENAME(day,GETDATE()) + ' de ' +
		DATENAME(month,GETDATE()) + ' de ' + DATENAME(yyyy,GETDATE()) +
		' às ' + DATENAME(hh,GETDATE()) + ':' + DATENAME(n,GETDATE()) AS "Data e hora por extenso"
GO

-- DATEDIFF (datepart, data_inicial, data_final)
-- Calcular diferença entre duas datas

-- Resultado em DIAS
SELECT DATEDIFF(day, '31/12/2018 23:59:59', '01/01/2019 00:00:00');
SELECT DATEDIFF(day, '31-12-2018', '07-01-2019');
SELECT DATEDIFF(day, '2018','2019');

-- Resultado em horas
SELECT DATEDIFF(hour, '31/12/2018 23:59:59', '01/01/2019 00:00:00');
SELECT DATEDIFF(hour, '31-12-2018', '07-01-2019');
SELECT DATEDIFF(hour, '2018','2019');

-- Resultado em MINUTOS
SELECT DATEDIFF(minute, '31/12/2018 23:59:59', '01/01/2019 00:00:00');
SELECT DATEDIFF(minute, '31-12-2018', '07-01-2019');
SELECT DATEDIFF(minute, '2018','2019');


-- DATEADD (datepart, Quantidade, Data)
-- Adicionar 1 hora à uma data
SELECT DATEADD (hour, 1, '01/01/2019 00:30:00');

-- Adicionar 2 horas à uma data
SELECT DATEADD (hour, 2, '01/01/2019 22:30:00');

-- Adicionar 6 meses à uma data
SELECT DATEADD (month, 6, '15/01/2019 00:30:00');

-- ISDATE para testar uma espressão datetime válida

IF ISDATE('12-01-2019 08:23:45.655') = 1
	PRINT 'VALID'
ELSE
	PRINT 'INVALID';

IF ISDATE('12-01-2019 08:63:45.65555') = 1
	PRINT 'VALID'
ELSE
	PRINT 'INVALID';

SELECT ISDATE ('09/09/2019'), ISDATE('09/092019'), ISDATE('09/09-2019');