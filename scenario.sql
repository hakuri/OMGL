-------------------------------------------------------------------------
-- Scenario de démonstration projet OMGL --------------------------------
-------------------------------------------------------------------------

-------------------------------------------------------------------------
-- Role : Directeur Technique -------------------------------------------
-------------------------------------------------------------------------

	-- Insert des informations sur les Types de Cours:
		-- INSERT INTO TYPECOURS VALUES (1,'Alpin','Enfant','piou-piou');
		
	-- Supprime les Cours dispensés la semaine precedente:
		-- DELETE FROM COURS 
		-- WHERE DateFin < 07/01/2013;
		
	-- Insert les Cours dispensés la semaine suivante:
		-- INSERT INTO COURS VALUES (1,'07/01/2013','07/01/2013','1','Briancon','07:00','18:30','Particulier');
		
	-- Vérifie les Cours et les Moniteurs:
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
	
	
	