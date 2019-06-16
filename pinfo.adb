with P_Depeche; use P_Depeche, P_Depeche.P_categorieio;
with P_Classification; use P_Classification;
with P_Generation; use P_Generation;
with P_Chaine; use P_Chaine;
with P_Esiut; use P_Esiut;

procedure Pinfo is   
   TVD : TV_Depeche;
   VM : TV_Dico(1..2000);
   N : Integer;
   Inf : TR_Info := (0, 0, 0, 0, 0,
		     0, 0, 0, 0, 0);
   
   procedure AfficheMotsEntre(VM : in TV_Dico; N, Min, Max : in Integer) is
      -- {} => {Affiche les mots avec un score entre min et max}
      VMtemp : TV_Dico(1..N) := VM(1..N);
      
      procedure TriBullesOpt(V : in out TV_Dico; N : in integer) is
	 -- {} => {V trié par ordre croissant}
	 I : Integer;
	 Onapermute : Boolean;
	 Tmp : TR_Entree;
      begin
	 I := V'First; Onapermute := True;
	 while Onapermute loop
	    Onapermute := False;
	    for J in reverse I+1..N loop
	       if V(J).score < V(J-1).score then
		  Tmp := V(J);
		  V(J) := V(J-1);
		  V(J-1) := tmp;
		  Onapermute := True;
	       end if;
	    end loop;
	    I := I + 1;
	 end loop;
      end;
      I : Integer := VMtemp'First;
   begin
      Tribullesopt(VMtemp, N);
      while I <= N and then VMtemp(I).Score <= Min loop
	 I := I + 1;
      end loop;
      while I <= N and then VMtemp(I).Score <= Max loop
	 Ecrire(Trim(VMtemp(I).Mot) & ' ');
	 I := I + 1;
      end loop;
   end;
   
   Lol : Integer := 15;
begin
   Charge("txt/depeches.txt", TVD);
   
   for I in T_Categorie loop
      N := 0;
      Init_Dico(TVD, I, VM, N);
      Calcul_Scores(TVD, I, VM, N);
      Infos_Scores(VM, N, Inf);
      
      Ecrire_Ligne(Image(I) &": ("& Image(Inf.NbPos) & " mots )");
      
      Ecrire("Min:" & Utrim(Image(Inf.Min), 5)); Ecrire(' '& Image(Inf.Nb0) & " mots : ");
      if Inf.Nb0 <= lol then
	 AfficheMotsEntre(VM, N, Inf.Min, Inf.Q1);
      end if; A_La_Ligne;
      
      Ecrire(" Q1:" & Utrim(Image(Inf.Q1), 5)); Ecrire(' '& Image(Inf.Nb1) & " mots : ");
      if Inf.Nb1 <= lol then
	 AfficheMotsEntre(VM, N, Inf.Q1, Inf.Med);
      end if; A_La_Ligne;
      
      Ecrire("Med:" & Utrim(Image(Inf.Med), 5)); Ecrire(' '& Image(Inf.Nb2) & " mots : ");
      if Inf.Nb2 <= lol then
	 AfficheMotsEntre(VM, N, Inf.Med, Inf.Q3);
      end if; A_La_Ligne;
      
      Ecrire(" Q3:" & Utrim(Image(Inf.Q3), 5)); Ecrire(' '& Image(Inf.Nb3) & " mots : ");
      if Inf.Nb3 <= lol then
	 AfficheMotsEntre(VM, N, Inf.Q3, Inf.Max);
      end if; A_La_Ligne;
      
      Ecrire_Ligne("Max:" & Image(Inf.Max));
      A_La_Ligne;
   end loop;
   
end;
