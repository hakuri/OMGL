CREATE TABLE MONITEURS (
	NumMono			integer		primary key,
	Nom				varchar		,
	Prenom			varchar		,
	Adresse			varchar		,
	Telephone		integer		,
	Specialite		varchar		default alpin check(Specialite IN('alpin','snowboard','freeride','freestyle','télémark','handiski'))
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
	Discipline		varchar		,
	Public			varchar	check(Public IN ('Adulte','Enfant';'+8ans')),	
	Niveau			varchar	
);
CREATE TABLE COURS (
	NumCours		integer		primary key,
	DateDebut		date		,
	DateFin			date		,
	NumType			integer		,
	LieuRDV			varchar		,
	HeureDeb		time		,
	HeurFin			time		,
	foreign key (NumType) REFERENCES TYPECOURS(NumType)
		
);
CREATE TABLE ENSEIGNE (
	NumCours		integer		,
	NumMono			integer		,	
	foreign key (NumCours) REFERENCES COURS(NumCours) primary key,
	foreign key (NumMono) REFERENCES MONITEUR(NumMono)
);
CREATE TABLE INSCRIT (	
	NumEleve		integer		,
	NumCours		integer		,
	foreign key (NumEleve) REFERENCES ELEVE(NumEleve),
	foreign key (NumCours) REFERENCES COURS(NumCours)
);
