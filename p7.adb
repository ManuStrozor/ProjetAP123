with P_Generation; use P_Generation;
with P_Classification; use P_Classification;
with P_Depeche; use P_Depeche, P_Depeche.P_categorieio;
with P_Esiut; use P_Esiut;
with P_String; use P_String;

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
      Ecrire_Ligne(Image(I) &' '& Dico(I).Mot &' '& Image(Dico(I).Score));
   end loop;
end;
