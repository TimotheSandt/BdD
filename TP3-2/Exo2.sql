DROP TABLE IF EXISTS PanierArticle;
DROP TABLE IF EXISTS LigneCommande;
DROP TABLE IF EXISTS Commande;
DROP TABLE IF EXISTS Client;
DROP TABLE IF EXISTS Article;

CREATE TABLE Article (
    idArticle INT AUTO_INCREMENT,
    designation VARCHAR(255),
    prix DECIMAL(10,2),
    PRIMARY KEY (idArticle)
) CHARACTER SET 'utf8';

CREATE TABLE Client (
    idClient INT AUTO_INCREMENT,
    nom VARCHAR(255),
    ville VARCHAR(255),
    PRIMARY KEY (idClient)
) CHARACTER SET 'utf8';

CREATE TABLE Commande (
    idCommande INT AUTO_INCREMENT,
    dateCommande DATE,
    idClient INT,
    PRIMARY KEY (idCommande)
    -- CONSTRAINT fk_commande_client
    --     FOREIGN KEY (idClient) REFERENCES Client(idClient)
) CHARACTER SET 'utf8';

CREATE TABLE LigneCommande (
    idCommande INT,
    idArticle INT,
    quantite INT,
    PRIMARY KEY (idCommande, idArticle)
    -- CONSTRAINT fk_ligne_commande
    --     FOREIGN KEY (idCommande) REFERENCES Commande(idCommande),
    -- CONSTRAINT fk_ligne_article
    --     FOREIGN KEY (idArticle) REFERENCES Article(idArticle)
) CHARACTER SET 'utf8';

CREATE TABLE PanierArticle (
    idClient INT,
    idArticle INT,
    quantite INT,
    PRIMARY KEY (idClient, idArticle)
    -- CONSTRAINT fk_panier_client
    --     FOREIGN KEY (idClient) REFERENCES Client(idClient),
    -- CONSTRAINT fk_panier_article
    --     FOREIGN KEY (idArticle) REFERENCES Article(idArticle)
) CHARACTER SET 'utf8';



INSERT INTO PanierArticle (idClient, idArticle, quantite) VALUES
(3, 11, 3),
(3, 16, 5),
(4, 19, 7);






START TRANSACTION;

SET @IdClient = 3;

INSERT INTO Commande (dateCommande, idClient) VALUES
(DATE(NOW()), @IdClient);

SELECT @NewIdCommande := MAX(idCommande) FROM Commande WHERE idClient = @IdClient;

INSERT INTO LigneCommande (idCommande, idArticle, quantite)
SELECT @NewIdCommande, idArticle, quantite FROM PanierArticle WHERE idClient = @IdClient;

COMMIT;
