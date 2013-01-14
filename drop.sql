DROP TRIGGER TR_niveau ON COURS;
DROP TRIGGER TR_age ON INSCRIT;
DROP TRIGGER TR_courscapacite ON INSCRIT;
DROP TRIGGER TR_profaffecte ON INSCRIT;
DROP TRIGGER TR_dateanterieure ON COURS;
DROP TRIGGER TR_heureanterieure ON COURS;
DROP TRIGGER TR_specialite ON COURS;

DROP function F_niveau();
DROP function F_age();
DROP function F_courscapacite();
DROP function F_profaffecte();
DROP function F_dateanterieure();
DROP function F_heureanterieure();
DROP function F_specialite();

DROP TABLE SPECIALITE;
DROP TABLE INSCRIT;
DROP TABLE ENSEIGNE;
DROP TABLE COURS;
DROP TABLE TYPECOURS;
DROP TABLE ELEVE;
DROP TABLE MONITEURS;
