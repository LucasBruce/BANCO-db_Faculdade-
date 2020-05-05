--script de criação do banco db_Faculdade e suas tabelas--

CREATE DATABASE db_Faculdade;
USE db_Faculdade;


CREATE TABLE DEPARTAMENTO(
    id_depart INT(2),
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
   CONSTRAINT fk_id_depart FOREIGN KEY (id_depart)
      REFERENCES DEPARTAMENTO (id_depart)
);