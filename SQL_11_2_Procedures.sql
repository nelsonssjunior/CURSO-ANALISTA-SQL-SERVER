USE AdventureWorks2019
GO

-- Procedure sem parametros
CREATE PROCEDURE SP_Clientes_Australia AS
BEGIN
	SELECT CustomerID, AccountNumber
	FROM Sales.Customer
	WHERE TerritoryID IN(
							SELECT TerritoryID
							FROM Sales.SalesTerritory
							WHERE Name = 'Australia'
						)
	ORDER BY CustomerID DESC
END;
GO

EXEC SP_Clientes_Australia;
GO


DROP PROCEDURE SP_Insere_Departamento;

-- PROCEDDURES COM PARAMETROS
CREATE PROCEDURE SP_Insere_Departamento
-- Parametros de entrada e seus tipos de dados
	-- @DepartamentoID smallint ==> não é necessário pois a coluna é do tipo IDENTITY
	@Name nvarchar(50),
	@GroupName nvarchar (50)
	-- @ModifiedDate datetime ==> possui default que recupera getdate()
AS
BEGIN
	-- Exibindo non output os valores que serão inseridos
	PRINT @Name + ' ' + @GroupName;

	-- Exibido no output os valores parâmetros de entrada na tabela
	INSERT INTO HumanResources.Department
	VALUES (@Name, @GroupName, DEFAULT);
END;
GO

EXEC SP_Insere_Departamento @Name='EAD', @GroupName='Ensino'
GO

SELECT * FROM HumanResources.Department;

-- IF / ELSE
IF 1=1
	PRINT 'VERDADEIRO'
ELSE
	PRINT 'FALSO'
GO

-- IF COM SELECT
IF EXISTS (SELECT * FROM HumanResources.Department WHERE Name = 'EAD')
	PRINT 'Registro encontrado'
ELSE
	PRINT 'Registro NÃO encontrado'
GO

-- IF COM CAMANDOS DDL
IF OBJECT_ID ('SP_Clientes_Australia', 'P') IS NOT NULL
	DROP PROCEDURE SP_Clientes_Australia
ELSE
	PRINT 'Objeto inexistente'
GO

-- DECLARANDO VARIÁVEIS
DECLARE @VariavelNome VARCHAR(100)
SET @VariavelNome = 'Bootcamp IGTI - Analista de Banco de Dados'
PRINT @VariavelNome
GO

-- WHILE
DECLARE @Variavel1 INT
	SET @Variavel1 = 0
WHILE @Variavel1 <= 10
BEGIN
	PRINT @Variavel1
	SET @Variavel1 = @Variavel1 + 1
END
GO

-- CUIDADOS COM LOOPS INFINITOS
DECLARE @Variavel1 INT
SET @Variavel1 = 1

WHILE 1 = 1 OR 1 > 0
BEGIN
	PRINT @Variavel1
	SET @Variavel1 = @Variavel1 + 1
END
GO

-- TRY / CATCH COM PROCEDURES
-- ERRO NA RESOLUÇÃO DE NOME NÃO TRATADO NO TRY /CATCH
BEGIN TRY
	SELECT * FROM TabelaInexistente
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage
END CATCH
GO

-- ERRO NA RESOLUÇÃO DE NOME TRATADO NO TRY / CATCH
-- ERRO OCORRE EM NÍVEL DIFERENTE DO TRY / CATCH
CREATE PROCEDURE usp_procteste
AS
	SELECT * FROM TabelaInexistente;
GO

BEGIN TRY
	EXECUTE usp_procteste
END TRY
BEGIN CATCH
	SELECT
		ERROR_NUMBER() AS ErrorNumber,
		ERROR_MESSAGE() AS ErrorMessage
END CATCH
GO