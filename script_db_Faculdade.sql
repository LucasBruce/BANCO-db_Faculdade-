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
   CONSTRAINT fk_id_departamento_disciplina FOREIGN KEY
      (id_departamento) REFERENCES DEPARTAMENTO (id_departamento),
   CONSTRAINT fk_id_disciplina_depende_disciplina FOREIGN KEY
      (id_disciplina_depende) REFERENCES DISCIPLINA (id_disciplina)
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
   nota DECIMAL NOT NULL,
   frequencia VARCHAR(2) NOT NULL,
   id_historico SMALLINT,
   id_disciplina SMALLINT,
   PRIMARY KEY(id_historico, id_disciplina),
   CONSTRAINT fk_id_historico_disciplina FOREIGN KEY (id_historico)
     REFERENCES HISTORICO (id_historico),
   CONSTRAINT fk_id_disciplina_historico FOREIGN KEY (id_disciplina)
     REFERENCES DISCIPLINA (id_disciplina)
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

CREATE TABLE PROFESSOR_DISCIPLINA(
   id_professor SMALLINT,
   id_disciplina SMALLINT,
   PRIMARY KEY(id_professor, id_disciplina),
   CONSTRAINT fk_id_professor_disciplina FOREIGN KEY (id_professor)
     REFERENCES PROFESSOR (id_professor),
   CONSTRAINT fk_id_disciplina_professor FOREIGN KEY (id_disciplina)
     REFERENCES DISCIPLINA (id_disciplina)
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
