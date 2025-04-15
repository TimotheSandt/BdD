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

