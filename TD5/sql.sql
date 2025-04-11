DROP TABLE IF EXISTS EMPLOYE,DEPARTEMENT;

CREATE TABLE  DEPARTEMENT (
    idDept INT,
    nom VARCHAR(255),
    lieu VARCHAR(255),
    PRIMARY KEY(idDept)
);

INSERT INTO DEPARTEMENT (idDept,nom,lieu)  VALUES (10,"recherche","Besançon");
INSERT INTO DEPARTEMENT (idDept,nom,lieu)  VALUES (20,"vente","Montbéliard");
INSERT INTO DEPARTEMENT (idDept,nom,lieu)  VALUES (30,"direction","Belfort");
INSERT INTO DEPARTEMENT (idDept,nom,lieu)  VALUES (40,"fabrication","Sochaux");

CREATE TABLE  EMPLOYE (
    idEmploye INT AUTO_INCREMENT,
    nom VARCHAR(255),
    fonction VARCHAR(255),
    idResponsable INT,
    date_embauche date,
    salaire NUMERIC(8,2),
    prime NUMERIC(8,2),
    departement_id INT,
    PRIMARY KEY(idEmploye)
);
INSERT INTO EMPLOYE(nom,idEmploye,fonction,idResponsable,date_embauche,salaire,prime,departement_id) VALUES 
('MARTIN',16712,'directeur',25717,'2000-05-23',8000,NULL,30);
INSERT INTO EMPLOYE(nom,idEmploye,fonction,idResponsable,date_embauche,salaire,prime,departement_id) VALUES 
('DUPONT',17574,'administratif',16712,'2005-05-03',1800,NULL,30),
('DUPOND',26691,'commercial',27047,'1998-04-04',5000,500,20),
('LAMBERT',25012,'administratif',27047,'2001-03-14',NULL,2400,20),
('JOUBERT',25717,'president',NULL,'1992-08-10',10000,NULL,30),
('LEBRETON',16034,'commercial',27047,'2001-06-01',3000,0,20),
('MARTIN',17147,'commercial',27047,'2005-05-03',4000,500,20),
('PAQUEL',27546,'commercial',27047,'1993-09-03',4400,1000,20),
('LEFEBVRE',25935,'commercial',27047,'1994-01-11',4700,400,20),
('GARDARIN',15155,'ingenieur',24533,'1995-03-22',4800,NULL,10),
('SIMON',26834,'ingenieur',24533,'1998-10-04',4000,NULL,10),
('DELOBEL',16278,'ingenieur',24533,'2004-11-16',4200,NULL,10),
('ADIBA',25067,'ingenieur',24533,'1997-10-05',6000,NULL,10),
('CODD',24533,'directeur',25717,'1985-11-12',11000,NULL,10),
('LAMERE',27047,'directeur',25717,'1999-09-07',9000,NULL,20),
('BALIN',17232,'administratif',24533,'1997-10-03',2700,NULL,10),
('BARA',24831,'administratif',16712,'1998-11-10',3000,NULL,30),
('toto','00001','livreur de pizzas',NULL,NULL,NULL,NULL,NULL);




SELECT EMPLOYE.nom,EMPLOYE.fonction, DEPARTEMENT.nom
FROM EMPLOYE
INNER JOIN DEPARTEMENT ON EMPLOYE.departement_id = DEPARTEMENT.idDept
ORDER BY DEPARTEMENT.nom, EMPLOYE.nom;


-- A ne pas faire parce ce que c'est de la merde
SELECT EMPLOYE.nom,EMPLOYE.fonction, DEPARTEMENT.nom
FROM EMPLOYE, DEPARTEMENT
WHERE EMPLOYE.departement_id = DEPARTEMENT.idDept
ORDER BY DEPARTEMENT.nom, EMPLOYE.nom;


SELECT EMPLOYE.nom,EMPLOYE.fonction, DEPARTEMENT.nom
FROM EMPLOYE
LEFT JOIN DEPARTEMENT ON EMPLOYE.departement_id = DEPARTEMENT.idDept
ORDER BY DEPARTEMENT.nom, EMPLOYE.nom;

SELECT EMPLOYE.nom,EMPLOYE.fonction, DEPARTEMENT.nom
FROM EMPLOYE
RIGHT JOIN DEPARTEMENT ON EMPLOYE.departement_id = DEPARTEMENT.idDept
ORDER BY DEPARTEMENT.nom, EMPLOYE.nom;


SELECT COUNT(EMPLOYE.nom) AS nb_employes, DEPARTEMENT.nom, DEPARTEMENT.lieu
FROM DEPARTEMENT
JOIN EMPLOYE ON EMPLOYE.departement_id = DEPARTEMENT.idDept
GROUP BY DEPARTEMENT.nom, DEPARTEMENT.lieu
ORDER BY DEPARTEMENT.nom;

SELECT COUNT(EMPLOYE.nom) AS nb_employes, DEPARTEMENT.nom, DEPARTEMENT.lieu
FROM DEPARTEMENT
LEFT JOIN EMPLOYE ON EMPLOYE.departement_id = DEPARTEMENT.idDept
GROUP BY DEPARTEMENT.nom, DEPARTEMENT.lieu
ORDER BY DEPARTEMENT.nom;


SELECT COUNT(EMPLOYE.nom) AS nb_employes, DEPARTEMENT.nom, DEPARTEMENT.lieu
FROM DEPARTEMENT
RIGHT JOIN EMPLOYE ON EMPLOYE.departement_id = DEPARTEMENT.idDept
GROUP BY DEPARTEMENT.nom, DEPARTEMENT.lieu
ORDER BY DEPARTEMENT.nom;


SELECT COUNT(EMPLOYE.nom) AS nb_employes, DEPARTEMENT.nom
FROM DEPARTEMENT
LEFT JOIN EMPLOYE ON EMPLOYE.departement_id = DEPARTEMENT.idDept
GROUP BY DEPARTEMENT.nom
HAVING COUNT(EMPLOYE.nom) <= 0
ORDER BY DEPARTEMENT.nom;



SELECT E1.nom, E1.fonction, E2.nom AS nomResponsable, E2.fonction AS fonctionResponsable
FROM EMPLOYE AS E1
JOIN EMPLOYE AS E2 ON E1.idResponsable = E2.idEmploye
ORDER BY fonctionResponsable, nomResponsable, fonction, nom;


SELECT E1.nom, E1.fonction, E2.nom AS nomResponsable, E2.fonction AS fonctionResponsable
FROM EMPLOYE AS E1
JOIN EMPLOYE AS E2 ON E1.idResponsable = E2.idEmploye
WHERE E2.idResponsable IS NULL
ORDER BY fonctionResponsable, nomResponsable, fonction, nom;



SELECT E1.nom, E1.fonction, E1.salaire
FROM EMPLOYE AS E1
INNER JOIN EMPLOYE AS E2 ON E1.salaire>E2.salaire
WHERE E2.nom like 'SIMON';


SELECT E.nom, E.fonction, E.salaire
FROM EMPLOYE AS E
WHERE E.salaire > (
    SELECT salaire 
    FROM EMPLOYE 
    WHERE nom = 'SIMON'
);

SELECT nom, fonction, salaire, idResponsable
FROM EMPLOYE
WHERE fonction = (
    SELECT fonction
    FROM EMPLOYE
    WHERE nom = 'CODD'
);

SELECT nom, fonction, salaire
FROM EMPLOYE
WHERE salaire > (
    SELECT AVG(salaire)
    FROM EMPLOYE
);

SELECT nom, fonction, salaire
FROM EMPLOYE
WHERE salaire > ALL (
    SELECT salaire
    FROM EMPLOYE
    WHERE departement_id = 20 AND salaire IS NOT NULL
);

SELECT MIN(salaire)
FROM EMPLOYE
WHERE departement_id = 20 ;


SELECT nom, fonction, salaire
FROM EMPLOYE
WHERE salaire > ANY (
    SELECT salaire
    FROM EMPLOYE
    WHERE departement_id = 20 AND salaire IS NOT NULL
);

SELECT nom, fonction, salaire, idResponsable
FROM EMPLOYE
WHERE (fonction, idResponsable) = (
    SELECT fonction, idResponsable
    FROM EMPLOYE
    WHERE nom = 'CODD'
);

SELECT nom
FROM EMPLOYE
WHERE (departement_id, idResponsable) NOT IN (
    SELECT departement_id, idEmploye
    FROM EMPLOYE
);

SELECT E.nom
FROM EMPLOYE AS E
WHERE E.departement_id <> (
    SELECT E2.departement_id
    FROM EMPLOYE AS E2
    WHERE E.idResponsable = E2.idEmploye
) AND E.idResponsable IS NOT NULL;

SELECT E.nom, E.idEmploye, E.fonction, E.date_embauche, E.departement_id
FROM EMPLOYE AS E
WHERE EXISTS (
    SELECT *
    FROM EMPLOYE
    WHERE date_embauche >= "2005-1-1"
        AND departement_id = E.departement_id
);

SELECT D.idDept, D.nom, D.lieu
FROM EMPLOYE AS E
JOIN DEPARTEMENT AS D ON E.departement_id = D.idDept
WHERE E.nom = 'DUPONT';

SELECT nom, fonction, departement_id
FROM EMPLOYE
WHERE fonction IN (
    SELECT fonction
    FROM EMPLOYE
    WHERE departement_id = (
        SELECT departement_id
        FROM EMPLOYE
        WHERE nom = 'DUPONT'
    )
) AND departement_id = 10;



DROP TABLE IF EXISTS CLIENT1,CLIENT2;
CREATE TABLE CLIENT1 (
    nom varchar(30)
);
INSERT INTO CLIENT1 VALUES ('nom1');
INSERT INTO CLIENT1 VALUES ('nom2');
INSERT INTO CLIENT1 VALUES ('nom3');

CREATE TABLE CLIENT2 (
    nom varchar(30)
);
INSERT INTO CLIENT2 VALUES ('nom1');
INSERT INTO CLIENT2 VALUES ('nom2');
INSERT INTO CLIENT2 VALUES ('nom10');
INSERT INTO CLIENT2 VALUES ('nom11');

SELECT nom FROM CLIENT1;
SELECT nom FROM CLIENT2;


SELECT nom FROM CLIENT1
UNION
SELECT nom FROM CLIENT2;

SELECT nom FROM CLIENT1
UNION ALL
SELECT nom FROM CLIENT2;


SELECT nom FROM CLIENT1
INTERSECT
SELECT nom FROM CLIENT2;   -- (nom1 et nom2)
-- |
SELECT nom FROM CLIENT1
WHERE nom IN
(SELECT nom FROM CLIENT2);



SELECT nom FROM CLIENT1
EXCEPT              
SELECT nom FROM CLIENT2; -- (nom3)
-- |
SELECT nom FROM CLIENT1
WHERE nom NOT IN
(SELECT nom FROM CLIENT2);


SELECT D.nom, D.idDept, E.nom, E.fonction, E.departement_id
FROM EMPLOYE AS E
RIGHT JOIN DEPARTEMENT AS D ON E.departement_id = D.idDept
UNION
SELECT D.nom, D.idDept, E.nom, E.fonction, E.departement_id
FROM EMPLOYE AS E
LEFT JOIN DEPARTEMENT AS D ON E.departement_id = D.idDept;

SHOW CREATE TABLE EMPLOYE;
ALTER TABLE EMPLOYE ADD INDEX `departement_nom_index` (`nom`);
ALTER TABLE EMPLOYE ADD INDEX `employe_date_embauche_index` (`date_embauche`);
SHOW CREATE TABLE EMPLOYE;
SHOW INDEX FROM EMPLOYE \G;

EXPLAIN SELECT EMPLOYE.nom FROM EMPLOYE WHERE fonction LIKE 'd%' AND date_embauche >='1985-11-12' \G;


EXPLAIN
SELECT DISTINCT E1.nom 
  FROM EMPLOYE E1, DEPARTEMENT D1, EMPLOYE E2, DEPARTEMENT D2
WHERE E1.departement_id=D1.idDept 
       AND E2.departement_id=D2.idDept 
AND D1.nom='vente'
AND D2.nom='direction'
AND E1.date_embauche=E2.date_embauche
\G;

SHOW GLOBAL STATUS like "%used_connections";
show global status like 'opened_tables';
SELECT @@table_open_cache;
SELECT @@max_connections;