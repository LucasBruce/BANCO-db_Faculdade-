/*script de criação do banco db_Faculdade e suas tabelas*/

CREATE DATABASE if not exists db_Faculdade;
USE db_Faculdade;

CREATE TABLE DEPARTAMENTO(
     id_departamento SMALLINT PRIMARY KEY AUTO_INCREMENT,
     nome_departamento VARCHAR(20) NOT NULL,
     localizacao VARCHAR(8) NOT NULL
);

CREATE TABLE PROFESSOR (
	 id_Professor SMALLINT PRIMARY KEY AUTO_INCREMENT,
	 Nome_Professor VARCHAR(20) NOT NULL,
	 Sobrenome_Professor VARCHAR(50) NOT NULL,
	 Status_Professor TINYINT,
	 id_departamento SMALLINT,
	 CONSTRAINT fk_id_departamento_professor FOREIGN KEY(id_departamento)
	   REFERENCES DEPARTAMENTO (id_departamento)
);

CREATE TABLE CURSO(
   id_curso SMALLINT PRIMARY KEY AUTO_INCREMENT,
   nome_curso VARCHAR(40) NOT NULL,
   id_departamento SMALLINT,
   CONSTRAINT fk_id_departamento_curso FOREIGN KEY (id_departamento)
      REFERENCES DEPARTAMENTO (id_departamento)
);

CREATE TABLE TURMA(
    id_turma SMALLINT PRIMARY KEY AUTO_INCREMENT,
    num_aluno SMALLINT NOT NULL,
    periodo VARCHAR(8) NOT NULL,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    id_curso SMALLINT,
    CONSTRAINT fk_id_curso_turma FOREIGN KEY (id_curso)
      REFERENCES CURSO (id_curso)
);

CREATE TABLE ALUNO(
    ra SMALLINT PRIMARY KEY AUTO_INCREMENT,
    nome_aluno VARCHAR(20) NOT NULL,
    sobrenome_aluno VARCHAR(50) NOT NULL,
    status TINYINT NOT NULL,
    nome_mae VARCHAR(80) NOT NULL,
    nome_pai VARCHAR(80) NOT NULL,
    sexo VARCHAR(1) NOT NULL,
    whatsapp VARCHAR(11),
    email VARCHAR(60) NOT NULL,
    cpf VARCHAR(11) NOT NULL, 
    id_turma SMALLINT,
    id_curso SMALLINT,
    CONSTRAINT fk_id_turma_aluno FOREIGN KEY (id_turma) 
       REFERENCES TURMA (id_turma),
    CONSTRAINT fk_id_curso_aluno FOREIGN KEY (id_curso)
       REFERENCES CURSO (id_curso)
);

CREATE TABLE TIPO_LOGRADOURO(
   id_tipo_logradouro SMALLINT PRIMARY KEY AUTO_INCREMENT,
   tipo_logradouro VARCHAR(11) NOT NULL
);

CREATE TABLE ENDERECO_ALUNO(
    id_endereco_aluno SMALLINT PRIMARY KEY AUTO_INCREMENT,
    complemento VARCHAR(20) NOT NULL,
    nome_rua VARCHAR(50) NOT NULL,
    numero_rua VARCHAR(50) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    ra SMALLINT,
    id_tipo_logradouro SMALLINT,
    CONSTRAINT fk_id_aluno_endereco FOREIGN KEY (ra)
       REFERENCES ALUNO (ra),
    CONSTRAINT fk_id_tipo_logradouro_endereco_aluno FOREIGN KEY 
       (id_tipo_logradouro) REFERENCES TIPO_LOGRADOURO (id_tipo_logradouro)
);

CREATE TABLE TIPO_TELEFONE(
    id_tipo_telefone SMALLINT PRIMARY KEY AUTO_INCREMENT,
    tipo_telefone VARCHAR(8) NOT NULL

);

CREATE TABLE TELEFONE_ALUNO(
   id_telefone_aluno SMALLINT PRIMARY KEY AUTO_INCREMENT,
   telefone VARCHAR(11) NOT NULL,
   ra SMALLINT,
   id_tipo_telefone SMALLINT,
   CONSTRAINT fk_id_aluno_telefone_aluno FOREIGN KEY (ra) 
      REFERENCES ALUNO (ra),
   CONSTRAINT fk_id_tipo_telefone_telefone_aluno FOREIGN KEY
      (id_tipo_telefone) REFERENCES TIPO_TELEFONE (id_tipo_telefone)
);

CREATE TABLE DISCIPLINA(
   id_disciplina SMALLINT PRIMARY KEY AUTO_INCREMENT,
   nome_disciplina VARCHAR(30) NOT NULL,
   descricao VARCHAR(200),
   numero_aluno SMALLINT NOT NULL,
   carga_horaria SMALLINT NOT NULL,
   id_disciplina_depende SMALLINT, /*auto-relacionamento disciplina depende de disciplina*/
   id_departamento SMALLINT,
   id_disciplina_1 SMALLINT,
   CONSTRAINT fk_id_disciplina_disciplina_1 FOREIGN KEY (id_disciplina_1)
      REFERENCES DISCIPLINA(id_disciplina),
   CONSTRAINT fk_id_departamento_disciplina FOREIGN KEY
      (id_departamento) REFERENCES DEPARTAMENTO (id_departamento),
   CONSTRAINT fk_id_disciplina_depende_disciplina FOREIGN KEY
      (id_disciplina_depende) REFERENCES DISCIPLINA (id_disciplina)
);

/*A tabela DISCIPLINA_1 é criada para evitar a 
 repetição de PROFESSOR e ALUNO, pois respectivamento professor
 e aluno podem ministrar e cursar mais de uma disciplina ou seja
 ainda podem ser criadas mais tabelas DISCIPLINA_2, 
 DISCIPLINA_3..., mas no momento para estudo será criada
 apenas a DISCIPLINA_1*/
 
 CREATE TABLE IF NOT EXISTS DISCIPLINA_1(
   id_disciplina_1 SMALLINT PRIMARY KEY AUTO_INCREMENT,
   nome_disciplina_1 VARCHAR(30) NOT NULL,
   descricao_1 VARCHAR(200),
   numero_aluno_1 SMALLINT NOT NULL,
   carga_horaria_1 SMALLINT NOT NULL,
   id_disciplina SMALLINT NOT NULL,
   id_disciplina_depende_1 SMALLINT NOT NULL, /*auto-relacionamento disciplina depende de disciplina*/
   id_departamento SMALLINT NOT NULL,
   id_disciplina_1 SMALLINT,
   CONSTRAINT fk_id_disciplina_1_departamento FOREIGN KEY (id_departamento)
     REFERENCES DEPARTAMENTO (id_departamento),
   CONSTRAINT fk_id_disciplina_1_disciplina FOREIGN KEY (id_disciplina)
     REFERENCES DISCIPLINA (id_disciplina),
   CONSTRAINT fk_id_disciplina_1_depende FOREIGN KEY (id_disciplina_depende_1)
     REFERENCES DISCIPLINA_1 (id_disciplina_1),
   CONSTRAINT fk_id_disciplina_disciplina_1 FOREIGN KEY (id_disciplina_1) 
     REFERENCES DISCIPLINA_1 (id_disciplina_1)
 );

CREATE TABLE HISTORICO(
   id_historico SMALLINT PRIMARY KEY AUTO_INCREMENT,
   data_inicio DATE NOT NULL,
   data_fim DATE NOT NULL,
   ra SMALLINT,
   CONSTRAINT fk_id_aluno_historico FOREIGN KEY (ra)
     REFERENCES ALUNO (ra)
); 

CREATE TABLE DISCIPLINA_HISTORICO(
   nota FLOAT NOT NULL,
   frequencia VARCHAR(2) NOT NULL,
   id_historico SMALLINT,
   id_disciplina SMALLINT,
   PRIMARY KEY(id_historico, id_disciplina),
   CONSTRAINT fk_id_historico_disciplina FOREIGN KEY (id_historico)
     REFERENCES HISTORICO (id_historico),
   CONSTRAINT fk_id_disciplina_historico FOREIGN KEY (id_disciplina)
     REFERENCES DISCIPLINA (id_disciplina)
);

CREATE TABLE IF NOT EXISTS DISCIPLINA_HISTORICO_1(
   nota_1 FLOAT NOT NULL,
   frequencia_1 VARCHAR(2) NOT NULL,
   id_historico SMALLINT,
   id_disciplina_1 SMALLINT,
   PRIMARY KEY(id_historico, id_disciplina_1),
   CONSTRAINT fk_disciplina_historico_1_historico FOREIGN KEY(id_historico)
     REFERENCES HISTORICO(id_historico),
   CONSTRAINT fk_disciplina_historico_1_disciplina_1 FOREIGN KEY(id_disciplina_1)
     REFERENCES DISCIPLINA_1(id_disciplina_1)
);


CREATE TABLE CURSO_DISCIPLINA(
   id_curso SMALLINT,
   id_disciplina SMALLINT,
   PRIMARY KEY(id_curso, id_disciplina),
   CONSTRAINT fk_id_curso_disciplina FOREIGN KEY (id_curso)
     REFERENCES CURSO (id_curso),
   CONSTRAINT fk_id_disciplina_curso FOREIGN KEY (id_disciplina)
     REFERENCES DISCIPLINA (id_disciplina) 
);

CREATE TABLE IF NOT EXISTS CURSO_DISCIPLINA_1(
   id_curso SMALLINT,
   id_disciplina_1 SMALLINT,
   PRIMARY KEY(id_curso, id_disciplina_1),
   CONSTRAINT fk_curso_disciplina_1_curso FOREIGN KEY(id_curso)
     REFERENCES CURSO(id_curso),
   CONSTRAINT fk_curso_disciplina_1_disciplina_1 FOREIGN KEY(id_disciplina_1)
     REFERENCES DISCIPLINA_1(id_disciplina_1)
);


CREATE TABLE PROFESSOR_DISCIPLINA(
   id_professor SMALLINT,
   id_disciplina SMALLINT,
   PRIMARY KEY(id_professor, id_disciplina),
   CONSTRAINT fk_id_professor_disciplina FOREIGN KEY (id_professor)
     REFERENCES PROFESSOR (id_professor),
   CONSTRAINT fk_id_disciplina_professor FOREIGN KEY (id_disciplina)
     REFERENCES DISCIPLINA (id_disciplina)
);

/*criando a entidade associativa ALUNO_DISCIPLINA_1 e PROFESSOR_DISCIPLINA_1
para evitar o relacionamento n-ário*/
CREATE TABLE IF NOT EXISTS PROFESSOR_DISCIPLINA_1(
  id_professor SMALLINT NOT NULL,
  id_disciplina_1 SMALLINT NOT NULL,
  PRIMARY KEY(id_professor, id_disciplina_1),
  CONSTRAINT fk_id_professor_disciplina_1 FOREIGN KEY (id_disciplina_1)
    REFERENCES DISCIPLINA_1 (id_disciplina_1),
  CONSTRAINT fk_disciplina_1_professor FOREIGN KEY (id_professor)
    REFERENCES PROFESSOR (id_professor)
);

CREATE TABLE ALUNO_DISCIPLINA(
   ra SMALLINT,
   id_disciplina SMALLINT,
   PRIMARY KEY(ra, id_disciplina),
   CONSTRAINT fk_id_aluno_disciplina FOREIGN KEY (ra) 
     REFERENCES ALUNO (ra),
   CONSTRAINT fk_id_disciplina_aluno FOREIGN KEY (id_disciplina)
     REFERENCES DISCIPLINA (id_disciplina)
);

/*criando a entidade associativa ALUNO_DISCIPLINA_1 e PROFESSOR_DISCIPLINA_1
para evitar o relacionamento n-ário*/
CREATE TABLE IF NOT EXISTS ALUNO_DISCIPLINA_1(
   ra SMALLINT NOT NULL,
   id_disciplina_1 SMALLINT NOT NULL,
   PRIMARY KEY(ra, id_disciplina_1),
   CONSTRAINT fk_aluno_disciplina_1_ra FOREIGN KEY (ra)
     REFERENCES ALUNO (ra),
   CONSTRAINT fk_aluno_disciplina_1_disciplina_1 FOREIGN KEY (id_disciplina_1)
     REFERENCES DISCIPLINA_1 (id_disciplina_1)
);

/*script de inserção de dados nas tabelas do banco (carga de dados para teste)*/

INSERT INTO DEPARTAMENTO(nome_departamento, localizacao)
	VALUES
	('Ciências Humanas', 'bloco A'),
	('Matemática', 'bloco B'),
	('Biológicas', 'bloco C'),
	('Estágio', 'bloco D');

INSERT INTO PROFESSOR(Nome_Professor, Sobrenome_Professor,
Status_Professor, id_departamento)
    VALUES
    ('Fábio', 'dos Reis', 0, 2),
    ('Sophie', 'Allemand', 1, 1),
	('Monica', 'Barroso', 1, 3);
    
INSERT INTO CURSO(nome_curso, id_departamento)
	VALUES
	('Matemática', 2),
	('Psicologia', 1),
	('Análise de Sistemas', 2),
	('Biologia', 3),
	('História', 1),
	('Engenharia', 2);
    
INSERT INTO TURMA(id_curso, periodo, num_aluno,  
data_inicio, data_fim)
    VALUES
    (2, 'Manhã', 20, '2016-05-12', '2017-10-15'),
    (1, 'Noite', 10, '2014-05-12', '2020-03-05'),
    (3, 'Tarde', 15, '2012-05-12', '2014-05-10');
    
INSERT INTO DISCIPLINA(nome_disciplina, id_departamento, carga_horaria,
descricao, numero_aluno)
    VALUES
    ('Raciocínio Lógico', 2, 1200, 'Desenvolver o raciocínio lógico', 50),
    ('Psicologia Cognitiva', 1, 1400, 'Entender o funcionamento do aprendizado', 30),
    ('Programação em C', 2, 1200, 'Aprender uma linguagem de programação', 20),
    ('Eletrônica Digital', 2, 300, 'Funcionamento de circuitos digitais', 30);

/*INSERT INTO DISCIPLINA_1(nome_disciplina_1, id_departamento, descricao_1, 
numero_aluno_1, carga_horaria_1)
    VALUES
    (),
    (),
    (),*/
    
INSERT INTO ALUNO(nome_aluno, sobrenome_aluno, cpf, status_aluno,
id_turma, sexo, id_curso, nome_pai, nome_mae, email, whatsapp)
    VALUES
    ('Marcos', 'Aurelio Martins', 14278914536, 1, 2, 'M', 3, 'Marcio Aurelio', 'Maria Aparecida', 'marcosaurelio@gmail.com', 946231249),
    ('Gabriel', 'Fernando de ALmeida', 14470954536, 1, 1, 'M', 1, 'Adão Almeida', 'Fernanda Almeida', 'gabrielalmeida@yahoo.com', 941741247),
    ('Beatriz', 'Sonia Meneguel', 1520984537, 1, 3, 'F', 3, 'Samuel Meneguel', 'Gabriela Meneguel', 'beatrizmene@hotmail.com', 945781412),
    ('Jorge', 'Soares', 14223651562, 1, 3, 'M', 4, 'João Soares', 'Maria Richtzer', 'jorgesoares@gmail.com', 925637857),
    ('Ana Paula', 'Ferretti', 32968914522, 1, 3, 'M', 5, 'Marcio Ferretti', 'Ana Hoffbahn', 'anapaulaferretti@hotmail', 974267423),
    ('Mônica', 'Yamaguti', 32988914510, 1, 2, 'F', 6, 'Wilson Oliveira', 'Fernanda Yamaguti', 'monyamaguti@outlook.com',932619560);

INSERT INTO ALUNO_DISCIPLINA(ra, id_disciplina)
    VALUES
    (3, 1),
    (1, 2),
    (2, 3),
    (4, 3),
    (5, 4),
    (6, 1);
   
INSERT INTO CURSO_DISCIPLINA(id_curso, id_disciplina)
    VALUES
    (1, 1),
    (2, 2),
    (3, 3),
    (6, 4);
    
INSERT INTO PROFESSOR_DISCIPLINA(id_professor, id_disciplina)
    VALUES
    (2, 1),
    (1, 2),
    (3, 3);

INSERT INTO HISTORICO(ra, data_inicio, data_final)
    VALUES
    (2, '2016-05-12', '2017-10-15'),
    (3, '2014-05-12', '2020-03-05'),
    (1, '2010-05-12', '2012-05-10'),
    (4, '2011-05-12', '2013-10-15'),
    (6, '2009-05-12', '2011-03-05');

INSERT INTO TIPO_LOGRADOURO(tipo_logradouro)
    VALUES
    ('Rua'),
    ('Avenida'),
    ('Alameda'),
    ('Travessa');

INSERT INTO ENDERECO_ALUNO(ra, id_tipo_logradouro, nome_rua, numero_rua, complemento, cep)
    VALUES
    (2, 1, 'das giestas', 255, 'Casa 02', 02854000),
    (3, 3, 'Lorena', 10, 'Apto 15', 02945000),
    (1, 2, 'do Cursino', 1248, 'Casa 03', 0851040),
    (4, 1, 'das Heras', 495, 'Casa 04', 03563142),
    (5, 3, 'Santos', 1856, 'Casa 05', 04523963),
    (6, 4, 'Matão', 206, 'Casa 06', 04213650);

INSERT INTO TELEFONE_ALUNO(ra, telefone, id_tipo_telefone)
    VALUES
    (1, '87533-211', 1),
    (2, '87432-876', 3),
    (3, '87324-768', 2),
    (4, '87324-456', 1),
    (5, '86235-345', 2),
    (6, '89435-321', 2);

INSERT INTO TIPO_TELEFONE(tipo_telefone)
    VALUES
    ('comerc.'),
    ('pessoal'),
    ('trabalho');


/*Alterar campo nota da tabela DISCIPLINA_HISTORICO para FLOAT 
este comando modifica o tipo do atributo*/

ALTER TABLE DISCIPLINA_HISTORICO MODIFY COLUMN nota FLOAT;

INSERT INTO DISCIPLINA_HISTORICO(id_historico, id_disciplina, nota, frequencia)
    VALUES
    (1, 2, 7, 6),  /*Marcos - Psicologia Cognitiva (cod 2)*/
    (2, 3, 8.5, 2), /*Gabriel - Programação em C (cod 3)*/
    (3, 1, 6.8, 8); /*Beatriz - Raciocínio Lógico (cod1)*/
  
INSERT INTO DISCIPLINA_HISTORICO_1(id_historico, id_disciplina_1, nota_1, frequencia_1)
    VALUES
    (3, 2, 6.4, 5),/*Marcos - Programacao em Java*/
    (5, 3, 7.8, 8),  /*Monica - Antropologia*/
    (4, 1, 9.5, 9); /*Jorge - Banco de Dados*/

/*1. ras, nomes e sobrenomes dos alunos, nomes dos cursos e períodos, 
ordenados pelo primeiro nome de aluno:*/

SELECT A.ra, A.nome_aluno, A.sobrenome_aluno, 
C.nome_curso, T.periodo FROM ALUNO A
	INNER JOIN CURSO C 
	ON C.id_curso = A.id_curso
	INNER JOIN TURMA T
	ON T.id_turma = A.id_turma
	ORDER BY A.nome_aluno; 

/*2. Todas as disciplinas cursadas por um aluno, com suas respectivas notas:
Aluno: RA 3 (Beatriz) nome, sobrenome, nome da disciplina e nota*/

SELECT A.nome_aluno, A.sobrenome_aluno, 
D.nome_disciplina, DH.nota, H.id_historico, D.id_disciplina, A.ra FROM ALUNO A 
	INNER JOIN ALUNO_DISCIPLINA AD
	ON A.ra = AD.ra 
	INNER JOIN DISCIPLINA D 
	ON D.id_disciplina = AD.id_disciplina
	INNER JOIN HISTORICO H
	ON A.ra = H.ra
	INNER JOIN DISCIPLINA_HISTORICO DH
	ON H.id_historico = DH.id_historico
	WHERE A.ra = 3;

/*3. Nomes e sobrenomes dos professores, e disciplinas que ministram com suas 
cargas horárias ordenados pelo primeiro nome da disciplina:*/

SELECT CONCAT(P.Nome_Professor,' ', P.Sobrenome_Professor) AS DOCENTE,
D.nome_disciplina, D.carga_horaria FROM PROFESSOR P
	INNER JOIN PROFESSOR_DISCIPLINA PD 
	ON P.id_Professor = PD.id_Professor
	INNER JOIN DISCIPLINA D
	ON D.id_disciplina = PD.id_disciplina
	ORDER BY P.Nome_Professor; 

SELECT CONCAT(Nome_Professor,' ', Sobrenome_Professor) AS DOCENTE FROM PROFESSOR;
/*4. Gerar "relatório" com nomes, sobrenomes, CPF dos alunos, tipos e números
 de telefones e endereços completos.*/
 
 SELECT CONCAT(A.nome_aluno,' ', A.sobrenome_aluno) AS ALUNOS, A.cpf,
 CONCAT(TA.telefone,', ', TT.tipo_telefone) AS TELEFONES, CONCAT(TL.tipo_logradouro,
 ' ', EA.nome_rua,', ', EA.numero_rua) AS LOGRADOUROS, EA.cep, EA.complemento
 FROM ALUNO A 
		 INNER JOIN TELEFONE_ALUNO TA
		 ON A.ra = TA.ra 
		 INNER JOIN TIPO_TELEFONE TT
		 ON TT.id_tipo_telefone = TA.id_tipo_telefone
		 INNER JOIN ENDERECO_ALUNO EA
		 ON A.ra = EA.ra
		 INNER JOIN TIPO_LOGRADOURO TL
		 ON TL.id_tipo_logradouro = EA.id_tipo_logradouro;

-- 5. Listar as disciplinas, indicando seus departamentos, cursos e professores

SELECT D.nome_disciplina, DEP.nome_departamento, C.nome_curso,
CONCAT(P.Nome_Professor,' ', P.Sobrenome_Professor)
AS DOCENTE FROM DISCIPLINA D 
		INNER JOIN DEPARTAMENTO DEP 
		ON DEP.id_departamento = D.id_departamento
		INNER JOIN CURSO_DISCIPLINA CD
		ON D.id_disciplina = CD.id_disciplina
		INNER JOIN CURSO C
		ON C.id_curso = CD.id_curso
		INNER JOIN PROFESSOR_DISCIPLINA PD
		ON D.id_disciplina = PD.id_disciplina
		INNER JOIN PROFESSOR P
		ON P.id_Professor = PD.id_Professor
		ORDER BY D.nome_disciplina;

SELECT CONCAT(Nome_Professor,' ', Sobrenome_Professor),
 id_Professor AS DOCENTE FROM PROFESSOR;
 