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

CREATE TABLE Dipendente(
    id INTEGER ,
    nome VARCHAR(20),
    cognome VARCHAR(20),
    email VARCHAR(50),
    numerotelefono DOUBLE,
    data_assunzione DATE,
    id_lavoro VARCHAR(20),
    salario VARCHAR(20),
    id_manager VARCHAR(20),
    id_dipartimento VARCHAR(20)
    );
CREATE TABLE Dipartimento(
    id_dipartimento VARCHAR(20),
    nome_dip TEXT NOT NULL,
    id_manager VARCHAR(20) ,
    id_location INTEGER
    );
    
INSERT INTO Dipendente (id, nome, cognome, email, numerotelefono, data_assunzione, id_lavoro, salario, id_manager, id_dipartimento)
VALUES
(1, 'renato', 'codola', 'codola@studio.it', 3643783839, '2017-06-23', 'com1', '1500£', 'man1', 'venMarket1'),
(2, 'laura', 'bes', 'bes@studio.it', 3143293839, '2017-08-23', 'DG1', '3500£', 'man2', 'dirAmmin'),
(3, 'marco', 'rossi', 'rossi@studio.it', 3723783839, '2018-03-24', 'rh1', '2000£', 'man3', 'dirRh'),
(4, 'joan', 'bocelli', 'bocelli@studio.it', 3293783819, '2019-05-21', 'DG2', '3500£', 'man2', 'dirAmmin'),
(5, 'romeo', 'luigi', 'tale@studio.it', 3143753830, '2018-06-12', 'mark1', '1500£', 'man1', 'venMarket1');


INSERT INTO Dipartimento(id_dipartimento, nome_dip, id_manager, id_location)
 VALUES
('venMarket1','vendita e marketing','man1',20),
('dirAmmin',' amministrazione','man2',21),
('dirR',' direzione risorse umane','man3',22);

#SELECT * FROM Dipendente;
 #SELECT * FROM Dipartimento;   
 -- Visualizzare la data di assunzione dei manager e i loro id appartenenti al dipartimento  
SELECT DATE_FORMAT(D.data_assunzione, "%d, %m, %y") AS DateAssunzioneManager, D.id AS IdManager
FROM Dipendente D
JOIN Dipartimento DI ON  DI.id_dipartimento=D.id
WHERE DI.nome_dip = 'amministrazione'; 

/*SELECT DATE_FORMAT(d.data_assunzione, "%M, %D, %Y") AS Assunzione, d.id_manager
    FROM Dipendente d
        JOIN Dipartimento dipar
        ON dipar.id_dipartimento = d.id 
            WHERE dipar.nome_dip = "Amministrazione";
#--visualizzare il nome e i cognome dei dipendenti assunti nel mese di giugno
/*SELECT nome , cognome
FROM Dipendente
WHERE MONTH(data_assunzione)=6;

#--visualizzare gli anni in cui piu di 10 dipendenti sono stati assunti
SELECT YEAR(data_assunzione) AS dataAssunzione
FROM Dipendente 
GROUP BY YEAR(data_assunzione)
HAVING COUNT(*)>10;


#--Visualizzare il nome del dipartimento, il nome del manager, il salario del manager di tutti i manager la cui esperienza è maggiore di 5 anni
SELECT DI.nome_dip AS NomeDipartimento, D.nome AS NomeManager, D.salario AS SalarioManager
FROM Dipendente D
JOIN Dipartimento DI ON D.id_dipartimento = DI.id_dipartimento
WHERE D.id = DI.id_manager AND DATEDIFF(NOW(), D.data_assunzione) > 5 * 365; 



