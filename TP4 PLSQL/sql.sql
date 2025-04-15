-- Création de la table utilisateurs
DROP TABLE IF EXISTS utilisateurs;
CREATE TABLE utilisateurs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(50),
    prenom VARCHAR(50),
    age INT,
    majeur INT
);

DROP PROCEDURE IF EXISTS AjouterUtilisateur;  
-- Création de la procédure stockée
DELIMITER //
CREATE PROCEDURE AjouterUtilisateur(IN nom_utilisateur VARCHAR(50), IN prenom_utilisateur VARCHAR(50), IN age_utilisateur INT)
BEGIN
    INSERT INTO utilisateurs (nom, prenom, age) 
    VALUES (UPPER(nom_utilisateur), LOWER(prenom_utilisateur), age_utilisateur);
END //
DELIMITER ;

-- Appel de la procédure
CALL AjouterUtilisateur('John', 'Doe', 25);
CALL AjouterUtilisateur('Jane', 'Doe', 30);

-- Affichage du contenu de la table utilisateurs
SELECT * FROM utilisateurs;







-- Création de la fonction
DELIMITER //
CREATE FUNCTION CalculerMoyenne(a NUMERIC(19,4), b NUMERIC(19,4))
RETURNS NUMERIC(19,4)
BEGIN
    DECLARE moyenne NUMERIC(19,4);
    SET moyenne = (a + b) / 2;
    RETURN moyenne;
END //
DELIMITER ;

-- Utilisation de la fonction
SELECT CalculerMoyenne(10, 20) AS MoyenneSet1;
SELECT CalculerMoyenne(5, 16.3333) AS MoyenneSet2;

SELECT ROUTINE_NAME, ROUTINE_TYPE   
FROM information_schema.routines;

DROP FUNCTION IF EXISTS CalculerMoyenne;





DROP PROCEDURE IF EXISTS MiseAJourAge; 
-- Création de la procédure
DELIMITER //
CREATE PROCEDURE MiseAJourAge(IN id_utilisateur INT, IN age_utilisateur INT)
BEGIN
    IF age_utilisateur >= 18 THEN
        SELECT 'Majeur' AS Statut;
        UPDATE utilisateurs 
        SET majeur = 1, age = age_utilisateur
        WHERE id = id_utilisateur;
    ELSE
        SELECT 'Mineur' AS Statut;
        UPDATE utilisateurs 
        SET majeur = 0, age = age_utilisateur
        WHERE id = id_utilisateur;
    END IF;
END //
DELIMITER ;


-- Appel de la procédure
CALL MiseAJourAge(1, 20);
CALL MiseAJourAge(2, 15);

SELECT * FROM utilisateurs;







-- Création de la table historique_utilisateurs
DROP TABLE IF EXISTS historique_utilisateurs;
CREATE TABLE historique_utilisateurs (
    id_utilisateur INT AUTO_INCREMENT PRIMARY KEY,
    nom_utilisateur VARCHAR(50),
    action VARCHAR(50),
    date_action TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

DROP TRIGGER IF EXISTS  after_insert_utilisateur; 
-- Création du déclencheur
DELIMITER //
CREATE TRIGGER after_insert_utilisateur
AFTER INSERT ON utilisateurs
FOR EACH ROW
BEGIN
    INSERT INTO historique_utilisateurs (id_utilisateur, nom_utilisateur, action)
    VALUES (NEW.id, NEW.nom, 'Ajout');
END //
DELIMITER ;

DROP TRIGGER IF EXISTS  before_insert_utilisateur; 
-- Création du déclencheur
DELIMITER //
CREATE TRIGGER before_insert_utilisateur
BEFORE INSERT ON utilisateurs
FOR EACH ROW
BEGIN
    SET NEW.nom = UPPER(NEW.nom),
        NEW.prenom = LOWER(NEW.prenom);
END //
DELIMITER ;

-- Ajout d'un utilisateur pour déclencher le déclencheur
INSERT INTO utilisateurs (nom, age) VALUES ('lionel', 28);

-- Affichage du contenu de la table historique_utilisateurs
SELECT * FROM historique_utilisateurs;
SELECT * FROM utilisateurs;






DROP PROCEDURE IF EXISTS AfficherUtilisateurs ;
DELIMITER //
CREATE PROCEDURE AfficherUtilisateurs()
BEGIN
    DECLARE v_id INT;
    DECLARE v_nom VARCHAR(50);
    DECLARE v_age INT;
    DECLARE v_majeur INT;
    DECLARE v_utilisateur VARCHAR(255);
    DECLARE fin INT DEFAULT 0;
    DECLARE curs_utilisateur CURSOR FOR SELECT id,nom,age, majeur FROM utilisateurs;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET fin = 1;

    OPEN curs_utilisateur;
    FETCH curs_utilisateur INTO v_id,v_nom,v_age,v_majeur;
    WHILE (fin<>1) DO
        SET v_age = v_age + 1;
        SET v_utilisateur=CONCAT(
            v_id, ' ; ', 
            IFNULL(v_nom, ' '), ' ; ',
            IFNULL(v_age, ' '), ' ; ',
            IFNULL(v_majeur, ' '));
        SELECT v_utilisateur;
        FETCH curs_utilisateur INTO v_id,v_nom,v_age,v_majeur;
    END WHILE;
    CLOSE curs_utilisateur;
END //
DELIMITER ;

CALL AfficherUtilisateurs();