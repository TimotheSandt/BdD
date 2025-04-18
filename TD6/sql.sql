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
