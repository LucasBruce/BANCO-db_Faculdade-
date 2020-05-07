/*script de criação do banco db_Faculdade e suas tabelas*/

CREATE DATABASE if not exists db_Faculdade;
USE db_Faculdade;

CREATE TABLE DEPARTAMENTO(
    id_depart SMALLINT PRIMARY KEY AUTO_INCREMENT,
    nome_depart VARCHAR(20) NOT NULL,
    localizacao VARCHAR(8) NOT NULL
);

CREATE TABLE PROFESSOR( 
   id_professor SMALLINT PRIMARY KEY AUTO_INCREMENT,
   nome_prof VARCHAR(20) NOT NULL,
   sobrenome VARCHAR(50) NOT NULL,
   id_depart_for SMALLINT NOT NULL,
   status TINYINT,
   CONSTRAINT fk_id_depart FOREIGN KEY (id_depart) 
     REFERENCES DEPARTAMENTO (id_depart) 
);

