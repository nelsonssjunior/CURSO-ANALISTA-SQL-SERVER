USE BDProducoes;

-- Criar tabela AUtoria
CREATE TABLE [dbo].[Autoria](
[cod_Autoria] [int] IDENTITY(1,1) NOT NULL,
[cod_titulo] [int] NOT NULL,
[cod_pessoa] [int] NOT NULL,
CONSTRAINT [PK_Autoria] PRIMARY KEY CLUSTERED
(
[cod_Autoria] ASC
)
)
GO

-- Criar tabela avaliação
CREATE TABLE [dbo].[Avaliacao](
[cod_titulo] [int] NOT NULL,
[classificacao_media] [int] NOT NULL,
[qtd_votos] [int] NOT NULL
)
GO--Criar tabela direçãoCREATE TABLE [dbo].[Direcao](
[cod_direcao] [int] IDENTITY(1,1) NOT NULL,
[cod_titulo] [int] NOT NULL,
[cod_pessoa] [int] NOT NULL,
CONSTRAINT [PK_Direcao] PRIMARY KEY CLUSTERED
(
[cod_direcao] ASC
)
)
GO-- Criar tabela elencoCREATE TABLE [dbo].[Elenco](
[cod_elenco] [int] IDENTITY(1,1) NOT NULL,
[cod_titulo] [int] NOT NULL,
[cod_pessoa] [int] NOT NULL,
[dsc_funcao] [varchar](1000) NOT NULL,
[desc_personagem] [varchar](1000) NULL,
CONSTRAINT [PK_Elenco_1] PRIMARY KEY CLUSTERED
(
[cod_elenco] ASC
)
)
GO
-- Criar tabela pessoa
CREATE TABLE [dbo].[Pessoa](
[cod_pessoa] [int] NOT NULL,
[nom_pessoa] [varchar](500) NOT NULL,
[ano_nascimento] [int] NULL,
[ano_falescimento] [int] NULL,
[dsc_profissao] [varchar](1000) NULL,
CONSTRAINT [PK_Pessoa] PRIMARY KEY CLUSTERED
(
[cod_pessoa] ASC
)
)
GO

-- Criar tabela Título
CREATE TABLE [dbo].[Titulo](
[cod_titulo] [int] NOT NULL,
[nom_titulo] [varchar](1000) NULL,
CONSTRAINT [PK_Titulo] PRIMARY KEY CLUSTERED
(
[cod_titulo] ASC
)
)
GO

-- Criar tabela  titulo_detalhe
CREATE TABLE [dbo].[Titulo_Detalhe](
[cod_titulo] [int] NOT NULL,
[tip_titulo] [varchar](100) NOT NULL,
[nom_principal_titulo] [varchar](1000) NOT NULL,
[nom_original_titulo] [varchar](1000) NOT NULL,
[ind_adulto] [bit] NOT NULL,
[ano_lancamento] [int] NOT NULL,
[qtd_minutos] [smallint] NULL,
[dsc_genero] [varchar](1000) NULL
)
GO

