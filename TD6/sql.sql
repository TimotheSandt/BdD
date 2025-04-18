DROP TABLE IF EXISTS Client;

CREATE TABLE Client (
    id_client INTEGER  NOT NULL,
    nom varchar(30)  NOT NULL,
    nb_places_reservees INTEGER  NOT NULL,
    solde INTEGER  NOT NULL,
    PRIMARY KEY (id_client)
);

INSERT into Client VALUES (1, 'Philippe', 0, 2000);
INSERT into Client VALUES (2, 'Julie', 0, 350);
INSERT into Client VALUES (3, 'alex', 0, 350); 





SELECT @@autocommit;
UPDATE Client SET nom="ALEXANDRE" WHERE id_client=3;



SET autocommit=0;  -- Les "COMMIT" ne sont plus automatiques

SELECT * FROM Client WHERE id_client=3;

START TRANSACTION;
UPDATE Client SET nom="alex1" WHERE id_client=3;
SELECT * FROM Client WHERE id_client=3;

ROLLBACK;
SELECT * FROM Client WHERE id_client=3;

UPDATE Client SET nom="alex2" WHERE id_client=3;
SELECT * FROM Client WHERE id_client=3;

-- se connecter depuis un autre terminal sur cette base de données (nouvelle session) ; qu'elle est la valeur du champ nom ?

COMMIT;
SELECT * FROM Client WHERE id_client=3;

ROLLBACK;
SELECT * FROM Client WHERE id_client=3;




SELECT @@autocommit;
SELECT * FROM Client WHERE id_client=3;
UPDATE Client SET nom="alex ***** 1" WHERE id_client=3;
SELECT * FROM Client WHERE id_client=3;




DROP TABLE IF EXISTS Spectacle, Journal;


CREATE TABLE Spectacle (
    id_spectacle INTEGER  NOT NULL,
    titre VARCHAR(30)  NOT NULL,
    nb_places_offertes INTEGER  NOT NULL CHECK(nb_places_offertes>=0),
    nb_places_libres INTEGER  NOT NULL CHECK(nb_places_libres>=0),
    tarif DECIMAL(10,2)  NOT NULL,
    PRIMARY KEY (id_spectacle)
);

CREATE TABLE Journal (
    id INTEGER  AUTO_INCREMENT,
    libelle_transaction VARCHAR(30)  NOT NULL,
    client_id INTEGER,
    nb_places INTEGER,
    spectacle_id INTEGER,
    tarif DECIMAL(19,4),
    PRIMARY KEY (id)
);

SET autocommit = 0;
DELETE FROM Client;
DELETE FROM Spectacle;

INSERT into Client VALUES (1, 'Philippe', 0, 2000);
INSERT into Client VALUES (2, 'Julie', 0, 350);

INSERT into Spectacle VALUES (1, 'Ben hur', 250, 50, 50);
INSERT into Spectacle VALUES (2, 'Tartuffe', 120, 30, 30);

COMMIT;






SET @nb_place=20;
SET @spectacle_id=1;
SET @client_id=1;

SET autocommit = 0;
START TRANSACTION;

SELECT @nb_place, @spectacle_id, @client_id;

UPDATE Spectacle 
SET nb_places_libres = nb_places_libres - @nb_place 
WHERE id_spectacle = @spectacle_id;

UPDATE Client
SET nb_places_reservees = nb_places_reservees + @nb_place
WHERE id_client = @client_id;

SELECT @prix := tarif * @nb_place
FROM Spectacle 
WHERE id_spectacle = @spectacle_id;

UPDATE Client
SET solde = solde - @prix
WHERE id_client = @client_id;

INSERT INTO Journal(libelle_transaction, client_id, nb_places, spectacle_id, tarif)
VALUES('achat', @client_id, @nb_place, @spectacle_id, @prix);



SELECT * FROM Spectacle;
SELECT * FROM Client;
SELECT * FROM Journal;

COMMIT;

SELECT * FROM Spectacle;
SELECT * FROM Client;
SELECT * FROM Journal;
