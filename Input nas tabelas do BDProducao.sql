-- Inserindo dados dos arquivos FLAT

USE BDProducoes;

BULK INSERT BDProducoes.dbo.Titulo
FROM 'C:\Users\nelson.junior\OneDrive\Bootcamp - IGTI\Módulo 4\Back_up dados\Titulo.txt'
 WITH ( FIELDTERMINATOR ='\t',
 ROWTERMINATOR ='\n',
--Manter os valores nos arquivos para colunas com a prop. IDENTITY
KEEPIDENTITY
 );

SELECT * FROM Titulo; -- Conferindo input --

BULK INSERT BDProducoes.dbo.Titulo_Detalhe
FROM 'C:\Users\nelson.junior\OneDrive\Bootcamp - IGTI\Módulo 4\Back_up dados\Titulo_Detalhe.txt'
 WITH ( FIELDTERMINATOR ='\t',
 ROWTERMINATOR ='\n',
--Manter os valores nos arquivos para colunas com a prop. IDENTITY
KEEPIDENTITY
 );

BULK INSERT BDProducoes.dbo.Avaliacao
FROM 'C:\Users\nelson.junior\OneDrive\Bootcamp - IGTI\Módulo 4\Back_up dados\Avaliacao.txt'
 WITH ( FIELDTERMINATOR ='\t',
 ROWTERMINATOR ='\n',
--Manter os valores nos arquivos para colunas com a prop. IDENTITY
KEEPIDENTITY
 );

BULK INSERT BDProducoes.dbo.Pessoa
FROM 'C:\Users\nelson.junior\OneDrive\Bootcamp - IGTI\Módulo 4\Back_up dados\Pessoa.txt'
 WITH ( FIELDTERMINATOR ='\t',
 ROWTERMINATOR ='\n',
--Manter os valores nos arquivos para colunas com a prop. IDENTITY
KEEPIDENTITY
 );

SELECT * FROM Pessoa;

BULK INSERT BDProducoes.dbo.Elenco
FROM 'C:\Users\nelson.junior\OneDrive\Bootcamp - IGTI\Módulo 4\Back_up dados\Elenco.txt'
 WITH ( FIELDTERMINATOR ='\t',
 ROWTERMINATOR ='\n',
--Manter os valores nos arquivos para colunas com a prop. IDENTITY
KEEPIDENTITY
 );

BULK INSERT BDProducoes.dbo.Autoria
FROM 'C:\Users\nelson.junior\OneDrive\Bootcamp - IGTI\Módulo 4\Back_up dados\Autoria.txt'
 WITH ( FIELDTERMINATOR ='\t',
 ROWTERMINATOR ='\n',
--Manter os valores nos arquivos para colunas com a prop. IDENTITY
KEEPIDENTITY
 ); 

BULK INSERT BDProducoes.dbo.Direcao
FROM 'C:\Users\nelson.junior\OneDrive\Bootcamp - IGTI\Módulo 4\Back_up dados\Direcao.txt'
 WITH ( FIELDTERMINATOR ='\t',
 ROWTERMINATOR ='\n',
--Manter os valores nos arquivos para colunas com a prop. IDENTITY
KEEPIDENTITY
 ); 