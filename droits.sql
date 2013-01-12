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
