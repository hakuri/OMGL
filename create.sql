CREATE TABLE MONITEURS (
	NumMono			integer		primary key,
	Nom				varchar		,
	Prenom			varchar		,
	Adresse			varchar		,
	Telephone		integer		
);
CREATE TABLE ELEVE (
	NumEleve		integer		primary key,
	Nom				varchar		,
	Prenom			varchar		,
	DateNaissance	date		,
	AdresseStation	varchar		,
	Mobile			integer		
);
CREATE TABLE TYPECOURS (
	NumType			integer		primary key,
	Groupe			varchar		,
	Discipline		varchar		,
	Public			varchar	check(Public IN ('Adulte','Enfant','+8ans')),	
	Niveau			varchar	
);
CREATE TABLE COURS (
	NumCours		integer		primary key,
	DateDebut		date		,
	DateFin			date		,
	NumType			integer		REFERENCES TYPECOURS(NumType),
	LieuRDV			varchar		,
	HeureDeb		time		,
	HeureFin		time		
		
);
CREATE TABLE ENSEIGNE (
	NumCours		integer		primary key	REFERENCES COURS(NumCours),
	NumMono			integer				REFERENCES MONITEURS(NumMono)	

);
CREATE TABLE INSCRIT (	
	NumEleve		integer		REFERENCES ELEVE(NumEleve),
	NumCours		integer		REFERENCES COURS(NumCours),
	primary key(NumEleve,NumCours)
);
CREATE TABLE SPECIALITE (	
	NumMono		integer		REFERENCES ELEVE(NumMono),
	Specialite	integer		,
	primary key(NumMono,Specialite)
);

