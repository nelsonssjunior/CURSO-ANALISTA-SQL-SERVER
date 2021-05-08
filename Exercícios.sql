USE BDProducoes;

-- LIMPANDO STATISTICAS
SET STATISTICS IO ON
GO

-- LIMPANDO O CACHE DO BD
DBCC DROPCLEANBUFFERS WITH NO_INFOMSGS
GO
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

/* 3. Analise o plano de execução da query abaixo, que retorna a quantidade de
títulos ativos, e verifique como ela pode ser melhorada; */

SELECT count(*) AS "Total de Títulos Ativos"
FROM Titulo
WHERE ind_status = 'A'
GO

DROP INDEX [ind_status]
ON [dbo].[Titulo]
GO
-- Resposta
CREATE NONCLUSTERED INDEX [ind_status]
ON [dbo].[Titulo] (ind_status)
GO

SELECT count(ind_status) AS "Total de Títulos Ativos"
FROM Titulo
WHERE ind_status LIKE 'A'
GO

-- 4. Analise o plano de execução da query abaixo, que retorna a relação dos 100
-- títulos mais bem avaliados, suas avaliações e total de votos, e verifique como
-- ela pode ser melhorada:

-- comando DROP INDEX [nome da coluna] ON [nome da tabela]

DBCC DROPCLEANBUFFERS WITH NO_INFOMSGS
GO
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

CREATE NONCLUSTERED INDEX IX_cod_titulo
ON dbo.Avaliacao (cod_titulo)
INCLUDE (classificacao_media)
GO

SELECT TOP (100) T.nom_titulo, A.classificacao_media, A.qtd_votos
FROM Titulo T JOIN Avaliacao A
ON T.cod_titulo = A.cod_titulo
--ORDER BY A.classificacao_media DESC;


/* 5 - Analise o plano de execução da query abaixo, Títulos sem o detalhe da duração
(qtd_minutos) ou informação do gênero (dsc_genero), e verifique como ela
pode ser melhorada:*/

SELECT *
FROM Titulo T JOIN Titulo_Detalhe D
ON T.cod_titulo = D.cod_titulo
WHERE D.qtd_minutos IS NULL OR D.dsc_genero IS NULL

-- Resposta
SELECT T.cod_titulo, D.cod_titulo,  D.qtd_minutos, D.dsc_genero
FROM Titulo T JOIN Titulo_Detalhe D
ON T.cod_titulo = D.cod_titulo
WHERE D.qtd_minutos IS NULL OR D.dsc_genero IS NULL

/*6. Analise o plano de execução da query abaixo, que retorna informações acerca
dos títulos ativos, ordenados alfabeticamente pelo nome do título, e verifique
como ela pode ser melhorada.*/

SELECT T.nom_titulo AS "Nome do Título", UPPER (TD.tip_titulo) AS "Tipo do 
Título", TD.ano_lancamento AS "Ano de Lançamento", TD.qtd_minutos AS 
"Duração", TD.dsc_genero AS "Gênero(s)", A.classificacao_media AS "Nota",
 P.nom_pessoa AS "Autor", P2.nom_pessoa AS "Diretor"

FROM Titulo T 
LEFT JOIN Titulo_Detalhe TD ON T.cod_titulo = TD.cod_titulo

LEFT JOIN Avaliacao A ON T.cod_titulo = A.cod_titulo

LEFT JOIN Autoria E ON T.cod_titulo = E.cod_titulo

LEFT JOIN Pessoa P ON E.cod_pessoa = P.cod_pessoa

LEFT JOIN Direcao D ON T.cod_titulo = D.cod_titulo

LEFT JOIN Pessoa P2 ON D.cod_pessoa = P2.cod_pessoa

WHERE T.ind_status = 'A'

 ORDER BY T.nom_titulo;


-- Resposta 
CREATE NONCLUSTERED INDEX [nom_titulo]
ON [dbo].[Titulo] (nom_titulo)
GO

SET STATISTICS IO ON
GO

-- LIMPANDO O CACHE DO BD
DBCC DROPCLEANBUFFERS WITH NO_INFOMSGS
GO
DBCC FREEPROCCACHE WITH NO_INFOMSGS
GO

DROP INDEX [nom_titulo]
ON [dbo].[Titulo]
GO