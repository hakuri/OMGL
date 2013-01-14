CREATE TABLE MONITEURS (
	NumMono			integer		primary key,
	Nom			varchar		,
	Prenom			varchar		,
	Adresse			varchar		,
	Telephone		integer		
);
CREATE TABLE ELEVE (
	NumEleve		integer		primary key,
	Nom			varchar		,
	Prenom			varchar		,
	DateNaissance		date		,
	AdresseStation		varchar		,
	Mobile			integer		
);
CREATE TABLE TYPECOURS (
	NumType			integer		primary key,
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
	HeureFin			time		,
	Type			varchar check (Type IN('Collectif','Particulier'))
		
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
	NumMono			integer		REFERENCES MONITEURS(NumMono),
	Specialite		varchar		check(Specialite IN('alpin','snowboard','freeride','freestyle','handyski','telemark')),
	primary key(NumMono,Specialite)
);
CREATE TABLE COURSPARTICULIERS (
	NumCours		integer		primary key,
	DateDebut		date		,
	DateFin			date		,
	Spécialité		varchar		,
	LieuRDV			varchar		,
	HeureDeb		time		,
	HeurFin			time		
	);
