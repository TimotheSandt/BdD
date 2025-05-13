DROP TABLE IF EXISTS Embauche;
DROP TABLE IF EXISTS Grille_sal;
DROP TABLE IF EXISTS Projet;
DROP TABLE IF EXISTS Employe;




create table Employe(
 NumSS int AUTO_INCREMENT PRIMARY KEY, 
 NomE varchar(50) ,
 PrenomE varchar(50) , 
 VilleE varchar(50) , 
 DateNaiss date 
); 


create table Projet(
 NumProj int AUTO_INCREMENT PRIMARY KEY,
 NomProj varchar(50),
 RespProj int, 
 VilleP varchar(50), 
 Budget decimal(10,2),
 CONSTRAINT fk_projet_employe
 FOREIGN KEY (RespProj) REFERENCES Employe(NumSS)
); 

create table Grille_sal(
 profil varchar(50) PRIMARY KEY, 
 salaire decimal(7,2)
); 


create table Embauche(
 NumSS int ,
 NumProj int , 
 DateEmb date default CURRENT_TIMESTAMP, 
 Profil varchar(20),
 FOREIGN KEY (NumSS) REFERENCES Employe(NumSS),
 FOREIGN KEY (NumProj) REFERENCES Projet(NumProj),
 CONSTRAINT fk_embauche_grille_sal
    FOREIGN KEY (Profil) REFERENCES Grille_sal(profil),
 PRIMARY KEY (NumSS, NumProj)
);

insert into Employe (NumSS, NomE, PrenomE, VilleE, DateNaiss)
values 
(22334, 'Adam', 'Funk', 'Paris',            STR_TO_DATE('1-12-1982', '%d-%m-%Y')  ),
(45566, 'Rachid', 'Allaoui', 'Lyon',        STR_TO_DATE('13-4-1986', '%d-%m-%Y')  ),
(77889, 'Florent', 'Girac' , 'Marseille',   STR_TO_DATE('4-11-1990', '%d-%m-%Y')  ),
(90011, 'Mayla', 'Aoun', 'Lyon',            STR_TO_DATE('26-3-1987', '%d-%m-%Y')  ),
(22233, 'Christine', 'Lara', 'Paris',       STR_TO_DATE('9-8-1982', '%d-%m-%Y')  ),
(34445, 'Amel', 'Orlando', 'Lyon',          STR_TO_DATE('14-2-1976', '%d-%m-%Y')  ),
(55666, 'Mohsen', 'Charef', 'Paris',        STR_TO_DATE('28-5-1991', '%d-%m-%Y')  ),
(77788, 'Tim', 'Arabi', 'Marseille',        STR_TO_DATE('8-6-1984', '%d-%m-%Y')  ),
(89990, 'Fernando', 'Lopez', 'Lyon',        STR_TO_DATE('5-10-1993', '%d-%m-%Y')  ),
(11122, 'Alain','Tan Lee', 'Marseille',     STR_TO_DATE('21-3-1994', '%d-%m-%Y')  ),
(11123, 'Franck', 'Morel', 'Lille',         STR_TO_DATE('10-01-1945', '%d-%m-%Y')  ),
(11124, 'Albert', 'Maure', 'Paris',         STR_TO_DATE('10-01-1948', '%d-%m-%Y')  ),
(11125, 'Beatrice', 'Malloire', 'Paris',    STR_TO_DATE('10-01-1946', '%d-%m-%Y')  ),
(11126, 'Christian', 'Millan', 'Paris',     STR_TO_DATE('10-01-1947', '%d-%m-%Y')  );


insert into Projet values (123, 'ADOOP', 22334, 'Paris', 120000);
insert into Projet values (757, 'SKALA', 45566, 'Lyon', 180000);
insert into Projet values (890, 'BAJA', 22334, 'Paris', 24000);


insert into Grille_sal (profil, salaire) values ('Admin', 80000.00);
insert into Grille_sal (profil, salaire) values ('Deve', 45000.00);
insert into Grille_sal (profil, salaire) values ('Tech', 35000.00);

insert into Embauche values (77889, 123,   STR_TO_DATE('1-3-2014', '%d-%m-%Y')  ,'Deve');
insert into Embauche values (90011, 123,   STR_TO_DATE('1-5-2014', '%d-%m-%Y')  ,'Tech');
insert into Embauche values (22233, 757,   STR_TO_DATE('1-3-2014', '%d-%m-%Y')  ,'Deve');


DELIMITER //
DROP PROCEDURE IF EXISTS SupprimerEmployes70ansOuPlus;

CREATE PROCEDURE SupprimerEmployes70ansOuPlus()
BEGIN
    DECLARE nbLignes INT DEFAULT 0;
    DELETE FROM Employe WHERE TIMESTAMPDIFF(YEAR, DateNaiss, CURDATE()) >= 70;
    SET nbLignes = ROW_COUNT();
    IF (nbLignes = 0) THEN
        SELECT 'Aucun employé supprimé.' AS Message;
    ELSE
        SELECT CONCAT('Nombre de lignes supprimées : ', nbLignes) AS Message;
    END IF;
END;
// 
DELIMITER ;

/*
    CALL SupprimerEmployes70ansOuPlus();
    CALL SupprimerEmployes70ansOuPlus();
*/



DELIMITER //
DROP PROCEDURE IF EXISTS ModifierProfilsEtSalaire;

CREATE PROCEDURE ModifierProfilsEtSalaire()
BEGIN
    ALTER TABLE Embauche DROP FOREIGN KEY fk_embauche_grille_sal;

    UPDATE Grille_sal 
    SET profil = CONCAT('P', profil);

    UPDATE Embauche 
    SET Profil = CONCAT('P', Profil);

    ALTER TABLE Embauche ADD CONSTRAINT fk_embauche_grille_sal
    FOREIGN KEY (Profil) REFERENCES Grille_sal(Profil);
END;
// 
DELIMITER ;

/*
    SELECT profil, salaire FROM Grille_sal;

    CALL ModifierProfilsEtSalaire();

    SELECT profil, salaire FROM Grille_sal;
    SELECT * FROM Embauche;
*/