-- Alterando os dados nas tabelas

USE [BDProducoes];

-- Inserindo FK na tabela autoria
ALTER TABLE [dbo].[Autoria] WITH CHECK ADD CONSTRAINT [FK_Autoria_Pessoa] FOREIGN
KEY([cod_pessoa])
REFERENCES [dbo].[Pessoa] ([cod_pessoa])
GO

ALTER TABLE [dbo].[Autoria] CHECK CONSTRAINT [FK_Autoria_Pessoa]
GO

ALTER TABLE [dbo].[Autoria] WITH CHECK ADD CONSTRAINT [FK_Autoria_Titulo] FOREIGN
KEY([cod_titulo])
REFERENCES [dbo].[Titulo] ([cod_titulo])
GO
ALTER TABLE [dbo].[Autoria] CHECK CONSTRAINT [FK_Autoria_Titulo]
GO

ALTER TABLE [dbo].[Avaliacao] WITH CHECK ADD CONSTRAINT [FK_Avaliacao_Titulo]
FOREIGN KEY([cod_titulo])
REFERENCES [dbo].[Titulo] ([cod_titulo])
GO
ALTER TABLE [dbo].[Avaliacao] CHECK CONSTRAINT [FK_Avaliacao_Titulo]
GO

ALTER TABLE [dbo].[Direcao] WITH CHECK ADD CONSTRAINT [FK_Direcao_Pessoa] FOREIGN
KEY([cod_pessoa])
REFERENCES [dbo].[Pessoa] ([cod_pessoa])
GO
ALTER TABLE [dbo].[Direcao] CHECK CONSTRAINT [FK_Direcao_Pessoa]
GO

ALTER TABLE [dbo].[Direcao] WITH CHECK ADD CONSTRAINT [FK_Direcao_Titulo] FOREIGN
KEY([cod_titulo])
REFERENCES [dbo].[Titulo] ([cod_titulo])
GO
ALTER TABLE [dbo].[Direcao] CHECK CONSTRAINT [FK_Direcao_Titulo]
GO

ALTER TABLE [dbo].[Elenco] WITH CHECK ADD CONSTRAINT [FK_Elenco_Pessoa] FOREIGN
KEY([cod_pessoa])
REFERENCES [dbo].[Pessoa] ([cod_pessoa])
GO
ALTER TABLE [dbo].[Elenco] CHECK CONSTRAINT [FK_Elenco_Pessoa]
GO

ALTER TABLE [dbo].[Elenco] WITH CHECK ADD CONSTRAINT [FK_Elenco_Titulo] FOREIGN
KEY([cod_titulo])
REFERENCES [dbo].[Titulo] ([cod_titulo])
GO
ALTER TABLE [dbo].[Elenco] CHECK CONSTRAINT [FK_Elenco_Titulo]
GO

ALTER TABLE [dbo].[Titulo_Detalhe] WITH CHECK ADD CONSTRAINT
[FK_Titulo_Detalhe_Titulo] FOREIGN KEY([cod_titulo])
REFERENCES [dbo].[Titulo] ([cod_titulo])
GO
ALTER TABLE [dbo].[Titulo_Detalhe] CHECK CONSTRAINT [FK_Titulo_Detalhe_Titulo]
GO

ALTER TABLE dbo.Titulo
ALTER COLUMN nom_titulo VARCHAR(1000) NOT NULL
GO
ALTER TABLE Pessoa ALTER COLUMN nom_pessoa varchar(1000) NOT NULL
GO
ALTER TABLE Titulo ADD ind_status char(1) NOT NULL CONSTRAINT DF_Titulo_ind_status2
DEFAULT 'A'
GO