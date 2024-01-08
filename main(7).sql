#progetto settimanale
-- Creazione della tabella vendite
CREATE TABLE vendite (
    ID_transazione INTEGER PRIMARY KEY,
    categoria_prodotto VARCHAR(25),
    costo VARCHAR(25),
    sconto DECIMAL(5, 2)
);

-- Creazione della tabella dettagli_vendite
CREATE TABLE dettagli_vendite (
    ID_transazione INTEGER PRIMARY KEY,
    data_transazione DATE,
    quantita INTEGER,
    FOREIGN KEY (ID_transazione) REFERENCES vendite(ID_transazione)
);

# Inserimento dei dati 
INSERT INTO vendite (ID_transazione, categoria_prodotto, costo, sconto)
VALUES
(1, 'Alimentari', '5000£', 30.00),    
(2, 'Ufficio', '20000£', 20.00),    
(3, 'Casa', '8000£', 50.00),  
(4, 'Elettronica', '6000£', 50.00),
(5, 'Abbigliamento','4000£', 35.00),
(6, 'Ufficio','2500£', 20.00),
(7, 'Elettronica','6000£', 20.00),
(8, 'Abbigliamento', '30000£', 10.00),
(9, 'Bevanda', '45000£', 20.00),
(10, 'Elettronica', '5500£', 15.00),
(11, 'Trucco', '1100£', 10.00),
(12, 'Casa', '2800£', 20.00),
(13, 'Ufficio', '7500£', 25.00),
(14, 'Alimentari', '1400£', 15.00),
(15, 'Casa', '3200£', 55.00),
(16, 'Bevanda','6800£', 30.00),
(17, 'Abbigliamento', '1600£', 15.00),
(18, 'Casa','2700£', 10.00),
(19, 'Bevanda', '6200£', 30.00),
(20, 'Abbigliamento', '1255£', 10.00),
(21, 'Casa', '3000£', 15.00),
(22, 'Elettronica', '4000£', 25.00),
(23, 'Abbigliamento', '1450£', 10.00),
(24, 'Casa', '3100£', 25.00),
(25, 'Elettronica','8000£', 15.00),
(26, 'Trucco', '1205£', 10.00),
(27, 'Casa', '2700£', 25.00),
(28, 'Elettronica', '6500£', 14.00),
(29, 'Trucco', '1355£', 12.50),
(30, 'Casa', '3300£', 22.50),
(31, 'Elettronica', '7200£', 12.50),
(32, 'Abbigliamento','2070£', 22.00),
(33, 'Casa', '8000£', 15.00),
(34, 'Ufficio','8800£', 25.60),
(35, 'Abbigliamento', '1600£', 18.00);


INSERT INTO dettagli_vendite(ID_transazione,data_transazione ,quantita) 
VALUES
(1, '2016-01-12', 50),
(2, '2016-01-20', 23),
(3, '2016-03-14', 60),
(4, '2017-06-15', 70),
(5, '2017-07-16', 50),
(6, '2018-01-17', 20),
(7, '2018-03-18', 25),
(8, '2018-06-25', 40),
(9, '2018-06-25', 25),
(10, '2018-09-21', 30),
(11, '2018-02-28', 15),
(12, '2019-02-22', 15),
(13, '2019-02-24', 15),
(14, '2019-07-12', 15),
(15, '2019-08-11', 70),
(16, '2020-10-15', 90),
(17, '2021-02-22', 200),
(18, '2023-12-26', 75),
(19, '2021-03-27', 20),
(20, '2021-07-01',45),
(21, '2023-11-29', 100),
(22, '2021-10-30', 35),
(23, '2022-02-11', 18),
(24, '2023-01-01', 33),
(25, '2023-04-12', 70),
(26, '2023-05-13', 90),
(27, '2023-06-14', 30),
(28, '2023-07-15', 10),
(29, '2023-08-16', 30),
(30, '2023-09-17', 10),
(31, '2023-10-01', 20),
(32, '2023-10-19', 40),
(33, '2023-11-20', 20),
(34, '2023-12-31', 65),
(35, '2024-11-02', 18);



 #3-seleziona tutte le vendite avvenute in una data specifica
SELECT*
FROM vendite  V
JOIN dettagli_vendite  D ON V.ID_transazione=D.ID_transazione
WHERE D.data_transazione='2016-01-12';
    
#vendie con sconti > 50%
SELECT *
FROM vendite
WHERE sconto>0.5;

#4-calcola il totale delle vendite(costo) per categoria_prodotto
SELECT categoria_prodotto,SUM(costo) AS Totale_vendite
FROM vendite
GROUP BY categoria_prodotto;
    
#trova il numero totale di prodotto venduti per ogni categoria 
SELECT categoria_prodotto,SUM(quantita) AS Totale_venduti
FROM vendite V
JOIN dettagli_vendite D ON V.ID_transazione=D.ID_transazione
GROUP BY categoria_prodotto;

#5-seleziona le vendite dell'ultimo trimestre
SELECT *
FROM vendite V
JOIN dettagli_vendite D ON V.ID_transazione = D.ID_transazione
WHERE D.data_transazione >= '2023-10-01' AND D.data_transazione <= '2023-12-31';

#raggruppa le vendite per mese e calcola il totale delle vendite per ogni mese
SELECT
MONTH(D.data_transazione)AS mese,
YEAR(D.data_transazione) AS anno,
SUM(costo) AS Totale_vendite
FROM vendite V
JOIN dettagli_vendite D ON V.ID_transazione = D.ID_transazione
WHERE D.data_transazione >= '2023-10-01' AND D.data_transazione <= '2023-12-31'
GROUP BY MONTH(D.data_transazione),YEAR(D.data_transazione)
ORDER BY mese,anno;

#7-trova la categoria con lo sconto piu alto
SELECT categoria_prodotto, MAX(sconto_medio) AS sconto_medio_max
FROM (
    SELECT categoria_prodotto, AVG(sconto) AS sconto_medio
FROM vendite
GROUP BY categoria_prodotto
)
AS sconti_per_categoria
GROUP BY categoria_prodotto
LIMIT 1;
#8-•Confronta le vendite mese per mese per vedere l'incremento o il decremento delle vendite. 
#Calcola l’incremento o decremento mese per mese
SELECT
    anno,
    mese,
    SUM(costo_vendita) AS totale_vendite,
    LAG(SUM(costo_vendita)) OVER (ORDER BY anno, mese) AS vendite_precedenti,
    CASE WHEN LAG(SUM(costo_vendita)) OVER (ORDER BY anno, mese) IS NOT NULL THEN
    SUM(costo_vendita) - LAG(SUM(costo_vendita)) OVER (ORDER BY anno, mese)
    ELSE 0
    END AS variazione_mese
FROM (
    SELECT
        YEAR(dettagli_vendite.data_transazione) AS anno,
        MONTH(dettagli_vendite.data_transazione) AS mese,
        vendite.costo_vendita
    FROM vendite
    JOIN dettagli_vendite ON vendite.ID_transazione = dettagli_vendite.ID_transazione
) AS vendite_mese
GROUP BY anno, mese
ORDER BY anno, mese;

#9-Confronta le vendite totali in diverse stagioni
SELECT
CASE
WHEN mese IN (6, 7, 8) THEN 'Estate'
WHEN mese IN (9, 10, 11) THEN 'Autunno'
WHEN mese IN (12, 1, 2) THEN 'Inverno' 
WHEN mese IN (3, 4, 5) THEN 'Primavera' END AS stagione,
 SUM(costo) AS vendite_totali
FROM (
SELECT
YEAR(D.data_transazione) AS anno,
MONTH(D.data_transazione) AS mese,
        vendite.costo
FROM vendite V
JOIN dettagli_vendite ON V.ID_transazione = D.ID_transazione
) AS vendite_stagione
GROUP BY stagione
ORDER BY stagione;

#Creazione della tabella clienti
CREATE TABLE clienti (
    ID_Clienteliente INTEGER PRIMARY KEY,
    nome VARCHAR(20),
    cognomeVARCHAR(20)
);

#Inserimento dati nella tabella clienti
INSERT INTO clienti VALUES
(1, 'laurette', 'bes'),
(2, 'Lisa', 'renato'),
(3, 'Giovanni', 'Verdi'),
(4, 'nadia', 'Neri'),
(5, 'Paolo', 'Gialli'),
(6, 'Laura', 'Azzurri'),
(7, 'andrea', 'Rosa'),
(8, 'paola', 'Viola'),
(9, 'Roberto', 'Arancioni'),
(10, 'Elena', 'Marroni'),
(11, 'Francesco', 'Giallo'),
(12, 'Alessia', 'Bianchi'),
(13, 'Davide', 'Verdi'),
(14, 'Martina', 'Rossi'),
(15, 'Simone', 'Neri'),
(16, 'Chiara', 'Azzurri'),
(17, 'Andrea', 'Rosa'),
(18, 'Giulia', 'Viola'),
(19, 'Marco', 'Arancioni'),
(20, 'Camilla', 'Marroni');


# Aggiungo la colonna IDCliente alla tabella dettagli_vendite
ALTER TABLE dettagli_vendite
ADD COLUMN IDCliente INT;
ALTER TABLE dettagli_vendite
ADD FOREIGN KEY (IDCliente) REFERENCES clienti(IDCliente);

UPDATE dettagli_vendite
SET IDCliente = 1
WHERE ID_transazione IN (4, 5); 

UPDATE dettagli_vendite
SET IDCliente = 2
WHERE ID_transazione IN (6, 7); 

UPDATE dettagli_vendite
SET IDCliente = 3
WHERE ID_transazione IN (8, 9);

UPDATE dettagli_vendite
SET IDCliente = 4
WHERE ID_transazione IN (10, 11);

UPDATE dettagli_vendite
SET IDCliente = 5
WHERE ID_transazione IN (12, 13);

UPDATE dettagli_vendite
SET IDCliente = 6
WHERE ID_transazione IN (14, 15);

UPDATE dettagli_vendite
SET IDCliente = 7
WHERE ID_transazione IN (16, 17);

UPDATE dettagli_vendite
SET IDCliente = 8
WHERE ID_transazione IN (18, 19);

UPDATE dettagli_vendite
SET IDCliente = 9
WHERE ID_transazione IN (20, 21);

UPDATE dettagli_vendite
SET IDCliente = 10
WHERE ID_transazione IN (22, 22, 23);

UPDATE dettagli_vendite
SET IDCliente = 11
WHERE ID_transazione IN (24, 25, 26);

UPDATE dettagli_vendite
SET IDCliente = 12
WHERE ID_transazione IN (27, 28, 29);

UPDATE dettagli_vendite
SET IDCliente = 13
WHERE ID_transazione IN (30);

UPDATE dettagli_vendite
SET IDCliente = 14
WHERE ID_transazione IN (31, 32, 33);

UPDATE dettagli_vendite
SET IDCliente = 15
WHERE ID_transazione IN (34);

UPDATE dettagli_vendite
SET IDCliente = 16
WHERE ID_transazione IN (35);

UPDATE dettagli_vendite
SET IDCliente = 17
WHERE ID_transazione IN (36, 37, 38);

UPDATE dettagli_vendite
SET IDCliente = 18
WHERE ID_transazione IN (39, 40, 41);

UPDATE dettagli_vendite
SET IDCliente = 19
WHERE ID_transazione IN (42, 43);

UPDATE dettagli_vendite
SET IDCliente = 20
WHERE ID_transazione IN (44, 45);

UPDATE dettagli_vendite
SET IDCliente = 21
WHERE ID_transazione IN (46, 47); 

UPDATE dettagli_vendite
SET IDCliente = 22
WHERE ID_transazione IN (48, 49); 

UPDATE dettagli_vendite
SET IDCliente = 23
WHERE ID_transazione IN (50);

UPDATE dettagli_vendite
SET IDCliente = 24
WHERE ID_transazione IN (51);

UPDATE dettagli_vendite
SET IDCliente = 25
WHERE ID_transazione IN (52);

UPDATE dettagli_vendite
SET IDCliente = 26
WHERE ID_transazione IN (53);

UPDATE dettagli_vendite
SET IDCliente = 27
WHERE ID_transazione IN (54, 55);

UPDATE dettagli_vendite
SET IDCliente = 28
WHERE ID_transazione IN (56);

UPDATE dettagli_vendite
SET IDCliente = 29
WHERE ID_transazione IN (57, 58);

UPDATE dettagli_vendite
SET IDCliente = 30
WHERE ID_transazione IN (59, 60);

# Top 5 clienti con il maggior numero di acquisti:
SELECT c.IDCliente, c.nome_cliente, c.cognome_cliente, SUM(d.quantita) AS totale_acquisti
FROM clienti c
JOIN dettagli_vendite d ON c.IDCliente = d.IDCliente
GROUP BY c.IDCliente, c.nome_cliente, c.cognome_cliente
ORDER BY totale_acquisti ;

