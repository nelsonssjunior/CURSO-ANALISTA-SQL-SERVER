-- Altera��o no Banco de Dados
USE [master]
GO

ALTER DATABASE [AdventureWorks2019]
ADD FILE ( NAME = N'AdventureWorks2019_02',
		   FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AdventureWorks2019_Data_02.ndf',
		   SIZE = 8192KB, FILEGROWTH = 65536KB
		   )
TO FILEGROUP [PRIMARY]
GO

--Altera��o de Objetos no Banco de Dados

-- Selecionar o banco
USE [BDTESTE2]
GO

-- ADICIONAR CHAVE PRIM�RIA
ALTER TABLE ALUNO
ADD CONSTRAINT PK_ALUNO PRIMARY KEY CLUSTERED -- A tabela � ordenada pela chave prim�ria PK_ALUNO--
(
	COD_ALUNO
);

ALTER TABLE CURSO
ADD CONSTRAINT PK_CURSO PRIMARY KEY CLUSTERED -- A tabela � ordenada pelo curso --
(
	COD_CURSO
);

-- Verificando a estrutura da tabela (DESC/DESCRIBE)
EXEC sp_help 'CURSO';
EXEC sp_help 'ALUNO';

-- Adicionar coluna  COD_CURSO_FK na tabela ALUNO como n�o nula (tabela n�o populada ainda) --
ALTER TABLE ALUNO ADD COD_CURSO_FK int NOT NULL;

-- Adicionar tamanho da coluna NOM_CURSO
ALTER TABLE CURSO ALTER COLUMN NOM_CURSO VARCHAR(200) NOT NULL;

--Diminuir tamanho
ALTER TABLE CURSO ALTER COLUMN NOM_CURSO VARCHAR (50)NOT NULL;

-- Inserindo dados na tabela CURSO
INSERT INTO CURSO VALUES (1, 'Linguagem SQL');
INSERT INTO CURSO VALUES (2, 'T-SQL');

-- Conferir se os dados foram inseridos
SELECT * FROM CURSO;

-- Tamanho dos valores da coluna NOM_CURSO
SELECT COD_CURSO, LEN(NOM_CURSO) FROM CURSO;

-- DIMINUIR TAMANHO DA TABELA COM TABELA POPULADA COM TAMANHO DOS DADOS EXISTENTES
ALTER TABLE CURSO ALTER COLUMN NOM_CURSO VARCHAR(13) NOT NULL;

SP_HELP CURSO;

-- DIMINUIR TAMANHO DA TABELA COM TABELA POPULADA COM TAMANHO DOS DADOS EXISTENTES
ALTER TABLE CURSO ALTER COLUMN NOM_CURSO VARCHAR(12) NOT NULL;

-- Adicionar campo NOT NULL com tabela populada
--Op��o 1
ALTER TABLE CURSO ADD VLR_CURSO money NOT NULL; -- Error
ALTER TABLE CURSO ADD VLR_CURSO money NULL;
ALTER TABLE CURSO ALTER  COLUMN VLR_CURSO money NOT NULL; -- Error
UPDATE CURSO SET VLR_CURSO = 10000;
SELECT * FROM CURSO;
ALTER TABLE CURSO ALTER COLUMN VLR_CURSO money NOT NULL;
SP_HELP CURSO;

-- Op��o 2
ALTER TABLE CURSO ADD IND_STATUS CHAR(1) NOT NULL DEFAULT 'S';
SELECT * FROM CURSO;
SP_HELP CURSO;

-- Adicionar chave estrangeira COD_CURSO_FK na tabela ALUNO
ALTER TABLE ALUNO
ADD CONSTRAINT FK_ALUNO_CURSO FOREIGN KEY
(
	COD_CURSO_FK
) REFERENCES CURSO
(
	COD_CURSO
)
ON UPDATE NO ACTION
ON DELETE NO ACTION;

SP_HELP ALUNO
GO