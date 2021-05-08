CREATE TABLE empregados(
    id_empregados int primary key,
    nome varchar(30),
    sobrenome varchar (50),
    salario decimal(8,2),
    email varchar,
    data_admissao date,
    cargo_id int,
    id_departamento int
);

CREATE TABLE departamentos (
    id_departamento int primary key,
    departamento_nome varchar (50),
    id_localidade int
);

# criando relação entre tabelas

ALTER TABLE empregados ADD CONSTRAINT FK_EMP_DEP FOREIGN KEY(id_departamento) 
REFERENCES departamentos(id_departamento);

CREATE UNIQUE INDEX IX_E-MAIL_EMO ON empregados(email);

/* Comandos ON DELETE NO ACTION e ON UPDATE NO ACTION
comando padrão SQL

