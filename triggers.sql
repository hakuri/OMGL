

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
