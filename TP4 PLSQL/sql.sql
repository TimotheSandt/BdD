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


