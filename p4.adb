with P_Classification; use P_Classification;
with P_Lexique; use P_Lexique;
with P_Depeche; use P_Depeche, P_Depeche.P_CategorieIO;
with P_Esiut; use P_Esiut;

procedure P4 is
   Dep : TV_Depeche;
   Sc : TV_Score;
   Ind : Integer;
begin
   Charge("txt/test.txt", Dep);
   loop
      Ecrire("Dépèche numéro: "); Lire(Ind);
      exit when Ind >= 1 and Ind <= 500;
   end loop;
   declare
      Lp : TV_Lexique(1..Nb_Mots("lex/POLITIQUE-2.txt"));
      Ls : TV_Lexique(1..Nb_Mots("lex/SPORTS-2.txt"));
      Lc : TV_Lexique(1..Nb_Mots("lex/CULTURE-2.txt"));
      Le : TV_Lexique(1..Nb_Mots("lex/ECONOMIE-2.txt"));
      Lt : TV_Lexique(1..Nb_Mots("lex/SCIENCES-2.txt"));
   begin
      Init_Lexique("lex/POLITIQUE-2.txt", Lp);
      Init_Lexique("lex/SPORTS-2.txt", Ls);
      Init_Lexique("lex/CULTURE-2.txt", Lc);
      Init_Lexique("lex/ECONOMIE-2.txt", Le);
      Init_Lexique("lex/SCIENCES-2.txt", Lt);
      
      Sc(Politique) := Score(Dep(Ind), Lp);
      Sc(Sports) := Score(Dep(Ind), Ls);
      Sc(Culture) := Score(Dep(Ind), Lc);
      Sc(Economie) := Score(Dep(Ind), Le);
      Sc(Science) := Score(Dep(Ind), Lt);
   end;
   Affiche(Dep(Ind));
   for I in Sc'Range loop
      Ecrire_Ligne(Image(I) &':'& Image(Sc(I)));
   end loop;
   A_La_Ligne;
   Ecrire_Ligne("Max score :" & Image(Max_Score(Sc)));
end;
