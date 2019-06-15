with P_Generation; use P_Generation;
with P_Classification; use P_Classification;
with P_Depeche; use P_Depeche, P_Depeche.P_categorieio;
with P_Lexique; use P_Lexique;
with P_Esiut; use P_Esiut;
with Text_Io; use Text_Io;

procedure P7 is   
   TVD : TV_Depeche;
   Dico : TV_Dico(1..2000);
   N : Integer;
   Min, Q1, Med, Q3, Max : Integer := 0;
begin
   Charge("txt/depeches.txt", TVD);
   for I in T_Categorie loop
      N := 0;
      Init_Dico(TVD, I, Dico, N);
      Calcul_Scores(TVD, I, Dico, N);
      
      A_La_Ligne;
      Ecrire_Ligne(Image(I) &':');
      Infos_Scores(Dico, N, Min, Q1, Med, Q3, Max);
      Ecrire("Min:" & Image(Min) & "  ");
      Ecrire("Max:" & Image(Max));
      
      A_La_Ligne;
      Ecrire("Q1:" & Image(Q1) & "  ");
      Ecrire("Med:" & Image(Med) & "  ");
      Ecrire("Q3:" & Image(Q3));
   end loop;
end;
