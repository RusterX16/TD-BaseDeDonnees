-- Question 3.1 --

CREATE TABLE Chercheur
(
    numc   INTEGER,
    nom    VARCHAR(40) NOT NULL,
    prenom VARCHAR(40) NOT NULL,
    equipe VARCHAR(40) NOT NULL,
    MINUS  int         not null,
    CONSTRAINT pk_chercheur PRIMARY KEY (numc)
);

CREATE TABLE Mission
(
    numis   INTEGER,
    pays    VARCHAR(40) NOT NULL,
    datedeb DATE        NOT NULL,
    datefin DATE        NOT NULL,
    objet   VARCHAR(40) NOT NULL,
    numc    INTEGER,
    CONSTRAINT date_correcte CHECK (datefin > datedeb),
    CONSTRAINT pk_mission PRIMARY KEY (numis),
    CONSTRAINT fk_mission_chercheur FOREIGN KEY (numc) REFERENCES Chercheur (numc)
);

CREATE TABLE Organisme
(
    nomorg VARCHAR(40),
    pays   VARCHAR(40) NOT NULL,
    CONSTRAINT pk_organisme PRIMARY KEY (nomorg)
);

CREATE TABLE Visite
(
    numis      INTEGER,
    nomorg     VARCHAR(40),
    datevisite DATE NOT NULL,
    CONSTRAINT pk_visite PRIMARY KEY (numis, nomorg),
    CONSTRAINT fk_visite_mission FOREIGN KEY (numis) REFERENCES Mission (numis),
    CONSTRAINT fk_visite_organisme FOREIGN KEY (nomorg) REFERENCES Organisme (nomorg)
);


-- Question 3.2 --

INSERT INTO Chercheur
VALUES (1, 'Roitelet', 'Martine', 'BD');
INSERT INTO Chercheur
VALUES (2, 'Dupont', 'Jacques', 'IA');
INSERT INTO Chercheur
VALUES (3, 'Duvivier', 'Anne', 'BD');
INSERT INTO Chercheur
VALUES (4, 'Rifflet', 'Jean-François', 'Systeme');


-- Question 3.3 --

INSERT INTO Organisme
VALUES ('LIRMM', 'France');
INSERT INTO Organisme
VALUES ('IRIT', 'France');
INSERT INTO Organisme
VALUES ('MIT', 'Etats-Unis');
INSERT INTO Organisme
VALUES ('4C', 'Irlande');
INSERT INTO Organisme
VALUES ('Cork University', 'Irlande');
INSERT INTO Organisme
VALUES ('NICTA', 'Australie');


-- Question 3.4 --

INSERT INTO Mission
VALUES (101, 'France', '08/01/2020', '15/01/2020', 'Contrat ANR', 1);
INSERT INTO Mission
VALUES (102, 'France', '08/01/2020', '15/01/2020', 'Contrat ANR', 3);
INSERT INTO Mission
VALUES (103, 'Irlande', '08/09/2020', '21/09/2020', 'CP 2020', 2);
INSERT INTO Mission
VALUES (104, 'Australie', '07/01/2020', '18/01/2020', 'CPAIOR', 2);
INSERT INTO Mission
VALUES (105, 'Etats-Unis', '31/01/2020', '08/02/2020', 'IJCAI', 2);
INSERT INTO Mission
VALUES (106, 'France', '01/06/2020', '15/06/2020', 'Coordination ANR', 1);
INSERT INTO Mission
VALUES (107, 'Australie', '08/01/2020', '18/01/2020', 'CPAIOR', 1);


-- Question 3.5 --

INSERT INTO Visite
VALUES (101, 'IRIT', '08/01/2020');
INSERT INTO Visite
VALUES (102, 'IRIT', '08/01/2021');
INSERT INTO Visite
VALUES (103, '4C', '08/09/2020');
INSERT INTO Visite
VALUES (103, 'Cork University', '12/09/2020');
INSERT INTO Visite
VALUES (104, 'NICTA', '07/01/2020');
INSERT INTO Visite
VALUES (105, 'MIT', '31/01/2020');
INSERT INTO Visite
VALUES (106, 'LIRMM', '01/06/2020');
INSERT INTO Visite
VALUES (107, 'NICTA', '07/01/2020');


-- Question 4.1

SELECT nomorg
FROM Visite v
         JOIN Mission m on v.numis = m.numis
         JOIN Chercheur c on m.numc = c.numc
WHERE nom LIKE 'Roitelet'
  AND prenom LIKE 'Martine';


-- Question 4.2

SELECT nom
FROM Chercheur c
         JOIN Mission m on c.numc = m.numc
WHERE pays LIKE 'Etats-Unis'
INTERSECT
SELECT nom
FROM Chercheur c
         JOIN Mission m ON c.numc = m.numc
WHERE pays LIKE 'Australie';


-- Question 4.3

SELECT nom
FROM Chercheur
MINUS
SELECT nom
FROM Chercheur c
         JOIN Mission m ON c.numc = m.numc;


-- Question 4.4

SELECT nom
FROM Chercheur
MINUS
SELECT nom
FROM (
         SELECT c.nom, numis
         FROM Chercheur c,
              Mission m
         MINUS
         SELECT c.nom, numis
         FROM Chercheur c
                  JOIN Mission m ON c.numc = m.numc
     );


-- Question 4.5


-- Question 4.6

SELECT nom, prenom
FROM Chercheur
ORDER BY nom;


-- Question 4.7

SELECT numis
FROM Mission
ORDER BY datedeb DESC;


-- Question 4.8

SELECT *
FROM Organisme
ORDER BY pays, nomorg;


-- Question 4.9

SELECT COUNT(*)
FROM Chercheur;


-- Question 4.10

SELECT COUNT(DISTINCT numc)
FROM Mission;


-- Question 4.11

SELECT objet
FROM Mission
WHERE datedeb LIKE (SELECT MIN(datedeb) FROM Mission);


-- Question 4.12

SELECT nom
FROM Chercheur c
         JOIN Mission m on c.numc = m.numc
WHERE datedeb LIKE (SELECT MIN(datedeb) FROM Mission);


-- Question 4.13

SELECT nomorg
FROM Visite v
         JOIN Mission m ON v.numis = m.numis
WHERE m.numis LIKE (SELECT m.numis
                    FROM Mission m
                             JOIN Chercheur c ON m.numc = c.numc
                    WHERE nom LIKE 'Roitelet'
                      AND prenom LIKE 'Martine');