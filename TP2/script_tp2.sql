DROP TABLE IF EXISTS comporte;
DROP TABLE IF EXISTS classement;
DROP TABLE IF EXISTS skieur;
DROP TABLE IF EXISTS competition;
DROP TABLE IF EXISTS station;
DROP TABLE IF EXISTS specialite;

CREATE TABLE IF NOT EXISTS specialite (
	idSpecialite INT AUTO_INCREMENT,
	libelleSpecialite VARCHAR(255),
    PRIMARY KEY (idSpecialite)
);

CREATE TABLE IF NOT EXISTS station (
	idStation INT AUTO_INCREMENT,
	nomStation VARCHAR(255),
	altitude INT,
	pays VARCHAR(255),
    PRIMARY KEY (idStation)
);

CREATE TABLE IF NOT EXISTS competition (
	idCompetition INT AUTO_INCREMENT,
	libelleCompet VARCHAR(255),
	dateComp DATE,
	idStation INT,
    PRIMARY KEY (idCompetition),
	FOREIGN KEY (idStation) REFERENCES station(idStation)
);

CREATE TABLE IF NOT EXISTS skieur (
	idSkieur INT AUTO_INCREMENT,
	nomSkieur VARCHAR(255),
	idSpecialite INT,
	idStation INT,
    PRIMARY KEY (idSkieur),
	FOREIGN KEY (idSpecialite) REFERENCES specialite(idSpecialite),
	FOREIGN KEY (idStation) REFERENCES station(idStation)
);

CREATE TABLE IF NOT EXISTS classement (
	idSkieur INT,
	idCompetition INT,
	classement INT,
	FOREIGN KEY (idSkieur) REFERENCES skieur(idSkieur),
	FOREIGN KEY (idCompetition) REFERENCES competition(idCompetition)
);

CREATE TABLE IF NOT EXISTS comporte (
	idCompetition INT,
	idSpecialite INT,
    PRIMARY KEY (idCompetition, idSpecialite),
	FOREIGN KEY (idCompetition) REFERENCES competition(idCompetition),
	FOREIGN KEY (idSpecialite) REFERENCES specialite(idSpecialite)
);


LOAD DATA LOCAL INFILE 'SPECIALITE.csv' INTO TABLE specialite
    CHARACTER SET utf8 FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'STATION.csv' INTO TABLE station
    CHARACTER SET utf8 FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'COMPETITION.csv' INTO TABLE competition
    CHARACTER SET utf8 FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'SKIEUR.csv' INTO TABLE skieur
    CHARACTER SET utf8 FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'classement.csv' INTO TABLE classement
    CHARACTER SET utf8 FIELDS TERMINATED BY ',';

LOAD DATA LOCAL INFILE 'COMPORTE.csv' INTO TABLE comporte
    CHARACTER SET utf8 FIELDS TERMINATED BY ',';


SELECT * FROM specialite;
SELECT * FROM station;
SELECT * FROM competition;
SELECT * FROM skieur;
SELECT * FROM classement;
SELECT * FROM comporte;





-- R1
SELECT COUNT(*) AS NbreSkieurDansUneCompet
FROM skieur
WHERE idSkieur IN (
    SELECT idSkieur
    FROM classement
);

-- R2

SELECT skieur.nomSkieur, station.nomStation
FROM skieur
JOIN station ON skieur.idStation = station.idStation
ORDER BY station.nomStation, skieur.nomSkieur;

-- R3
SELECT skieur.nomSkieur, classement.classement, competition.libelleCompet
FROM classement
JOIN skieur ON classement.idSkieur = skieur.idSkieur
JOIN competition ON classement.idCompetition = competition.idCompetition
ORDER BY competition.libelleCompet, classement.classement, skieur.nomSkieur;

-- R4

SELECT competition.libelleCompet, skieur.nomSkieur
FROM classement
JOIN skieur ON classement.idSkieur = skieur.idSkieur
JOIN competition ON classement.idCompetition = competition.idCompetition
JOIN station ON competition.idStation = station.idStation
WHERE station.nomStation = "Tignes" AND classement.classement = 1;


-- R5

SELECT station.idStation, station.nomStation, COUNT(competition.libelleCompet) AS NbreSkieurDansUneCompet
FROM competition
JOIN station ON competition.idStation = station.idStation
GROUP BY station.idStation, station.nomStation
ORDER BY station.nomStation;


-- R6

SELECT skieur.idSkieur, skieur.nomSkieur, COUNT(classement.classement) AS NbreDeVictoire
FROM classement
JOIN skieur ON classement.idSkieur = skieur.idSkieur
JOIN competition ON classement.idCompetition = competition.idCompetition
JOIN station ON competition.idStation = station.idStation
WHERE station.nomStation = "Tignes" AND classement.classement = 1
GROUP BY skieur.idSkieur, skieur.nomSkieur;


-- R7



-- Supprimer le contenu des tables comportant classement et competition
DELETE FROM comporte;
DELETE FROM classement;

-- Supprimer les enregistrements dans la table competition avec TRUNCATE
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE competition;
SET FOREIGN_KEY_CHECKS = 1;

-- Insérer des enregistrements après TRUNCATE
LOAD DATA LOCAL INFILE 'COMPETITIONv2.csv' INTO TABLE competition 
    CHARACTER SET utf8 FIELDS TERMINATED BY ',';
LOAD DATA LOCAL INFILE 'classementv2.csv' INTO TABLE classement 
    CHARACTER SET utf8 FIELDS TERMINATED BY ',';
-- Insérer des enregistrements avec les fichiers CSV
LOAD DATA LOCAL INFILE 'COMPORTEv2.csv' INTO TABLE comporte 
    CHARACTER SET utf8 FIELDS TERMINATED BY ',';










-- R8
SELECT DISTINCT nomSkieur, classement.classement, stationCompet.nomStation AS lieu_compet, stationSkieur.nomStation AS club
FROM skieur
JOIN classement ON skieur.idSkieur = classement.idSkieur
JOIN competition ON classement.idCompetition = competition.idCompetition
JOIN station AS stationCompet ON competition.idStation = stationCompet.idStation
JOIN station AS stationSkieur ON skieur.idStation = stationSkieur.idStation
WHERE stationCompet.nomStation = 'Tignes' 
AND skieur.idSkieur NOT IN (
    SELECT idSkieur
    FROM classement
    WHERE classement >= 3
);
 
 
-- R9
SELECT DISTINCT nomSkieur
FROM skieur
JOIN classement ON skieur.idSkieur = classement.idSkieur
JOIN competition ON classement.idCompetition = competition.idCompetition
JOIN station AS stationCompet ON competition.idStation = stationCompet.idStation
JOIN station AS stationSkieur ON skieur.idStation = stationSkieur.idStation
WHERE stationCompet.nomStation = stationSkieur.nomStation 
AND skieur.idSkieur NOT IN (
    SELECT idSkieur
    FROM classement
    WHERE classement >= 3
);
 
 
-- R10
ALTER TABLE classement
ADD COLUMN idSpecialite INT,
ADD COLUMN temps TIME,
ADD PRIMARY KEY (idSkieur, idCompetition, idSpecialite);
 
SELECT * FROM classement;
 
 
-- R11
SELECT nomStation
FROM station
JOIN skieur ON station.idStation = skieur.idStation
GROUP BY nomStation, station.idStation
HAVING COUNT(skieur.idSkieur) >= 2;
 
 
-- R12
SELECT nomSkieur
FROM skieur
WHERE idSpecialite IN (
    SELECT idSpecialite
    FROM skieur
    WHERE nomSkieur = 'paul'
) AND NOT nomSkieur = 'paul';


-- R13

INSERT INTO skieur (nomSkieur, idStation, idSpecialite) 
VALUES ('alphand',
	(
		SELECT s.idStation
		FROM skieur s
		WHERE s.nomSkieur = 'pierre'
	),
	(
		SELECT s.idSpecialite
		FROM skieur s
		WHERE s.nomSkieur = 'paul'
	)	
);

SELECT * 
FROM skieur;


-- R14

SELECT competition.libelleCompet
FROM competition
JOIN comporte ON comporte.idCompetition = competition.idCompetition
GROUP BY competition.libelleCompet
HAVING COUNT(DISTINCT comporte.idSpecialite) > 2;

