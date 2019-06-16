with P_Depeche; use P_Depeche, P_Depeche.P_categorieio;
with P_Classification; use P_Classification;
with P_Generation; use P_Generation;
with P_Chaine; use P_Chaine;
with P_Esiut; use P_Esiut;

procedure P7 is   
   TVD : TV_Depeche;
   Dico : TV_Dico(1..2000);
   N : Integer := 0;
   Min, Q1, Med, Q3, Max : Integer := 0;
   Rep : T_Categorie;
begin
   Charge("txt/depeches.txt", TVD);
   
   Ecrire("Categorie: "); Lire(Rep);
   
   Init_Dico(TVD, Rep, Dico, N);
   Calcul_Scores(TVD, Rep, Dico, N);
   
   for I in Dico'First..N loop
      Ecrire_Ligne(Image(I) &" f"& Utrim(Image(Dico(I).Freq), 4) &' '& Dico(I).Mot & Image(Dico(I).Score) &" -> "& Image(Integer(Float(Dico(I).Score) + (Float(Dico(I).Score)*(Float(Dico(I).Score)/Float(Dico(I).Freq))))));
   end loop;
   
end;
