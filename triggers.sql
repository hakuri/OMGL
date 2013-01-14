

--------------------------------------------------------------------------------
--VERIFIER QUE LA DISCIPLINE, LE NIVEAU ET LE PUBLIC CONCORDENT-----------------
--------------------------------------------------------------------------------
create function F_niveau() returns trigger as '
begin
	if NEW.Discipline = ''Alpin'' then
		if NEW.Public = ''Enfant'' then
			if NEW.Niveau NOT IN (
''piou-piou'',''ourson'',''flocon'',''étoile1'',''étoile2'',''étoile3'',''étoile bronze'',''étoile or'',''compétition'') then
			raise exception ''Le niveau ne correspond pas à la discipline demandée!'';
			end if;		
		elsif NEW.Public = ''Adulte'' then
			if NEW.Niveau NOT IN (''débutant'',''classe1'',''classe2'',''classe3'',''classe4'',''classe4 hors-piste'') then
			raise exception ''Le niveau ne correspond pas à la discipline demandée!'';
			end if;
		else raise exception ''Le public ne correspond pas à la discipline demandée!'';
		end if;
	elsif NEW.Discipline = ''Snowboard'' then
		if NEW.Public = ''+8ans'' then
			if NEW.Niveau NOT IN (''débutant'',''snowboard1'',''snowboard2'',''snowboard3'',''compétition'') then
			raise exception ''Le niveau ne correspond pas à la discipline demandée!'';
			end if;
		else raise exception ''Le public ne correspond pas à la discipline demandée!'';
		end if;
	else raise exception ''La discipline demandée n''''éxiste pas!'';
	end if;
end;
return new;

'language'plpgsql'

CREATE TRIGGER TR_cathegorie-niveau
BEFORE UPDATE OR INSERT 
ON COURS FOR EACH ROW 
execute  procedure F_niveau();
--------------------------------------------------------------------------------
--VERIFIER AGE PAR RAPPORT AU PUBLIC DU TYPE DE COURS DEMANDE-------------------
--------------------------------------------------------------------------------
create function F_age() returns trigger as '
begin
	if (select Public from TYPECOURS where NumType=(select NumType FROM COURS where New.NumCours = numcours)) = ''Enfant'' 
		if (extract year (currentdate()))-(extract year (select DateNaissance from ELEVE where NumEleve=NEW.NumEleve))>18 then raise exception ''Desolé mais vous n''''etes plus un enfant!''
		end if;
	elsif (select Public from TYPECOURS where NumType=(select NumType FROM COURS where New.NumCours = numcours)) = ''Adulte''
		if (extract year (currentdate()))-(extract year (select DateNaissance from ELEVE where NumEleve=NEW.NumEleve))<18 then raise exception ''Desolé mais vous n''''etes encore un adulte!''
		end if;
	elsif (select Public from TYPECOURS where NumType=(select NumType FROM COURS where New.NumCours = numcours)) = ''+8ans''
		if (extract year (currentdate()))-(extract year (select DateNaissance from ELEVE where NumEleve=NEW.NumEleve))<8 then raise exception ''Desolé mais vous n''''avez pas encore 8 ans!''
		end if;
	end if;
end;
return new;
'language'plpgsql'

CREATE TRIGGER TR_age
BEFORE UPDATE OR INSERT
ON INSCRIT FOR EACH ROW
execute procedure F_age();
--------------------------------------------------------------------------------
--UN COURS NE PEUX AVOIR PLUS DE 12 ELEVES--------------------------------------
--------------------------------------------------------------------------------
create function F_courscapacite() returns trigger as '
begin
	if (count(NumEleve) from COURS where NumCours=NEW.NumCours group by NumCours)>=12 
	then raise exception ''Désolé mais ce cours est déjà plein !''
	end if;
end;
return new;
'language'plpgsql'

CREATE TRIGGER TR_courscapacite
BEFORE INSERT
ON INSCRIT FOR EACH ROW
execute procedure F_courscapacite();
--------------------------------------------------------------------------------
--UN PROF DOIT ETRE AFFECTE AU COURS POUR S'INSCRIRE----------------------------
--------------------------------------------------------------------------------
create function F_profaffecte() returns trigger as '
begin
	if New.Numcours NOT IN ENSEIGNE then raise exception ''Désolé, aucun professeur n''''est affecté à ce cours!'';
	end if;
end;
return new;
'language'plpgsql'

CREATE TRIGGER TR_profaffecte
BEFORE INSERT
ON INSCRIT FOR EACH ROW
execute procedure F_profaffecte();
--------------------------------------------------------------------------------
--VERIFIER DATE DEBUT<DATE FIN--------------------------------------------------
--------------------------------------------------------------------------------
create function F_dateanterieure() returns triggers as '
begin
	if NEW.DateDebut>New.DateFin then raise exception ''Le cours ne peux commencer après avoir été terminé!''
	end if;
end;
return new;
'language'plpgsql'

CREATE TRIGGER TR_dateanterieur
BEFORE INSERT
ON COURS FOR EACH ROW
execute procedure F_dateanterieur();
--------------------------------------------------------------------------------
--VERIFIER HEURE DEBUT<HEURE FIN------------------------------------------------
--------------------------------------------------------------------------------
create function F_dateanterieure() returns triggers as '
begin
	if NEW.HeureDeb>NEW.HeureFin then raise exception ''Le cours ne peux commencer après avoir été terminé!''
	end if;
end;
return new;
'language'plpgsql'

CREATE TRIGGER TR_dateanterieur
BEFORE INSERT
ON COURS FOR EACH ROW
execute procedure F_dateanterieur();
--------------------------------------------------------------------------------
--SPECIALITE--------------------------------------------------------------------
--------------------------------------------------------------------------------
create function F_specialite() returns triggers as '
begin
end;
return new;
'language'plpgsql'

CREATE TRIGGER TR_specialite
BEFORE INSERT
ON COURS FOR EACH ROW
execute procedure F_specialite();