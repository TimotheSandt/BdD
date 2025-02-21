DROP TABLE IF EXISTS TD_etudiant;


CREATE TABLE TD_etudiant (
    noEtudiant varchar(255)
    , nomEtudiant varchar(25)
    , idGroupe int
    , PRIMARY KEY (noEtudiant)
);
SHOW CREATE TABLE TD_etudiant;


INSERT INTO TD_etudiant VALUES(UUID(),'paul',1);
INSERT INTO TD_etudiant VALUES(UUID(),'pierre',2);
INSERT INTO TD_etudiant VALUES(UUID(),'toto',3);

SELECT * FROM TD_etudiant;

DROP TABLE IF EXISTS TD_etudiant;
SHOW TABLES;