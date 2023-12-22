-- create a table
CREATE TABLE students (
  id INTEGER PRIMARY KEY,
  name TEXT NOT NULL,
  gender TEXT NOT NULL
);
-- insert some values
INSERT INTO students VALUES (1, 'Ryan', 'M');
INSERT INTO students VALUES (2, 'Joanna', 'F');
-- fetch some values
SELECT * FROM students WHERE gender = 'F';

CREATE TABLE DISCO(
    NroSerie integer,
    TitoloAlbum VARCHAR(50),
    Anno INTEGER,
    Prezzo VARCHAR(255)
    );

CREATE TABLE CONTIENE(
    NroSerieDisco INTEGER,
    CodiceReg VARCHAR(50),
    NroProg INTEGER
    );

CREATE TABLE ESECUZIONE(
    CodiceReg VARCHAR(50) PRIMARY KEY,
    TitoloCanz TEXT NOT NULL,
    Anno INTEGER
    );

CREATE TABLE AUTORE (
 Nome TEXT NOT NULL ,
    TitoloCanzone TEXT NOT NULL
    );

CREATE TABLE CANTANTE(
    NomeCantante VARCHAR(50) PRIMARY KEY,
    CodiceReg VARCHAR(50)
    );

INSERT INTO DISCO (NroSerie , TitoloAlbum,Anno ,
Prezzo )VALUES
(1,'la vita',2000,'50£'),
(2,'amore',2003,'30£'),
(3,'la tecnologia',null,'14'),
 (4,'the girl ',2023,'25£'),
(5,'all the time',2022,'45£'),
(6,'i am proud',NULL,'15£'),
(10,'speranza',2016,'15£');  

INSERT INTO CONTIENE (NroSerieDisco, CodiceReg, NroProg)
VALUES
    (4, 'NY22', 20),
    (1, 'ML1', 14),
    (2, 'BGM3', 10),
    (3, 'FRZ0', 13),
    (10, 'RM1', 16),
    (5, 'YD2', 10),
    (6, 'PG1', 22);

INSERT INTO ESECUZIONE  (CodiceReg ,TitoloCanz ,Anno )
    VALUES
('YD2','seriously',2016),
('ML1','la vita è bella',2000), 
('BGM3','amore mio',2003),
('RM1','una stella',2016),
('NY','i like stay with you',2023),
('PG1','hello',null),
('FRZ0','seriously',NULL);

INSERT INTO AUTORE (Nome ,TitoloCanzone )
VALUES
('Andrea bocelli', 'amore mio'),
('Laura pausini','la vita è bella'),
('Davido','seriously'),
('Daniel kiss','seriously'),
    ('Gims','hello');

    INSERT INTO CANTANTE (NomeCantante ,CodiceReg)
    VALUES
    ('Davido','FRZ0'),
    ('Daniel kiss','FRZ0');
#SELECT* FROM AUTORE;
#SELECT* FROM CANTANTE;

#i cantatuari che hanno cantato e scritto la stessa musica
SELECT DISTINCT A.Nome AS Autore
FROM AUTORE A
LEFT JOIN ESECUZIONE E ON E.TitoloCanz = A.TitoloCanzone
AND  A.Nome <> A.Nome
WHERE A.Nome LIKE 'D%';

#i titoli dei dischi che contengono canzoni di cui non si conosce 
SELECT DISTINCT D.TitoloAlbum  
FROM DISCO AS D
JOIN CONTIENE AS C ON D.NroSerie=C.NroSerieDisco
JOIN ESECUZIONE AS E ON C.CodiceReg=E.CodiceReg
WHERE E.Anno IS NULL;

#esecizio2

CREATE TABLE STUDENTE(
    Matricola VARCHAR(255) PRIMARY KEY,
    Nome VARCHAR(50),
 Citta TEXT NOT NULL
    );

CREATE TABLE CORSO(
    Codice VARCHAR(20) PRIMARY KEY,
    Nome VARCHAR(50),
    MatricolaDocente VARCHAR(50)
);

CREATE TABLE DOCENTE(
  Matricola VARCHAR(255) ,
    Nome VARCHAR(50) ,
    PRIMARY KEY(Matricola, Nome)
);

CREATE TABLE ESAME (
    Codice VARCHAR(20),
    MatricolaStudente VARCHAR(255),
    Data DATE,
    Voto INTEGER,
    SettoreScientifico TEXT NOT NULL,
    PRIMARY KEY (Codice, MatricolaStudente)
);

INSERT INTO STUDENTE(Matricola, Nome, Citta)
VALUES
('laurafs20232023','laura','Milano'),
('lucianofl2023','luciano','Pavia'),
('matteofm2023','matteo','Bologna'),
('giuliafl2023','giulia','Modena'),
('hamirfsge2023','hamir','pavia');

INSERT INTO CORSO (Codice, Nome, MatricolaDocente)
VALUES
('alg1', 'algebra', 'rossi1980'),
('cc1', 'cloud computing', 'paul1983'),
('prgj', 'java', 'stefano2000'),
('engl', 'englese', 'marco1993'),
('db', 'Database', 'daniel1999');


INSERT INTO DOCENTE(Matricola, Nome)
VALUES
('rossi1980','rossi'),
('paul1983','paul'),
('stefano2000','stefano'),
('marco1993','marco'),
('daniel1999','daniel');

INSERT INTO ESAME (Codice, MatricolaStudente, Data, Voto, SettoreScientifico)
VALUES
('db', 'giuliafl2023', '2023-06-17', 45, 'informatica'),
('engl', 'hamirfsge2023', '2023-07-12', 20, 'linguaInter'),
('alg1', 'laurafs20232023', '2023-07-13', 60, 'matematica');


SELECT S.Matricola AS MatricolaStudente, S.Nome AS NomeStudente, E.Codice AS CodiceEsame, E.Voto,
D.Nome AS NomeDocente
FROM STUDENTE S
JOIN ESAME E ON S.Matricola = E.MatricolaStudente
JOIN CORSO C ON E.Codice = C.Codice
JOIN DOCENTE D ON C.MatricolaDocente = D.Matricola
WHERE E.Voto > 28;

--
SELECT D.Nome AS NomeDocente, COUNT(C.Codice) AS NumeroEsamiTenuti
FROM DOCENTE D
LEFT JOIN CORSO C ON D.Matricola = C.MatricolaDocente
GROUP BY D.Matricola, D.Nome;