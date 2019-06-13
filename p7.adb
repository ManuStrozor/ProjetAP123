with P_Generation; use P_Generation;
with P_Classification; use P_Classification;
with P_Depeche; use P_Depeche, P_Depeche.P_categorieio;
with P_Lexique; use P_Lexique;
with P_Esiut; use P_Esiut;
with Text_Io; use Text_Io;

procedure P7 is   
   TVD : TV_Depeche;
   Dico : TV_Dico(1..2000);
   Nb : Integer := 0; 
   Inf : TR_Inf;
begin
   Charge("depeches.txt", TVD);
   
   for I in T_Categorie loop
      Init_Dico(TVD, I, Dico, Nb);
      Calcul_Scores(TVD, I, Dico, Nb);
      
      A_La_Ligne;
      Ecrire_Ligne(Image(I) & ':');
      Infos_Score(Dico, Nb, Inf);
      Ecrire("Max:" & Image(Inf.Max) & "  ");
      Ecrire("Moy:" & Image(Inf.Moy));
      
      A_La_Ligne;
      Ecrire("Q1:" & Image(Inf.Q1) & "  ");
      Ecrire("Q2:" & Image(Inf.Q2) & "  ");
      Ecrire("Q3:" & Image(Inf.Q3));
      
      A_La_Ligne;
      Ecrire_Ligne("Nb0Q1:" & Image(Inf.Nb0Q1));
      Ecrire_Ligne("NbQ1Q2:" & Image(Inf.NbQ1Q2));
      Ecrire_Ligne("NbQ2Q3:" & Image(Inf.NbQ2Q3));
      Ecrire_Ligne("NbQ3Max:" & Image(Inf.NbQ3Max));
   end loop;
end;
