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


SELECT date_achat, 
    YEAR(date_achat) as Annee,
    DATEDIFF(date_achat, CURDATE()) as "Difference" ,
    DATE_ADD(date_achat, INTERVAL 30 DAY) as Plus30j ,
    DATE_SUB(date_achat, INTERVAL 30 DAY) as Moins30j ,
    DATE_ADD(date_achat, INTERVAL -30 DAY) as Moins30j2    
FROM telephone;


DROP TABLE IF EXISTS posts;
CREATE TABLE posts (
id_post  INT  AUTO_INCREMENT
, title VARCHAR(255) NOT NULL
, content LONGTEXT
, online VARCHAR(255) DEFAULT 0
, dt_created_at DATETIME  NOT NULL DEFAULT CURRENT_TIMESTAMP
, dt_updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
, ts_created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
, ts_updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
, PRIMARY KEY (id_post)
);

INSERT INTO posts(title, online) VALUES('titre post1', 0);
INSERT INTO posts(title, online) VALUES('titre post2', 1);
INSERT INTO posts SET title='titre post3' , online=2;
INSERT INTO posts VALUES
(NULL, 'titre post4', NULL, 0, '2023-01-01 12:00:00', '2023-01-01 12:00:00', '2023-01-01 12:00:00', '2023-01-01 12:00:00');
SELECT * FROM posts;

UPDATE posts SET title='titre post1 new' WHERE id_post=1;
SELECT * FROM posts;


SELECT @@global.time_zone, @@session.time_zone;

SET time_zone = '+03:00';

SELECT @@global.time_zone, @@session.time_zone;

INSERT INTO posts(title, online) VALUES('titre post5', 0);
INSERT INTO posts(title, online) VALUES('titre post6', 1);
SELECT * FROM posts;

SET time_zone = 'SYSTEM';
SELECT @@global.time_zone, @@session.time_zone;


SELECT UTC_TIMESTAMP,UTC_TIMESTAMP();
SELECT UTC_TIMESTAMP()+0;

SELECT @@global.time_zone, @@session.time_zone;
SELECT TIMEDIFF(NOW(), CONVERT_TZ(NOW(),  @@session.time_zone, '+00:00'));


INSERT INTO posts VALUES(NULL, 'titre post7', NULL, 0, NOW(), NOW(), NOW(), NOW() );
INSERT INTO posts VALUES(NULL, 'titre post8', NULL,1, CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP() , CURRENT_TIMESTAMP(), CURRENT_TIMESTAMP());
INSERT INTO posts VALUES(NULL, 'titre post9', NULL, 0, '2023-03-29 12:00:00', '2023-03-29 12:00:00', '2023-03-29 12:00:00', '2023-03-29 12:00:00');

SELECT * FROM posts;

SELECT libelle,
    INSTR(libelle, ' '),
    LEFT(libelle, INSTR(libelle, ' ')- 1),
    SUBSTRING(libelle, INSTR(libelle, ' ')+ 1, 100),
    LTRIM(SUBSTRING(libelle, INSTR(libelle, ' '), 100))
FROM marque_tel;



SELECT 
    idTelephone
    , idTelephone / 2   -- attention au trans-typage CAST
    , prix
    , COALESCE(prix, 0) * 2
    , CEILING(prix)          -- CEIL sur ORACLE
    , FLOOR(prix)
    , ROUND(prix, 1)
FROM telephone;





-- 2

SELECT tel.prix AS PRIX
       , IF(tel.prix <99 ,"premier Prix", IF(tel.prix<259,"prix medium","prix élevé"))
FROM telephone AS tel
WHERE tel.prix IS NOT NULL;

SELECT tel.date_achat AS ACHAT
    , tel.type_id AS type
    , tel.marque_id AS MARQUE
    , marq.libelle AS LIBELLE
    , CASE tel.marque_id
        WHEN 1 THEN 'MEILLEURS VENTES'
        WHEN 5 THEN 'Très bonnes ventes'
        ELSE 'AUTRES ventes'
    END AS type_de_vente
FROM telephone tel        
INNER JOIN  marque_tel AS marq
  ON tel.marque_id = marq.idMarque ;

SELECT tel.DATE_ACHAT AS dateAchat
    , type.libelle AS type
    , marq.libelle AS marque
    , tel.PRIX AS prix
    , CASE
        WHEN tel.PRIX <= 99 THEN 'premier Prix'
        WHEN tel.PRIX >= 300 THEN 'Prix élevé'
        WHEN tel.PRIX > 49 AND tel.PRIX < 300 THEN 'PRIX MOYEN'
    END AS type_PRIX  
FROM telephone AS tel
INNER JOIN type_tel AS type
  ON tel.type_id   = type.idType
INNER JOIN  marque_tel AS marq
  ON tel.marque_id = marq.idMarque;






-- 3

DROP TABLE IF EXISTS offre;
CREATE TABLE offre (
id_offre  INT  AUTO_INCREMENT
, article_offre VARCHAR(255)
, ville VARCHAR(255)
, location POINT
, PRIMARY KEY (id_offre)
);

INSERT INTO offre VALUES (null, 'article1', 'Belfort, Fr', ST_GEOMFROMTEXT('POINT(6.862100 47.638770)'));
INSERT INTO offre VALUES (null, 'article2', 'Besancon, Fr', ST_GeomFromText('POINT(6.025530 47.241268)'));
INSERT INTO offre VALUES (null, 'article3', 'Poitiers', ST_GeomFromText('POINT(0.340196 46.580260)'));
INSERT INTO offre VALUES (null, 'article4', 'Montpellier', ST_GeomFromText('POINT(3.876734 43.611242)'));

SELECT *
FROM offre;


SELECT ST_DISTANCE_SPHERE( ST_GEOMFROMTEXT('POINT(6.862100 47.638770)'),offre.location ) as dist
, CONCAT('distance entre BELFORT et ',offre.ville) as desc_
FROM offre;

SELECT
ROUND( ST_DISTANCE_SPHERE( ST_GEOMFROMTEXT('POINT(6.862100 47.638770)'),offre.location )/1000, 1) as dist
, CONCAT('distance entre BELFORT et ',offre.ville) as desc_
FROM offre; 


SET @distance_max=100;
SET @ma_localisation=ST_GEOMFROMTEXT('POINT(6.862100 47.638770)');

SELECT
ROUND( ST_DISTANCE_SPHERE( @ma_localisation,offre.location )/1000)
, CONCAT('distance entre BELFORT et ',offre.ville)
FROM offre;

SELECT *
FROM offre
WHERE ROUND( ST_DISTANCE_SPHERE( @ma_localisation ,offre.location )/1000) < @distance_max;



DROP TABLE IF EXISTS article;
CREATE TABLE article (
id_article  INT  AUTO_INCREMENT
, nom VARCHAR(255)
, description_courte TEXT          -- 65,535 characters
, description_longue MEDIUMTEXT    --  16,777,215 characters 
, PRIMARY KEY (id_article)
, FULLTEXT ft_nom_desc_c_desc_long (nom, description_courte, description_longue)
);


INSERT INTO article VALUES (null, 'article1'
, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. '
, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum.');

INSERT INTO article VALUES (null, 'article2 but'
, 'Lorem ipsum dolor sit amet, but consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et dolore but magna aliqua. but 3'
, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et but  dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo
consequat. but Duis aute irure dolor in reprehenderit in but voluptate velit esse
cillum dolore eu fugiat nulla pariatur. but Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum. but 5');

INSERT INTO article VALUES (null, 'article1 info'
, 'Lorem ipsum dolor info sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut labore et info  dolore magna aliqua. info 3'
, 'Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut info labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco laboris nisi info ut aliquip ex ea commodo
consequat. Duis aute irure dolor info in reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. info Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum. info 5');

INSERT INTO article VALUES (null, 'article1 but info'
, 'Lorem ipsum dolor but info sit amet, consectetur adipisicing elit, but info sed do eiusmod
tempor incididunt ut labore but info et dolore magna aliqua. '
, 'Lorem ipsum dolor but info sit amet, consectetur adipisicing elit, sed do eiusmod
tempor incididunt ut but info labore et dolore magna aliqua. Ut enim ad minim veniam,
quis nostrud exercitation ullamco but info laboris nisi ut aliquip ex ea commodo
consequat. Duis aute irure dolor in but info reprehenderit in voluptate velit esse
cillum dolore eu fugiat nulla pariatur. but info Excepteur sint occaecat cupidatat non
proident, sunt in culpa qui officia deserunt mollit anim id est laborum. but info 5');



SELECT *
FROM article;

SHOW CREATE TABLE article; 


ALTER TABLE article ADD FULLTEXT ft_nom (nom);
ALTER TABLE article ADD FULLTEXT ft_description_courte (description_courte);
ALTER TABLE article ADD FULLTEXT ft_description_longue (description_longue);

SHOW CREATE TABLE article; 


SELECT
nom,
MATCH(nom) AGAINST('info')  AS  score_nom,
MATCH(description_courte) AGAINST('info') AS score_description_courte,
MATCH(description_longue) AGAINST('info') AS score_description_longue
FROM article;


SELECT
nom,
MATCH(nom) AGAINST('but info')  AS  score_nom,
MATCH(description_courte) AGAINST('but info') AS score_description_courte,
MATCH(description_longue) AGAINST('but info') AS score_description_longue
FROM article;




SET @recherche_texte='but info';
SELECT
nom,
MATCH(nom) AGAINST(@recherche_texte)  AS  score_nom ,
MATCH(description_courte) AGAINST(@recherche_texte) AS score_description_courte ,
MATCH(description_longue) AGAINST(@recherche_texte) AS score_description_longue , 
MATCH(nom) AGAINST(@recherche_texte) * 1
+ MATCH(description_courte) AGAINST(@recherche_texte) * 0.5
+ MATCH(description_longue) AGAINST(@recherche_texte) * 0.1 AS calcul_score
FROM article
WHERE
MATCH(nom) AGAINST(@recherche_texte) OR
MATCH(description_courte) AGAINST(@recherche_texte) OR
MATCH(description_longue) AGAINST(@recherche_texte)
ORDER BY (score_nom+score_description_courte*0.5+score_description_longue*0.1) DESC;


SELECT nom 
FROM article 
WHERE 
MATCH (description_courte)
AGAINST ('+info -but' IN BOOLEAN MODE);

SELECT nom , description_courte
FROM article 
WHERE 
MATCH (description_courte)
AGAINST ('inf*' IN BOOLEAN MODE);

SELECT nom , description_courte
FROM article 
WHERE 
MATCH (description_courte)
AGAINST ('info' WITH QUERY EXPANSION);