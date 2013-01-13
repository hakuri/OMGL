--------------------------------------------------------------------------------
--DROITS DE DIRECTEUR TECHNIQUE-------------------------------------------------
--------------------------------------------------------------------------------
CREATE VIEW V_profdispo AS SELECT NumMono FROM MONITEURS WHERE NumMono NOT IN ENSEIGNE;
GRANT ALL ON TYPECOURS TO skivite;
GRANT ALL ON MONITEURS TO skivite;
GRANT ALL ON COURS TO skivite;
GRANT SELECT ON V_profdispo TO skivite;
GRANT ALL ON ENSEIGNE TO skivite;
--------------------------------------------------------------------------------
--DROITS DE SECRETAIRE----------------------------------------------------------
--------------------------------------------------------------------------------
CREATE VIEW V_infocours AS SELECT * FROM TYPECOURS, COURS WHERE TYPECOURS.NumType=COURS.NumType;
GRANT SELECT ON V_infocours TO tapevite;
GRANT SELECT ON COURS TO tapevite;
GRANT INSERT ON INSCRIT TO tapevite;
--------------------------------------------------------------------------------
--DROITS DE MONITEUR------------------------------------------------------------
--------------------------------------------------------------------------------
CREATE VIEW V_planningmono AS SELECT * FROM COURS WHERE NumCours=(SELECT NumCours FROM ENSEIGNE WHERE NumMono=(SELECT NumMono FROM MONITEURS WHERE Nom=Current.user));
CREATE VIEW V_listeelevesmono AS SELECT * FROM ELEVES WHERE NumEleve=(select NumEleve FROM INSCRIT WHERE NumCours=(SELECT NumCours FROM ENSEIGNE WHERE NumMono=(SELECT NumMono FROM MONITEURS WHERE Nom=Current.user;)));
GRANT SELECT ON V_planningmono TO killy;
GRANT SELECT ON V_listeelevesmono TO killy;
GRANT SELECT ON V_listeelevesmono TO alphand;
GRANT SELECT ON V_planningmono TO alphand;