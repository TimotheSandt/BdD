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

LOAD DATA LOCAL INFILE 'CLASSEMENT.csv' INTO TABLE classement
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