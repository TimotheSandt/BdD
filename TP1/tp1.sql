/*
mysqldump --user=tsandt --password=34mopGr --host=localhost --no-tablespaces BDD_S2 CLIENT ARTICLE COMMANDE LIGNE > backup_tp1_$(date +%Y-%m-%d-%H.%M.%S).sql
OU
mysql-dump BDD_S2 CLIENT ARTICLE COMMANDE LIGNE > backup_tp1_$(date +%Y-%m-%d-%H.%M.%S).sql
*/

DROP TABLE IF EXISTS LIGNE;
DROP TABLE IF EXISTS COMMANDE;
DROP TABLE IF EXISTS ARTICLE;
DROP TABLE IF EXISTS CLIENT;

CREATE TABLE CLIENT (
    idClient INT AUTO_INCREMENT,
    nom VARCHAR(255),
    ville VARCHAR(255),
    PRIMARY KEY (idClient)
) CHARACTER SET 'utf8' ;

CREATE TABLE ARTICLE (
    idArticle INT AUTO_INCREMENT,
    designation VARCHAR(255),
    prix DECIMAL(10, 2),
    PRIMARY KEY (idArticle)
) CHARACTER SET 'utf8' ;

CREATE TABLE COMMANDE (
    idCommande INT AUTO_INCREMENT,
    dateCommande DATE,
    idClient INT,
    PRIMARY KEY (idCommande),
    CONSTRAINT fk_commande_client
        FOREIGN KEY (idClient) REFERENCES CLIENT(idClient)
) CHARACTER SET 'utf8' ;

CREATE TABLE LIGNE (
    idCommande INT,
    idArticle INT,
    quantite INT,
    PRIMARY KEY (idCommande, idArticle),
    CONSTRAINT fk_ligne_commande
        FOREIGN KEY (idCommande) REFERENCES COMMANDE(idCommande),
    CONSTRAINT fk_ligne_article
        FOREIGN KEY (idArticle) REFERENCES ARTICLE(idArticle)
) CHARACTER SET 'utf8' ;

LOAD DATA LOCAL INFILE 'CLIENT.csv' INTO TABLE CLIENT 
    CHARACTER SET utf8 FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'ARTICLE.csv' INTO TABLE ARTICLE 
    CHARACTER SET utf8 FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'COMMANDE.csv' INTO TABLE COMMANDE 
    CHARACTER SET utf8 FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'LIGNE.csv' INTO TABLE LIGNE 
    CHARACTER SET utf8 FIELDS TERMINATED BY ',';



/*
ALTER TABLE COMMANDE DROP FOREIGN KEY fk_commande_client;
ALTER TABLE LIGNE DROP FOREIGN KEY fk_ligne_commande;
ALTER TABLE LIGNE DROP FOREIGN KEY fk_ligne_article;

ALTER TABLE COMMANDE ADD CONSTRAINT fk_commande_client
    FOREIGN KEY (idClient) REFERENCES CLIENT(idClient) ON DELETE CASCADE;
ALTER TABLE LIGNE ADD CONSTRAINT fk_ligne_commande
    FOREIGN KEY (idCommande) REFERENCES COMMANDE(idCommande) ON DELETE CASCADE;
ALTER TABLE LIGNE ADD CONSTRAINT fk_ligne_article
    FOREIGN KEY (idArticle) REFERENCES ARTICLE(idArticle) ON DELETE CASCADE;

SHOW CREATE TABLE CLIENT;
SHOW CREATE TABLE ARTICLE;
SHOW CREATE TABLE COMMANDE;
SHOW CREATE TABLE LIGNE;


DELETE FROM CLIENT
WHERE CLIENT.nom = 'Mutz';
*/

-- R1
SELECT nom FROM CLIENT
WHERE ville = 'Belfort'
AND (nom LIKE 'm%' OR nom LIKE 'M%' OR
     nom LIKE 'e%' OR nom LIKE 'E%' OR
     nom LIKE 'd%' OR nom LIKE 'D%')
ORDER BY nom;


-- R2
SELECT designation, prix FROM ARTICLE
WHERE prix BETWEEN 6 AND 10 
    AND designation LIKE '%lég%'
ORDER BY designation;


-- R3
SELECT CLIENT.nom, COMMANDE.dateCommande
FROM COMMANDE
JOIN CLIENT ON COMMANDE.idClient = CLIENT.idClient
WHERE CLIENT.nom = "Mutz";


-- R4
SELECT CLIENT.nom, ARTICLE.designation, ARTICLE.prix, LIGNE.quantite, LIGNE.idCommande
FROM LIGNE
JOIN COMMANDE ON LIGNE.idCommande = COMMANDE.idCommande
JOIN CLIENT ON COMMANDE.idClient = CLIENT.idClient
JOIN ARTICLE ON LIGNE.idArticle = ARTICLE.idArticle
WHERE CLIENT.nom = "Mutz";


-- R5
SELECT CLIENT.nom, ARTICLE.designation, LIGNE.idCommande, ARTICLE.prix * LIGNE.quantite AS prix_total
FROM LIGNE
JOIN COMMANDE ON LIGNE.idCommande = COMMANDE.idCommande
JOIN CLIENT ON COMMANDE.idClient = CLIENT.idClient
JOIN ARTICLE ON LIGNE.idArticle = ARTICLE.idArticle
WHERE CLIENT.nom = "Mutz"
ORDER BY prix_total DESC;


-- R6
SELECT CLIENT.nom, LIGNE.idCommande, SUM(ARTICLE.prix * LIGNE.quantite) AS prix_total
FROM LIGNE
JOIN COMMANDE ON LIGNE.idCommande = COMMANDE.idCommande
JOIN CLIENT ON COMMANDE.idClient = CLIENT.idClient
JOIN ARTICLE ON LIGNE.idArticle = ARTICLE.idArticle
WHERE CLIENT.nom = "Mutz"
GROUP BY LIGNE.idCommande, CLIENT.nom
ORDER BY prix_total DESC;


-- R7
SELECT CLIENT.nom, LIGNE.idCommande, SUM(ARTICLE.prix * LIGNE.quantite) AS prix_total_HT, SUM(ARTICLE.prix * LIGNE.quantite) * 0.2 AS TVA, SUM(ARTICLE.prix * LIGNE.quantite) * 1.2 AS prix_total_TTC
FROM LIGNE
JOIN COMMANDE ON LIGNE.idCommande = COMMANDE.idCommande
JOIN CLIENT ON COMMANDE.idClient = CLIENT.idClient
JOIN ARTICLE ON LIGNE.idArticle = ARTICLE.idArticle
GROUP BY LIGNE.idCommande, CLIENT.nom
ORDER BY prix_total_HT;


-- R8
SELECT ARTICLE.designation, LIGNE.quantite, YEAR(COMMANDE.dateCommande) AS anneeCommande, COMMANDE.idCommande
FROM LIGNE
RIGHT JOIN ARTICLE ON LIGNE.idArticle = ARTICLE.idArticle
LEFT JOIN COMMANDE ON LIGNE.idCommande = COMMANDE.idCommande
ORDER BY ARTICLE.designation, COMMANDE.dateCommande DESC, LIGNE.quantite DESC, COMMANDE.idCommande;


-- R9
SELECT ARTICLE.designation, LIGNE.quantite, YEAR(COMMANDE.dateCommande) AS anneeCommande, COMMANDE.idCommande
FROM LIGNE
JOIN ARTICLE ON LIGNE.idArticle = ARTICLE.idArticle
JOIN COMMANDE ON LIGNE.idCommande = COMMANDE.idCommande
WHERE YEAR(COMMANDE.dateCommande) = 2023
    AND ARTICLE.designation IN 
        (SELECT ARTICLE.designation FROM LIGNE
         JOIN ARTICLE ON LIGNE.idArticle = ARTICLE.idArticle
         JOIN COMMANDE ON LIGNE.idCommande = COMMANDE.idCommande
         WHERE YEAR(COMMANDE.dateCommande) = 2024);


-- R10
SELECT CLIENT.nom, COUNT(COMMANDE.idCommande) AS nbCommandes, coalesce(YEAR(COMMANDE.dateCommande), 0) AS anneeCommande
FROM COMMANDE
RIGHT JOIN CLIENT ON COMMANDE.idClient = CLIENT.idClient
GROUP BY CLIENT.nom, anneeCommande
ORDER BY nbCommandes DESC, CLIENT.nom;

SELECT CLIENT.nom, COUNT(COMMANDE.idCommande) AS nbCommandes, ifnull(YEAR(COMMANDE.dateCommande), "pas de commande") AS anneeCommande
FROM COMMANDE
RIGHT JOIN CLIENT ON COMMANDE.idClient = CLIENT.idClient
GROUP BY CLIENT.nom, anneeCommande
ORDER BY nbCommandes DESC, CLIENT.nom;