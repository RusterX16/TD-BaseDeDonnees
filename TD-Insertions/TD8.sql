-- Question 3.1.1

INSERT INTO Produit VALUES(20, 'Cahier', 'Blanc', 100);



-- Question 3.1.2

INSERT INTO Produit(np, lib, coul) VALUES(21, 'Gomme', 500);
-- La couleur est nulle



-- Question 3.1.3

INSERT INTO Produit(lib, coul, qs) VALUES('Trombone', 'Gris', 1000);
-- Impossible d'insérer NULL dans Barbete/Produit/np



-- Question 3.1.4

-- Car il existe déjà un tuple avec le np égal à 21



-- Question 3.1.5

INSERT INTO Achat VALUES(101, 20, 12);



-- Question 3.2.1

DELETE FROM Produit WHERE np = 21;



-- Question 3.2.2

DELETE FROM Produit WHERE np = 20;

-- Ca ne fonctionne pas parce que la clé primaire 
-- de ce tuple est présente dans une autre table

-- Supprimer le tuple qui contient la clé primaire
-- dans la table concernée avant


-- Question 3.2.3

DELETE FROM Achat WHERE qa < 5;



-- Question 3.2.4

SELECT ncli FROM Client WHERE nom LIKE 'Ullman';
SELECT * FROM Achat WHERE ncli = (SELECT ncli FROM Client WHERE nom LIKE 'Ullman');
DELETE FROM Achat WHERE ncli = (SELECT ncli FROM Client WHERE nom LIKE 'Ullman');



-- Question 3.3.1

UPDATE Achat SET qa = qa + 10 WHERE ncli = (SELECT ncli FROM Client WHERE nom LIKE 'Defrere');



-- Question 3.2.2

UPDATE Produit SET qs = qs + 10, coul = 'Jaune' WHERE lib LIKE 'Crayon Luxe' AND coul LIKE 'Rouge';



-- Question 3.2.3

UPDATE Achat SET qa = qa + 2 WHERE ncli = (SELECT ncli FROM Client WHERE nom LIKE 'Defrere');



-- Question 3.2.4

UPDATE Produit SET np = 30;

-- Violation de contrainte unique



-- Question 4.1.1

ALTER TABLE Client ADD adresse VARCHAR(40);



-- Question 4.1.2

ALTER TABLE Client MODIFY adresse VARCHAR(80)



-- Question 4.1.3

UPDATE Client SET adresse = 'Montpellier';



-- Question 4.1.4

ALTER TABLE Client MODIFY adresse VARCHAR(80) DEFAULT 'Mende';



-- Question 4.1.5

INSERT INTO Client(ncli, nom) VALUES(110, 'Johnny');



-- Question 4.2.1

CREATE TABLE Fournisseur(nf INTEGER, nom VARCHAR(40) NOT NULL, adr VARCHAR(40) NOT NULL, CONSTRAINT pk_fournisseur PRIMARY KEY(nf));



-- Question 4.2.2

INSERT INTO Fournisseur VALUES(1001, 'Bureau Valle', 'Les Sables d Olonne');
INSERT INTO Fournisseur VALUES(1002, 'BIC', 'Montpellier');
INSERT INTO Fournisseur VALUES(1003, 'NADA', 'Mende');



-- Question 4.2.3

INSERT INTO Fournisseur(nf, nom) VALUES(1004, 'Clairfontaine');
-- Impossible d'insérer NULL dans Barbete/Fournisseur/adr

INSERT INTO Fournisseur VALUES(1002, 'Epson', 'Paris');
-- Violation de contrainte unique Barbete.pk_fournisseur



-- Question 4.2.4

CREATE TABLE Reap(
	nf INTEGER, 
	np INTEGER, 
	date_reap DATE DEFAULT CURRENT_DATE, 
	qr INTEGER NOT NULL, 
	CONSTRAINT pk_reap PRIMARY KEY(nf, np, date_reap),
	CONSTRAINT reaprovisionnement CHECK(qr > 0),
	CONSTRAINT fk_reap_nf FOREIGN KEY (nf) REFERENCES Fournisseur(nf), 
	CONSTRAINT fk_reap_np FOREIGN KEY (np) REFERENCES Produit(np));



-- Question 4.2.5

INSERT INTO Reap VALUES(1001, 1, CURRENT_DATE, 51);
INSERT INTO Reap VALUES(1001, 4, CURRENT_DATE, 100);
INSERT INTO Reap VALUES(1001, 5, CURRENT_DATE, 100);
INSERT INTO Reap VALUES(1001, 6, CURRENT_DATE, 100);
INSERT INTO Reap VALUES(1001, 7, CURRENT_DATE, 100);
INSERT INTO Reap VALUES(1001, 7, '01/01/2020', 100);
INSERT INTO Reap VALUES(1002, 5, '01/01/2020', 500);
INSERT INTO Reap VALUES(1003, 1, '01/01/2020', 49);
INSERT INTO Reap VALUES(1003, 9, '01/01/2020', 100);
INSERT INTO Reap VALUES(1003, 9, '01/02/2020', 50);
INSERT INTO Reap VALUES(1003, 10, '01/01/2020', 200);



-- Question 4.2.6

INSERT INTO Reap(nf, np, date_reap) VALUES(1002, 1, CURRENT_DATE);
-- Impossible d'insérer NULL dans Barbete/Reap/qr

INSERT INTO Reap VALUES(1001, 7, '01/01/2020', 101);
-- Violation de contrainte unique Barbete/pk_reap

INSERT INTO Reap VALUES(1004, 4, CURRENT_DATE, 3);
-- Violation de contrainte d'intégrité Barbete/fk_reap_nf - clé parent introuvable



-- Question 4.3.1

SELECT DISTINCT r.nf FROM Reap r JOIN Produit p ON r.np LIKE p.np WHERE lib LIKE 'Lampe' OR lib LIKE 'Agrafeuse';



-- Question 4.3.2

SELECT nom FROM Fournisseur f JOIN Reap r ON f.nf LIKE r.nf JOIN Produit p ON r.np LIKE p.np WHERE lib LIKE 'Lampe' 
INTERSECT
SELECT nom FROM Fournisseur f JOIN Reap r ON f.nf LIKE r.nf JOIN Produit p ON r.np LIKE p.np WHERE lib LIKE 'Agrafeuse';



-- Question 4.3.3

SELECT nom FROM Fournisseur f JOIN Reap r ON f.nf LIKE r.nf 
MINUS 
SELECT f.nom FROM Fournisseur f JOIN Reap r ON f.nf LIKE r.nf JOIN Produit p ON p.np LIKE r.np WHERE lib = 'Lampe';



-- Question 4.3.4

SELECT nom FROM Fournisseur f JOIN Reap r ON f.nf LIKE r.nf 
MINUS 
SELECT nom FROM Fournisseur f JOIN Reap r ON f.nf LIKE r.nf WHERE date_reap > '02/02/2020';



-- Question 4.3.5

SELECT DISTINCT r.nf FROM Reap r JOIN Reap r2 ON r.qr LIKE r2.qr WHERE r.nf != r2.nf;


-- Question 4.3.6

SELECT DISTINCT r.np FROM Reap r JOIN Reap r2 ON r.np LIKE r2.np WHERE r.nf != r2.nf OR r.date_reap != r2.date_reap;

-- Question 4.3.7

