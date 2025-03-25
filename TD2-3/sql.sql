DROP TABLE IF EXISTS telephone;
DROP TABLE IF EXISTS marque_tel;
DROP TABLE IF EXISTS type_tel;

CREATE TABLE marque_tel
(
    idMarque    INT AUTO_INCREMENT
    , libelle   VARCHAR(256)
    , pays      VARCHAR(256)
    , PRIMARY KEY  (idMarque)
);

CREATE TABLE type_tel
(
    idType    VARCHAR(2)
    , libelle VARCHAR(256)
    , PRIMARY KEY (idType)
);

CREATE TABLE telephone
(
    idTelephone         INT AUTO_INCREMENT
    , type_id           VARCHAR(2)
    , marque_id         INT 
    , date_achat        DATE
    , prix              NUMERIC(9, 2)
    , proprietaire_id   INT
    , couleur           VARCHAR(128)
    , PRIMARY KEY (idTelephone)
    , FOREIGN KEY (type_id) REFERENCES type_tel(idType)
    , FOREIGN KEY (marque_id) REFERENCES marque_tel(idMarque)
);



/* Jeu de test issu d'un exercice sur ORACLE : sur ORACLE to_date('15/01/2021', '%d/%m/%Y') remplace STR_TO_DATE('15/01/2021', '%d/%m/%Y') */

INSERT INTO type_tel VALUES ('SP','Smartphone');
INSERT INTO type_tel VALUES ('CL','clapet');
INSERT INTO type_tel VALUES ('CO','COULISSANT');
INSERT INTO type_tel VALUES ('IP','IPHONE');
INSERT INTO type_tel VALUES ('AU','AUTRE');


INSERT INTO marque_tel VALUES (NULL, 'société SAMSUNG','COREE');
INSERT INTO marque_tel VALUES (NULL, 'entreprise SONY','JAPON');
INSERT INTO marque_tel VALUES (NULL, 'groupe PHILIPS','PAYS BAS');
INSERT INTO marque_tel VALUES (NULL, 'marque MOTOROLA','USA');
INSERT INTO marque_tel VALUES (NULL, 'SOCIETE APPLE','USA');



INSERT INTO telephone (idTelephone,type_id,marque_id,date_achat,prix,proprietaire_id,couleur) VALUES (1,'SP' ,1,STR_TO_DATE('15/01/2020', '%d/%m/%Y'),139.99,190120,'ROUGE');
-- il est déconseillé de mettre une valeur à une clé primaire => pour vérification
INSERT INTO telephone (idTelephone,type_id,marque_id,date_achat,prix,proprietaire_id) VALUES (NULL,'SP' ,2,STR_TO_DATE('14/03/2020', '%d/%m/%Y'), 99.99,190215);
INSERT INTO telephone
(idTelephone,type_id,marque_id,date_achat,prix,proprietaire_id,couleur) VALUES
(NULL,'CL' ,3,STR_TO_DATE('02/05/2020', '%d/%m/%Y'), 49.11,190001,'NOIR');
INSERT INTO telephone
(idTelephone,type_id,marque_id,date_achat,prix,proprietaire_id,couleur) VALUES
(NULL,'CO' ,4,STR_TO_DATE('25/07/2020', '%d/%m/%Y'), 89.14,190222,'BLANC');
INSERT INTO telephone
(idTelephone,type_id,marque_id,date_achat,prix,proprietaire_id)         VALUES
(NULL,'IP' ,5,STR_TO_DATE('30/09/2020', '%d/%m/%Y'),359.49,190561);
INSERT INTO telephone
(idTelephone,type_id,marque_id,date_achat,prix,proprietaire_id,couleur) VALUES
(NULL,'CO' ,5,STR_TO_DATE('01/01/2021', '%d/%m/%Y'), 99.51,122120,'BLANC'),
(NULL,'SP' ,1,'2013-01-15',189,190622,'ROUGE'),
(NULL,NULL ,NULL,'2013-01-15',20,190623,'ROUGE'),
(NULL,NULL ,1,'2013-01-15',NULL,NULL,NULL);




SELECT IFNULL(couleur, "NC") FROM telephone;


SELECT COALESCE( CONCAT(type_id, '-', IFNULL(couleur, "NC")), "NV") AS votreFonction
FROM telephone;