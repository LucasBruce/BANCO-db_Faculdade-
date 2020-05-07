--script de criação do banco db_Faculdade e suas tabelas--

CREATE DATABASE db_Faculdade;
USE db_Faculdade;


CREATE TABLE DEPARTAMENTO(
    id_depart INT(2) PRIMARY KEY AUTO_INCREMENT,
    nome_depart VARCHAR(20) NOT NULL,
    localizacao VARCHAR(8) NOT NULL
);

CREATE TABLE PROFESSOR( 
   id_professor INT(2) PRIMARY KEY AUTO_INCREMENT,
   nome_prof VARCHAR(20) NOT NULL,
   sobrenome VARCHAR(50) NOT NULL,
   id_depart_for INT(2),
   status TINYINT(1),
   CONSTRAINT fk_id_depart FOREIGN KEY (id_depart) 
     REFERENCES DEPARTAMENTO (id_depart) 
);

CREATE TABLE CURSO(
   id_curso INT(2) PRIMARY KEY AUTO_INCREMENT,
   nome_curso VARCHAR(40) NOT NULL,
   id_depart_for INT(2),
   CONSTRAINT fk_cod_depart FOREIGN KEY (id_depart)
      REFERENCES DEPARTAMENTO (id_depart)
);

CREATE TABLE TURMA(
    id_turma INT(2) PRIMARY KEY AUTO_INCREMENT,
    num_aluno INT(2) NOT NULL,
    data_inicio DATE(4) NOT NULL,
    data_fim DATE(4) NOT NULL,
    CONSTRAINT fk_id_curso FOREIGN KEY (id_curso)
      REFERENCES CURSO (id_curso)
);

CREATE TABLE ALUNO(
    ra INT(6) PRIMARY KEY AUTO_INCREMENT,
    nome_aluno VARCHAR(20) NOT NULL,
    sobrenome_aluno VARCHAR(50) NOT NULL,
    status TINYINT(1) NOT NULL,
    nome_mae VARCHAR(80) NOT NULL,
    nome_pai VARCHAR(80) NOT NULL,
    sexo VARCHAR(1) NOT NULL,
    whatsapp VARCHAR(11),
    email VARCHAR(60) NOT NULL,
    cpf VARCHAR(11) NOT NULL, 
    id_turma INT(2) NOT NULL,
    CONSTRAINT fk_id_turma_aluno FOREIGN KEY (id_turma) 
       REFERENCES TURMA (id_turma),
    CONSTRAINT fk_id_curso_aluno FOREIGN KEY (id_curso)
       REFERENCES CURSO (id_curso)
);

CREATE TABLE TIPO_LOGRADOURO(
   id_tipo_logr INT(1) PRIMARY KEY AUTO_INCREMENT,
   tipo_logradouro VARCHAR(11) NOT NULL
);

CREATE TABLE ENDERECO_ALUNO(
    id_end_aluno INT(1) PRIMARY KEY AUTO_INCREMENT,
    ra_for INT NOT NULL,
    id_tipo_logr_for INT NOT NULL,
    complemento VARCHAR(20) NOT NULL,
    nome_rua VARCHAR(50) NOT NULL,
    num_rua VARCHAR(50) NOT NULL,
    cep VARCHAR(8) NOT NULL,
    CONSTRAINT fk_id_ra_aluno FOREIGN KEY (ra)
       REFERENCES ALUNO (ra),
    CONSTRAINT fk_id_tipo_logr FOREIGN KEY (id_tipo_logr)
       REFERENCES TIPO_LOGRADOURO(id_tipo_logr)
);

CREATE TABLE TELEFONE_TIPO(
    id_tipo_tel INT(1) PRIMARY KEY AUTO_INCREMENT,
    tipo_tel VARCHAR(8) NOT NULL

);

CREATE TABLE TELEFONE_ALUNO(
   id_tel_aluno INT(1) PRIMARY KEY AUTO_INCREMENT,
   ra_for INT NOT NULL,
   telefone VARCHAR(11) NOT NULL,
   CONSTRAINT fk_id_ra_telefone FOREIGN KEY (ra) 
      REFERENCES ALUNO (ra),
   CONSTRAINT fk_id_tipo_tel FOREIGN KEY (id_tipo_tel)
      REFERENCES TELEFONE_TIPO (id_tipo_tel)
);

CREATE TABLE DISCIPLINA(
   id_disciplina INT(2) PRIMARY KEY AUTO_INCREMENT,
   id_disciplina_depende INT NULL, /*auto-relacionamento disciplina depende de disciplina*/
   nome_disciplina VARCHAR(30) NOT NULL,
   id_depart_for INT(2) NOT NULL,
   descricao VARCHAR(200),
   num_aluno INT(2) NOT NULL,
   carga_horaria INT(2) NOT NULL,
   CONSTRAINT fk_id_depart_disc FOREIGN KEY (id_depart)
     REFERENCES DEPARTAMENTO (id_depart)
);

CREATE TABLE HISTORICO(
   id_historico INT(2) PRIMARY KEY AUTO_INCREMENT,
   ra_for INT NOT NULL,
   data_ini DATE(4) NOT NULL,
   data_fin DATE(4),
   CONSTRAINT fk_id_ra_historico FOREIGN kEY (ra)
     REFERENCES ALUNO (ra)
); 

CREATE TABLE HISTORICO_DISC(
   id_historico_for INT NOT NULL,
   id_disciplina_for INT NOT NULL,
   nota DECIMAL(8) NOT NULL,
   frequencia VARCHAR(2) NOT NULL,
   PRIMARY KEY(id_historico, id_disciplina),
   CONSTRAINT fk_id_historico_disc FOREIGN KEY (id_historico)
     REFERENCES HISTORICO (id_historico),
   CONSTRAINT fk_id_disciplina_hist FOREIGN KEY (id_disciplina)
     REFERENCES DISCIPLINA (id_disciplina)
);

CREATE TABLE CURSO_DISC(
   id_curso_for INT NOT NULL,
   id_disciplina_for INT NOT NULL,
   PRIMARY KEY(id_curso, id_disciplina),
   CONSTRAINT fk_id_curso_disc FOREIGN KEY (id_curso)
     REFERENCES CURSO (id_curso),
   CONSTRAINT fk_id_disciplina_curso FOREIGN KEY (id_disciplina)
     REFERENCES DISCIPLINA (id_disciplina) 
);

CREATE TABLE PROFESSOR_DISC(
   id_professor_for INT NOT NULL,
   id_disciplina_for INT NOT NULL,
   PRIMARY KEY(id_professor, id_disciplina),
   CONSTRAINT fk_id_professor_disc FOREIGN KEY (id_professor)
     REFERENCES PROFESSOR (id_professor),
   CONSTRAINT fk_id_disciplina_prof FOREIGN KEY (id_disciplina)
     REFERENCES DISCIPLINA (id_disciplina)
);

CREATE TABLE ALUNO_DISC(
   ra_for INT NOT NULL,
   id_disciplina_for INT NOT NULL,
   PRIMARY KEY(ra, id_disciplina),
   CONSTRAINT fk_id_ra_disc FOREIGN KEY (ra) 
     REFERENCES ALUNO (ra),
   CONSTRAINT fk_id_disciplina_aluno FOREIGN KEY (id_disciplina)
     REFERENCES DISCIPLINA (id_disciplina)
);