-- pas d'utilisation de compteur : AUTO_INCREMENT

DROP TABLE IF EXISTS TD_groupe;
DROP TABLE IF EXISTS TD_etudiant;

CREATE TABLE TD_groupe (
    idGroupe int
    , libelle varchar(25)
    , PRIMARY KEY (idGroupe)
);
SHOW CREATE TABLE TD_groupe;

CREATE TABLE TD_etudiant (
    noEtudiant int
    , nomEtudiant varchar(25)
    , idGroupe int
    , PRIMARY KEY (noEtudiant)
    , CONSTRAINT fk_TD_etudiant_groupe
        FOREIGN KEY (idGroupe) 
        REFERENCES TD_groupe(idGroupe)
            ON UPDATE CASCADE ON DELETE SET NULL
);
SHOW CREATE TABLE TD_etudiant;

INSERT INTO TD_groupe VALUES(1,'S2A1');  -- id 1
INSERT INTO TD_groupe VALUES(2,'S2A2'); -- id 2
INSERT INTO TD_groupe VALUES(3,'S2bisA1'); -- id 3

INSERT INTO TD_etudiant VALUES(1,'paul',1);
INSERT INTO TD_etudiant VALUES(2,'pierre',2);
INSERT INTO TD_etudiant VALUES(3,'toto',3);

SELECT * FROM TD_etudiant;
UPDATE TD_groupe SET idGroupe=25 WHERE idGroupe=2;
SELECT * FROM TD_etudiant;
DELETE FROM  TD_groupe  WHERE idGroupe=1;
SELECT * FROM TD_etudiant;
SELECT * FROM TD_groupe;

DROP TABLE IF EXISTS TD_etudiant;
DROP TABLE IF EXISTS TD_groupe;
SHOW TABLES;