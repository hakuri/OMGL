

--------------------------------------------------------------------------------
--VERIFIER QUE LA DISCIPLINE, LE NIVEAU ET LE PUBLIC CONCORDENT-----------------
--------------------------------------------------------------------------------
create function F_niveau() returns trigger as '
begin
	if (SELECT Discipline FROM TYPECOURS WHERE NumType=NEW.NumType) = ''Alpin'' then
		if (SELECT Public FROM TYPECOURS WHERE NumType=NEW.NumType) = ''Enfant'' then
			if (SELECT Niveau FROM TYPECOURS WHERE NumType=NEW.NumType) NOT IN (
''piou-piou'',''ourson'',''flocon'',''etoile1'',''etoile2'',''etoile3'',''etoile bronze'',''etoile or'',''competition'') then
			raise exception ''Le niveau ne correspond pas à la discipline demandee!'';
			end if;		
		elsif (SELECT Public FROM TYPECOURS WHERE NumType=NEW.NumType) = ''Adulte'' then
			if(SELECT Niveau FROM TYPECOURS WHERE NumType=NEW.NumType) NOT IN (''debutant'',''classe1'',''classe2'',''classe3'',''classe4'',''classe4 hors-piste'') then
			raise exception ''Le niveau ne correspond pas à la discipline demandee!'';
			end if;
		else raise exception ''Le public ne correspond pas à la discipline demandee!'';
		end if;
	elsif (SELECT Discipline FROM TYPECOURS WHERE NumType=NEW.NumType) = ''Snowboard'' then
		if (SELECT Public FROM TYPECOURS WHERE NumType=NEW.NumType) = ''+8ans'' then
			if (SELECT Niveau FROM TYPECOURS WHERE NumType=NEW.NumType) NOT IN (''debutant'',''snowboard1'',''snowboard2'',''snowboard3'',''competition'') then
			raise exception ''Le niveau ne correspond pas à la discipline demandee!'';
			end if;
		else raise exception ''Le public ne correspond pas à la discipline demandee!'';
		end if;
	else raise exception ''La discipline demandee n''''existe pas!'';
	end if;
return new;end;


'language'plpgsql';

CREATE TRIGGER TR_niveau
BEFORE UPDATE OR INSERT 
ON COURS FOR EACH ROW 
execute  procedure F_niveau();
--------------------------------------------------------------------------------
--VERIFIER AGE PAR RAPPORT AU PUBLIC DU TYPE DE COURS DEMANDE-------------------
--------------------------------------------------------------------------------
create function F_age() returns trigger as '
begin
	if (select Public from TYPECOURS where NumType=(select NumType FROM COURS where New.NumCours = numcours)) = ''Enfant'' then 
		if (extract (year from currentdate()))-(extract (year from (select DateNaissance from ELEVE where NumEleve =NEW.NumEleve)))>18 then raise exception ''Desole mais vous n''''etes plus un enfant!'';
		end if;
	elsif (select Public from TYPECOURS where NumType=(select NumType FROM COURS where New.NumCours = numcours)) = ''Adulte'' then
		if (extract (year from currentdate()))-(extract (year from(select DateNaissance from ELEVE where NumEleve=NEW.NumEleve)))<18 then raise exception ''Desole mais vous n''''etes encore un adulte!'';
		end if;
	elsif (select Public from TYPECOURS where NumType=(select NumType FROM COURS where New.NumCours = numcours)) = ''+8ans'' then
		if (extract (year from currentdate()))-(extract (year from (select DateNaissance from ELEVE where NumEleve=NEW.NumEleve)))<8 then raise exception ''Desole mais vous n''''avez pas encore 8 ans!'';
		end if;
	end if;
return new;
end;

'language'plpgsql';

CREATE TRIGGER TR_age
BEFORE UPDATE OR INSERT
ON INSCRIT FOR EACH ROW
execute procedure F_age();
--------------------------------------------------------------------------------
--UN COURS NE PEUX AVOIR PLUS DE 12 ELEVES--------------------------------------
--------------------------------------------------------------------------------
create function F_courscapacite() returns trigger as '
begin
	if (select count(NumEleve) from COURS where NumCours=NEW.NumCours group by NumCours)>=12 
	then raise exception ''Desole mais ce cours est dejà plein !'';
	end if;
return new;
end;

'language'plpgsql';

CREATE TRIGGER TR_courscapacite
BEFORE INSERT
ON INSCRIT FOR EACH ROW
execute procedure F_courscapacite();
--------------------------------------------------------------------------------
--UN PROF DOIT ETRE AFFECTE AU COURS POUR S'INSCRIRE----------------------------
--------------------------------------------------------------------------------
create function F_profaffecte() returns trigger as '
begin
	if New.Numcours NOT IN (select * from ENSEIGNE) then raise exception ''Desole, aucun professeur n''''est affecte à ce cours!'';
	end if;
return new;
end;

'language'plpgsql';

CREATE TRIGGER TR_profaffecte
BEFORE INSERT
ON INSCRIT FOR EACH ROW
execute procedure F_profaffecte();
--------------------------------------------------------------------------------
--VERIFIER DATE DEBUT<DATE FIN--------------------------------------------------
--------------------------------------------------------------------------------
create function F_dateanterieure() returns trigger as '
begin
	if NEW.DateDebut>New.DateFin then raise exception ''Le cours ne peux commencer apres avoir ete termine!'';
	end if;
	return new;
end;

'language'plpgsql';

CREATE TRIGGER TR_dateanterieure
BEFORE INSERT
ON COURS FOR EACH ROW
execute procedure F_dateanterieure();
--------------------------------------------------------------------------------
--VERIFIER HEURE DEBUT<HEURE FIN------------------------------------------------
--------------------------------------------------------------------------------
create function F_heureanterieure() returns trigger as '
begin
	if NEW.DateDebut=New.DateFin then
		if NEW.HeureDeb>NEW.HeureFin then raise exception ''Le cours ne peux commencer apres avoir ete termine!'';
		end if;
	end if;
return new;
end;

'language'plpgsql';

CREATE TRIGGER TR_heureanterieure
BEFORE INSERT
ON COURS FOR EACH ROW
execute procedure F_heureanterieure();
--------------------------------------------------------------------------------
--SPECIALITE--------------------------------------------------------------------
--------------------------------------------------------------------------------
create function F_specialite() returns triggers as '
begin
	if Type
return new;
end;

'language'plpgsql'


CREATE TRIGGER TR_specialite
BEFORE INSERT
ON COURS FOR EACH ROW
execute procedure F_specialite();
