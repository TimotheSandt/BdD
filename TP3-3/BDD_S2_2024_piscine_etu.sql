DROP TABLE IF EXISTS cours;

DROP TABLE IF EXISTS emplois;
DROP TABLE IF EXISTS surveillance;
DROP TABLE IF EXISTS connexion;
DROP TABLE IF EXISTS bassin;
DROP TABLE IF EXISTS type_bassin;
DROP TABLE IF EXISTS surveillant;
DROP TABLE IF EXISTS piscine ;
DROP TABLE IF EXISTS ville;

CREATE TABLE ville(
   id_ville INT AUTO_INCREMENT,
   nom_ville VARCHAR(50),
   PRIMARY KEY(id_ville)
);

CREATE TABLE piscine(
   id_piscine INT AUTO_INCREMENT,
   nom VARCHAR(50),
   surface VARCHAR(50),
   est_publique VARCHAR(50),
   id_ville INT NOT NULL,
   PRIMARY KEY(id_piscine),
   FOREIGN KEY(id_ville) REFERENCES ville(id_ville)
);

CREATE TABLE surveillant(
   id_surveillant INT AUTO_INCREMENT,
   nom_surveillant VARCHAR(50),
   prenom VARCHAR(50),
   PRIMARY KEY(id_surveillant)
);

CREATE TABLE type_bassin(
   id_type_bassin INT AUTO_INCREMENT,
   libelle VARCHAR(50),
   PRIMARY KEY(id_type_bassin)
);

CREATE TABLE bassin(
   id_bassin INT,
   longueur DECIMAL(15,2),
   largeur DECIMAL(15,2),
   id_type_bassin INT NOT NULL,
   id_piscine INT NOT NULL,
   PRIMARY KEY(id_bassin),
   FOREIGN KEY(id_type_bassin) REFERENCES type_bassin(id_type_bassin),
   FOREIGN KEY(id_piscine) REFERENCES piscine(id_piscine)
);

CREATE TABLE connexion(
   id_bassin INT,
   id_bassin_1 INT,
   type_connexion VARCHAR(50),
   PRIMARY KEY(id_bassin, id_bassin_1),
   FOREIGN KEY(id_bassin) REFERENCES bassin(id_bassin),
   FOREIGN KEY(id_bassin_1) REFERENCES bassin(id_bassin)
);

CREATE TABLE emplois(
   id_ville INT,
   id_surveillant INT,
   date_debut DATE,
   date_fin DATE,
   salaire DECIMAL(19,4),
   PRIMARY KEY(id_ville, id_surveillant, date_debut),
   FOREIGN KEY(id_ville) REFERENCES ville(id_ville),
   FOREIGN KEY(id_surveillant) REFERENCES surveillant(id_surveillant)
);

CREATE TABLE cours(
   id_piscine INT,
   id_surveillant INT,
   date_début DATE,
   nom_cours VARCHAR(50),
   durée INT,
   PRIMARY KEY(id_piscine, id_surveillant, date_début),
   CONSTRAINT fk_cours_piscine 
      FOREIGN KEY(id_piscine) REFERENCES piscine(id_piscine),
   CONSTRAINT fk_cours_surveillant 
      FOREIGN KEY(id_surveillant) REFERENCES surveillant(id_surveillant)
);


CREATE TABLE surveillance(
   id_piscine INT,
   id_surveillant INT,
   date_debut DATE,
   date_fin DATE,
   horaires INT,
   PRIMARY KEY(id_piscine, id_surveillant, date_debut),
   FOREIGN KEY(id_piscine) REFERENCES piscine(id_piscine),
   FOREIGN KEY(id_surveillant) REFERENCES surveillant(id_surveillant)
);


INSERT INTO ville(id_ville, nom_ville) VALUES
(1,'belfort'),
(2,'montbéliard'),
(3,'lure')
;

INSERT INTO piscine(id_piscine, nom, surface, est_publique, id_ville) VALUES
(1, 'Gabriel Pannoux', 4494,1,1),
(2, 'Piscine du parc', 47428,1, 1),
(3, 'CENTRE AQUATIQUE RENÉ DONZÉ (montbéliard)', 39000,1, 2),
(4, 'la citédo', 7000,0, 2),
(5, 'nauti Lure', 6000,1, 3)
;



INSERT INTO surveillant VALUES
(1,'surveillant1','presurv1'),
(2,'surveillant2','presurv2'),
(3,'surveillant3','presurv3'),
(4,'surveillant4','presurv4'),
(5,'surveillant5','presurv5'),
(6,'surveillant6','presurv6'),
(7,'surveillant7','presurv7'),
(8,'surveillant8','presurv8'),
(9,'surveillant9','presurv9'),
(10,'surveillant10','presurv10'),
(11,'surveillant11','presurv11'),
(12,'surveillant12','presurv12'),
(13,'surveillant13','presurv13'),
(14,'surveillant14','presurv14'),
(15,'surveillant15','presurv15'),
(16,'surveillant16','presurv16'),
(17,'surveillant17','presurv17'),
(18,'surveillant18','presurv18'),
(19,'surveillant19','presurv19'),
(20,'surveillant20','presurv20'),
(21,'surveillant21','presurv21')
;

INSERT INTO type_bassin VALUES
(1,'standard'),
(2,'pour enfant'),
(3,'olympique')
;

INSERT INTO bassin(id_bassin, longueur, largeur, id_type_bassin, id_piscine) VALUES
(1,25,25,1,1),
(2,12,10,2,1),
(3,25,25,1,2),
(4,25,25,2,2),
(5,50,25,3,2),
(6,25,25,1,3),
(7,12,10,2,3),
(8,50,25,3,3),
(9,25,25,1,4),
(10,25,10,2,4),
(11,25,25,1,5)
;

INSERT INTO connexion(id_bassin, id_bassin_1, type_connexion) VALUES
(1,2,'connexion 10m carrelage'),
(3,4,'connexion 10m carrelage'),
(4,5,'connexion sur extérieure 10m carrelage'),
(6,7,'connexion 10m carrelage'),
(7,8,'connexion sur extérieure 10m carrelage'),
(9,10,'connexion 10m carrelage')
;


INSERT INTO emplois(id_ville, id_surveillant, date_debut, date_fin, salaire)
 VALUES
(1,1, '2022-09-01', '2023-09-01',1800),
(1,1, '2023-09-01', '2024-09-01',1800),
(1,2, '2021-09-01', '2022-09-01',1900),
(1,2, '2023-09-1', null ,1900),
(1,3, '2023-09-01', '2024-09-01',1800),
(1,4, '2023-09-1', null,1850),
(1,5, '2023-09-01', '2024-09-01',1800),
(1,6, '2023-09-1', null ,1850),
(1,7, '2023-09-1', '2024-09-01',1850),
(1,8, '2023-09-1', null,1850),
(1,9, '2023-09-01', '2024-09-01',1800),
(1,10, '2023-09-1', null ,1800),
(1,11, '2023-09-1', '2024-09-01',1800),
(2,12, '2023-09-1', '2024-09-01',1800),
(2,12, '2020-09-1', '2021-09-01',1355),
(2,13, '2023-09-1', null,1750),
(2,14, '2023-09-01', '2024-09-01',1800),
(2,15, '2023-09-1', null ,1850),
(2,16, '2023-09-1', '2024-09-01',1850),
(3,17, '2023-09-01', '2024-09-01',1800),
(3,18, '2023-01-1',  '2023-09-1' ,1850),
(3,18, '2023-09-1', null ,1850),
(3,19, '2023-09-1', '2024-09-01',1850)
;

INSERT INTO emplois(id_ville, id_surveillant, date_debut, date_fin, salaire)
 VALUES
(1,12, '2022-09-1', '2022-09-01',1800);
INSERT INTO cours(id_piscine, id_surveillant, date_debut, heure_debut, nom_cours, duree)
 VALUES
(1,1, '2023-10-5', '09:00:00', 'débutant', 60),
(1,1, '2023-10-5', '10:00:00', 'moyen', 60),
(1,2, '2023-10-5','14:00:00', 'débutant', 60),
(1,2, '2023-10-5', '15:00:00','avancé', 60),
(1,3, '2023-10-12','09:00:00', 'débutant', 60),
(1,4, '2023-10-12','10:00:00', 'moyen', 60),
(1,5, '2023-10-12','13:00:00', 'débutant', 60),
(1,5, '2023-10-12','14:00:00', 'avancé', 60),

(5,17, '2023-10-5', '09:00:00', 'débutant', 60),
(5,17, '2023-10-5', '10:00:00', 'moyen', 60),
(5,18, '2023-10-5','14:00:00', 'débutant', 60),
(5,18, '2023-10-5', '15:00:00','avancé', 60),
(5,19, '2023-10-12','09:00:00', 'débutant', 60)
;

INSERT INTO cours(id_piscine, id_surveillant, date_debut, heure_debut, nom_cours, duree)
 VALUES
(1,1, '2023-10-22', '09:00:00', 'débutant', 90),
(1,5, '2023-10-22','14:00:00', 'avancé', 90),             -- 10
(5,19, '2023-10-22','09:00:00', 'débutant', 90)
;

INSERT INTO cours(id_piscine, id_surveillant, date_debut, heure_debut, nom_cours, duree)
 VALUES
(1,5, '2023-10-13','13:00:00', 'débutant', 60),
(1,5, '2023-10-14','13:00:00', 'débutant', 60)
;
INSERT INTO cours(id_piscine, id_surveillant, date_debut, heure_debut, nom_cours, duree)
 VALUES
(1,5, '2023-10-15','13:00:00', 'débutant', 60),
(1,5, '2023-10-16','13:00:00', 'débutant', 60)
;
INSERT INTO cours(id_piscine, id_surveillant, date_debut, heure_debut, nom_cours, duree)
 VALUES
(1,5, '2023-10-17','13:00:00', 'débutant', 60),
(1,5, '2023-10-18','13:00:00', 'débutant', 60)
;
INSERT INTO cours(id_piscine, id_surveillant, date_debut, heure_debut, nom_cours, duree)
 VALUES
(1,5, '2023-10-17','14:00:00', 'débutant', 60),
(1,5, '2023-10-18','15:00:00', 'débutant', 60)
;


INSERT INTO cours(id_piscine, id_surveillant, date_debut, heure_debut, nom_cours, duree)
 VALUES
(1,1, '2023-11-5', '09:00:00', 'débutant', 60),
(1,1, '2023-11-5', '10:00:00', 'moyen', 60),
(1,2, '2023-11-5','14:00:00', 'débutant', 60),
(1,2, '2023-11-5', '15:00:00','avancé', 60),
(5,18, '2023-11-5','14:00:00', 'débutant', 60),
(5,18, '2023-11-5', '15:00:00','avancé', 60),
(5,19, '2023-11-12','09:00:00', 'débutant', 60)
;

INSERT INTO cours(id_piscine, id_surveillant, date_debut, heure_debut, nom_cours, duree)
 VALUES
(2,7, '2023-10-22', '09:00:00', 'trilion', 900)
;

# INSERT INTO cours(id_piscine, id_surveillant, date_debut, heure_debut, nom_cours, duree)
#  VALUES
# (2,7, '2023-10-22', '09:00:00', 'trilion', 900)
# ;

INSERT INTO cours(id_piscine, id_surveillant, date_debut, heure_debut, nom_cours, duree)
 VALUES
(1,12, '2022-10-22', '09:00:00', 'trilion', 90)
;
INSERT INTO cours(id_piscine, id_surveillant, date_debut, heure_debut, nom_cours, duree)
 VALUES
(1,12, '2023-8-22', '09:00:00', 'trilion', 90)
;



INSERT INTO surveillance(id_piscine, id_surveillant, date_debut, date_fin, horaires)
 VALUES
(1,1, '2023-12-01', '2023-12-31',9),
(1,2, '2023-12-01', '2023-12-31',13)
;


-- R1  Donner (afficher) le nombre de surveillants qui ont donné un cours durant l’année 2023.
-- (affichage : un numérique uniquement). Utiliser le minimum de table.


# +-----------------+
# | nb_surveillants |
# +-----------------+
# |              10 |
# +-----------------+

-- R2 :  Donner le nombre de surveillants employés  le 21 décembre 2023 dans la ville de "Belfort".
-- (affichage : un numérique uniquement). Faire attention, si la colonne «date_fin» n’est pas renseigné,
-- le surveillant travaille toujours sur cet emploi.



# +--------------------------------------+
# | nbr_surveillants_belfort_21_dec_2023 |
# +--------------------------------------+
# |                                   11 |
# +--------------------------------------+

-- R3 : Afficher la longueur maximale (des bassins) par piscine
-- (affichage : un numérique qui correspond à la longueur, le nom de la ville, le nom de la piscine ;
-- trier le résultat par ville croissant puis par nom de piscine croissant).


# +--------------+----------------------------------------------+-------+
# | nom_ville    | nom                                          | maxl  |
# +--------------+----------------------------------------------+-------+
# | belfort      | Gabriel Pannoux                              | 25.00 |
# | belfort      | Piscine du parc                              | 50.00 |
# | lure         | nauti Lure                                   | 25.00 |
# | montbéliard  | CENTRE AQUATIQUE RENÉ DONZÉ (montbéliard)    | 50.00 |
# | montbéliard  | la citédo                                    | 25.00 |
# +--------------+----------------------------------------------+-------+



-- R4 : Donner  le nombre de piscines dans chaque ville pour les villes où il y a plus de 2 piscines.
--   ( affichage : nom des villes, nombre de piscines, le résultat sera trié selon l’ordre lexicographique inverse sur le nom des villes ).



# +-------------+--------------+
# | nbr_piscine | nom_ville    |
# +-------------+--------------+
# |           2 | montbéliard  |
# |           2 | belfort      |
# +-------------+--------------+


-- R5 : Donner le nom des surveillants employés à belfort avant ou en 2023 qui n’ont pas donné un cours en 2023
--  (commencer par réaliser la requête qui affiche l’identifiant des surveillants ayant réalisé un cours en 2023)
--  ( affichage : nom du (des) surveillant(s), , le résultat sera trié selon l’ordre lexicographique (alphabétique) inverse ).


# +-----------------+
# | nom_surveillant |
# +-----------------+
# | surveillant9    |
# | surveillant8    |
# | surveillant6    |
# | surveillant11   |
# | surveillant10   |
# +-----------------+



-- R6 : Donner le nom du (des) surveillant(s) de belfort qui gagne(nt) plus que la moyenne des salaires des surveillants de montbéliard.
-- ( affichage : nom du (des) surveillant(s) et leur(s) salaire(s), le résultat sera trié selon l’ordre lexicographique inverse
-- du nom des surveillants). Pour ce calcul, les surveillants sont tous encore en activité si leur date de fin de contrat n’est pas
-- renseignée (CDI) ou si cette date n’est pas encore passée.


# +-----------------+--------------------------+
# | nom_surveillant | round(emplois.salaire,2) |
# +-----------------+--------------------------+
# | surveillant8    |                  1850.00 |
# | surveillant6    |                  1850.00 |
# | surveillant4    |                  1850.00 |
# | surveillant2    |                  1900.00 |
# +-----------------+--------------------------+


-- R7 : Donner le nom des piscines où il y a eu plus de 10 heures de cours au mois d’octobre 2023
-- et qui n’ont donné aucun cours en aout 2023. La durée des cours est en minutes dans la base de données.
-- Il est demandé d’essayer d’utiliser le mot clé «EXISTS» pour la sous requête.



/*+-----------------+---------------+----------------------+
| nom             | nb_cours_pisc | nb_heures_cours_pisc |
+-----------------+---------------+----------------------+
| Piscine du parc |             1 |                 15.0 |
+-----------------+---------------+----------------------+*/


-- R8 : Donner le nom du surveillant de belfort qui a donné le plus grand nombre de
-- cours à la piscine de Belfort.



+-----------------+----------+
| nom_surveillant | count(*) |
+-----------------+----------+
| surveillant5    |       11 |
+-----------------+----------+
