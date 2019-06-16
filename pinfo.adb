with P_Generation; use P_Generation;
with P_Classification; use P_Classification;
with P_Depeche; use P_Depeche, P_Depeche.P_categorieio;
with P_String; use P_String;
with P_Esiut; use P_Esiut;

procedure Pinfo is   
   TVD : TV_Depeche;
   VM : TV_Dico(1..2000);
   N : Integer;
   Inf : TR_Info := (0, 0, 0, 0, 0,
		     0, 0, 0, 0, 0);
begin
   Charge("txt/depeches.txt", TVD);
   for I in T_Categorie loop
      N := 0;
      Init_Dico(TVD, I, VM, N);
      Calcul_Scores(TVD, I, VM, N);
      
      Ecrire_Ligne(Image(I) &':');
      Infos_Scores(VM, N, Inf);
      
      Ecrire("Min:" & Utrim(Image(Inf.Min), 3)); Ecrire_Ligne(" (" & Image(Inf.Nb0) & " mots )");
      Ecrire(" Q1:" & Utrim(Image(Inf.Q1), 3)); Ecrire_Ligne(" (" & Image(Inf.Nb1) & " mots )");
      Ecrire("Med:" & Utrim(Image(Inf.Med), 3)); Ecrire_Ligne(" (" & Image(Inf.Nb2) & " mots )");
      Ecrire(" Q3:" & Utrim(Image(Inf.Q3), 3)); Ecrire_Ligne(" (" & Image(Inf.Nb3) & " mots )");
      Ecrire_Ligne("Max:" & Image(Inf.Max));
      
      Pause;
      A_La_Ligne;
   end loop;
end;
