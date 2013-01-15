-------------------------------------------------------------------------
-- Scenario de demonstration projet OMGL --------------------------------
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Role : Directeur Technique -------------------------------------------
-------------------------------------------------------------------------

	-- Insert des informations sur les Types de Cours:
		-- INSERT INTO TYPECOURS VALUES (1,'Alpin','Enfant','piou-piou');
		
	-- Supprime les Cours dispenses la semaine precedente:
		-- DELETE FROM COURS 
		-- WHERE DateFin < 07/01/2013;
		
	-- Insert les Cours dispenses la semaine suivante:
		-- INSERT INTO COURS VALUES (1,'07/01/2013','07/01/2013','1','Briancon','07:00','18:30','Particulier');
		
	-- Verifie les Cours et les Moniteurs:
		-- SELECT Nom, Prenom, Type, DateDebut, DateFin, LieuRDV
		-- FROM COURS, MONITEURS
		-- WHERE Type, DateDebut, DateFin, LieuRDV IN (SELECT Type, DateDebut, DateFin, LieuRDV
		--			 FROM COURS, ENSEIGNE
		--			 WHERE COURS.NumCours = ENSEIGNE.NumCours)
		-- AND Nom, Prenom IN(SELECT Nom, Prenom
		--		FROM MONITEURS
		--		WHERE MONITEURS.NumMono = ENSEIGNE.NumMono)
	
	-- Modifie les Affectations:
		-- UPDATE ENSEIGNE SET NumMono = 5 WHERE NumMono = 2;

-------------------------------------------------------------------------
-- Role : Secretaire ----------------------------------------------------
-------------------------------------------------------------------------

	-- Verifie que le Cours demande existe:
		-- SELECT *
		-- FROM COURS
		-- WHERE NumType IN (SELECT NumType
		--					 FROM TYPECOURS
		--					 WHERE Discipline = 'Alpin' AND Niveau = 'debutant';
	
	-- Inscrit l'eleve a un cours:
		-- INSERT INTO INSCRIT VALUES (1,11);
		
-------------------------------------------------------------------------
-- Role : Moniteur ------------------------------------------------------
-------------------------------------------------------------------------	
		
	-- Verifie les Cours qu'il enseigne le lendemain:
		-- SELECT *
		-- FROM Cours
		-- WHERE NumCours IN (SELECT NumCours
		--					  FROM ENSEIGNE
		--					  WHERE NumMono IN (SELECT NumMono
		--										FROM MONITEURS
		--										WHERE Nom = 'getpgusername()'));
	
	-- Verifie la liste des Eleves et leurs informations:
		-- SELECT *
		-- FROM ELEVE;
	
	
-------------------------------------------------------------------------
-- Scenario 1: Un eleve s'inscrit a un cours collectif ------------------
-------------------------------------------------------------------------

Un eleve se presente devant la secretaire, elle lui demande donc son nom et son prénom (autres info si necessaire):
	- Falcon Fanny (par exemple)
	
La secretaire recupere les autres infos sur cet eleve (en particulier NumEleve):
	-- SELECT * FROM ELEVE WHERE Nom = 'Falcon' AND Prenom = 'Fanny';
		-- NumEleve = 32

Elle lui demande ensuite dans quelle discipline, a quel niveau et a quel type de cours cet eleve souhaite etre inscrit:
	- Alpin, 2° etoile, collectif
	
La secretaire affiche la liste des cours disponibles:
	-- SELECT * FROM COURS WHERE Type = 'Collectif' AND NumType IN (SELECT NumType FROM TYPECOURS WHERE Discipline = 'Alpin' AND Niveau = 'etoile2');
****	peut etre un count < 12    ****	
	-- Le Cours choisi est le n°5

Une fois le cours choisi la secretaire inscrit l''eleve:

	-- INSERT INTO INSCRIT VALUES (32,5);

-------------------------------------------------------------------------
-- Scenario 1: Un eleve s'inscrit a un cours particulier ----------------
-------------------------------------------------------------------------

Un eleve se presente devant la secretaire, elle lui demande donc son nom et son prénom (autres info si necessaire):
	- Falcon Fanny (par exemple)
	
La secretaire recupere les autres infos sur cet eleve (en particulier NumEleve):
	-- SELECT * FROM ELEVE WHERE Nom = 'Falcon' AND Prenom = 'Fanny';
		-- NumEleve = 32
		
Elle lui demande ensuite dans quelle discipline, a quel niveau et a quel type de cours cet eleve souhaite etre inscrit:
	- Alpin, 2° etoile, particulier

La secretaire affiche la liste des cours disponibles:
	-- SELECT * FROM COURS WHERE Type = 'Particulier' AND NumType IN (SELECT NumType FROM TYPECOURS WHERE Discipline = 'Alpin' AND Niveau = 'etoile2');
****	peut etre un count < 12    ****	
	-- Le Cours choisi est le n°26
	
Une fois le cours choisi la secretaire inscrit l''eleve:

	-- INSERT INTO INSCRIT VALUES (32,26);
