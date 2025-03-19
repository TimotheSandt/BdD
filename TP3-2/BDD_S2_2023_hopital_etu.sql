DROP TABLE IF EXISTS  hospitalisation,acte;
DROP TABLE IF EXISTS salle;
DROP TABLE IF EXISTS infirmier;
DROP TABLE IF EXISTS medecin;
DROP TABLE IF EXISTS patient;
DROP TABLE IF EXISTS service ;
DROP TABLE IF EXISTS type_acte;

CREATE TABLE patient(
   id_patient INT AUTO_INCREMENT,
   nom VARCHAR(50),
   adresse VARCHAR(50),
   mutuelle VARCHAR(50),
   PRIMARY KEY(id_patient)
);

CREATE TABLE service(
   id_service INT AUTO_INCREMENT,
   nom VARCHAR(50),
   batiment VARCHAR(50),
   PRIMARY KEY(id_service)
);
CREATE TABLE medecin(
   id_medecin INT AUTO_INCREMENT,
   nom VARCHAR(50),
   specialite VARCHAR(50),
   id_service INT,
   reponsable boolean,
   PRIMARY KEY(id_medecin),
   FOREIGN KEY (id_service) REFERENCES service(id_service)
);



CREATE TABLE infirmier(
   id_infirmier INT AUTO_INCREMENT,
   nom VARCHAR(50),
   telephone VARCHAR(50),
   id_service INT,
   PRIMARY KEY(id_infirmier),
   FOREIGN KEY(id_service) REFERENCES service(id_service)
);

CREATE TABLE salle(
   id_salle INT AUTO_INCREMENT,
   nb_lits VARCHAR(50),
   id_service INT NOT NULL,
   id_infirmier INT NOT NULL,
   PRIMARY KEY(id_salle),
   FOREIGN KEY(id_service) REFERENCES service(id_service),
   FOREIGN KEY(id_infirmier) REFERENCES infirmier(id_infirmier)
);



CREATE TABLE type_acte(
   id_type_acte INT AUTO_INCREMENT,
   libelle VARCHAR(255),
   cout NUMERIC(19,4),
   PRIMARY KEY(id_type_acte)
);

CREATE TABLE acte(
   id_patient INT,
   id_medecin INT,
   date_acte DATE,
   description TEXT,
   id_type_acte INT,
   PRIMARY KEY(id_patient, id_medecin, date_acte),
   FOREIGN KEY(id_patient) REFERENCES patient(id_patient),
   FOREIGN KEY(id_medecin) REFERENCES medecin(id_medecin),
   FOREIGN KEY (id_type_acte) REFERENCES type_acte(id_type_acte)
);

CREATE TABLE hospitalisation (
   id_service INT,
   id_salle INT,
   id_patient INT,
   date_entree DATE,
   date_sortie DATE,
   PRIMARY KEY (id_service, id_salle, id_patient, date_entree),
   CONSTRAINT fk_service_hospitalisation
      FOREIGN KEY (id_service) REFERENCES service(id_service),
   CONSTRAINT fk_salle_hospitalisation
      FOREIGN KEY (id_salle) REFERENCES salle(id_salle),
   CONSTRAINT fk_patient_hospitalisation
      FOREIGN KEY (id_patient) REFERENCES patient(id_patient)
);


INSERT INTO service VALUES
(1,'ophtalmologie','batiment1'),
(2,'cardiologie','batiment2'),
(3,'gérontologie','batiment3')
;

INSERT INTO medecin VALUES
(1,'medecin1','ophtalmologue', 1 , 0),
(2,'medecin2','ophtalmologue', 1 , 1),
(3,'medecin3','gérontologue',3,0),
(4,'medecin4','cardiologue',2,0),
(5,'medecin5','cardiologue',2,1),
(6,'medecin6','gérontologue',3,1),
(7,'medecin7','ophtalmologue',1,0);



INSERT INTO infirmier VALUES
(1,'infirmier1','0605030301',1),
(2,'infirmier2','0605030302',1),
(3,'infirmier3','0605030303',2),
(4,'infirmier4','0605030304',2),
(5,'infirmier5','0605030305',3),
(6,'infirmier6','0605030306',3),
(7,'infirmier7','0605030307',1);


INSERT INTO salle(id_salle, nb_lits, id_service, id_infirmier) VALUES
(1,3,1,1),
(2,3,1,2),
(3,3,1,3),
(4,2,2,4),
(5,2,2,5),
(6,2,2,6),
(7,3,3,7),
(8,3,3,6),
(9,3,3,5)
;

INSERT INTO patient VALUES
(1,'patient1','adressepatient1','MAAF'),
(2,'patient2','adressepatient2','MAAF'),
(3,'patient3','adressepatient3','MGEN'),
(4,'patient4','adressepatient4','MGEN'),
(5,'patient5','adressepatient5','APRIL'),
(6,'patient6','adressepatient6','MMA'),
(7,'patient7','adressepatient7','MMA');


INSERT INTO hospitalisation(id_service, id_salle, id_patient, date_entree, date_sortie)
 VALUES
(1,1,1, '2022-01-01', '2022-02-01'),
(1,1,2, '2022-01-1', '2022-02-01'),
(1,2,3, '2022-01-1', '2022-02-01'),
(1,3,4, '2022-01-01', '2022-02-01'),
(1,3,5, '2022-1-01', '2023-02-01'),
(1,3,6, '2022-1-01', '2022-12-31');

INSERT INTO hospitalisation(id_service, id_salle, id_patient, date_entree, date_sortie)
 VALUES
(1,1,1, '2022-12-01', '2022-12-31'),
(1,1,2, '2022-12-01', '2022-12-31')
;

INSERT INTO hospitalisation(id_service, id_salle, id_patient, date_entree, date_sortie)
 VALUES
(1,1,3, '2022-12-01', '2022-12-31'),
(1,1,4, '2022-12-01', '2022-12-31')
;


INSERT INTO hospitalisation(id_service, id_salle, id_patient, date_entree, date_sortie)
 VALUES
(1,1,2, '2022-10-15', '2022-10-01')
;

INSERT INTO type_acte(id_type_acte, libelle, cout)
VALUES
(1, 'typeacte1', 1000),
(2, 'typeacte2', 1100),
(3, 'typeacte3', 1200);


INSERT INTO acte(id_patient, id_medecin, date_acte, description, id_type_acte)
VALUES
(1,1,'2022-01-2','acte1',1),
(1,2,'2022-01-3','acte2',1);
INSERT INTO acte(id_patient, id_medecin, date_acte, description, id_type_acte)
VALUES
(3,1,'2022-01-22','acte3',2),
(4,2,'2022-01-4','acte4',2)
;
INSERT INTO acte(id_patient, id_medecin, date_acte, description, id_type_acte)
VALUES
(1,3,'2022-01-23','acte5',3);
--
INSERT INTO acte(id_patient, id_medecin, date_acte, description, id_type_acte)
VALUES
(3,2,'2022-12-22','acte6',2),
(4,2,'2022-12-4','acte7',2)
;

INSERT INTO acte(id_patient, id_medecin, date_acte, description, id_type_acte)
VALUES
(3,2,'2022-12-23','acte8',2),
(4,2,'2022-12-5','acte9',2)
;

INSERT INTO acte(id_patient, id_medecin, date_acte, description, id_type_acte)
VALUES
(4,2,'2022-12-9','acte10',2)
;

-- R1

-- +---------------------+
-- | medecins_avec_actes |
-- +---------------------+
-- |                   3 |
-- +---------------------+

SELECT COUNT(DISTINCT id_medecin) AS medecins_avec_actes
FROM acte;

-- R2

-- remplacer "genycologie" par "ophtalmologie"

-- +---------------------+
-- | nbr_hospitalisation |
-- +---------------------+
-- |                   6 |
-- +---------------------+

SELECT COUNT(DISTINCT id_patient) AS nbr_hospitalisation
FROM hospitalisation
JOIN service ON hospitalisation.id_service = service.id_service
WHERE service.nom = "ophtalmologie"
GROUP BY service.nom;

-- R3

-- +-------------+---------------+
-- | nbr_medecin | nom           |
-- +-------------+---------------+
-- |           3 | ophtalmologie |
-- +-------------+---------------+

SELECT COUNT(DISTINCT id_medecin) as nbr_medecin, service.nom as nom
FROM medecin
JOIN service ON medecin.id_service = service.id_service
GROUP BY service.nom
HAVING nbr_medecin > 2
ORDER BY service.nom DESC;

-- R4

-- +----------+
-- | nom      |
-- +----------+
-- | medecin5 |
-- | medecin6 |
-- +----------+

SELECT nom
FROM medecin
WHERE id_medecin NOT IN (
   SELECT id_medecin
   FROM acte
   WHERE date_acte LIKE "2022%"
) AND reponsable = 1;

-- R5

-- remplacer  'appendicite' par 'typeacte2' 

-- +-----------+
-- | libelle   |
-- +-----------+
-- | typeacte3 |
-- +-----------+


-- R6

-- +-----------------+
-- | nbre_infirmiers |
-- +-----------------+
-- |               3 |
-- +-----------------+

--  remplacer 'durand' par 'medecin2' =

-- R7

-- +-----------+------------+
-- | libelle   | nb_dif_med |
-- +-----------+------------+
-- | typeacte1 |          2 |
-- | typeacte2 |          2 |
-- +-----------+------------+



-- R8


-- +----------+------------+
-- | nom      | id_patient |
-- +----------+------------+
-- | patient1 |          1 |
-- | patient3 |          3 |
-- | patient4 |          4 |
-- +----------+------------+



-- R9

-- +----------+
-- | nom      |
-- +----------+
-- | medecin2 |
-- +----------+


