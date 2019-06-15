with P_Classification; use P_Classification;
with P_Lexique; use P_Lexique;
with P_Depeche; use P_Depeche, P_Depeche.P_CategorieIO;
with P_Esiut; use P_Esiut;

procedure P4 is
   Dep : TV_Depeche;
   Sc : TV_Score;
   Ind : Integer;
begin
   Charge("txt/depeches.txt", Dep);
   loop
      Ecrire("Dépèche numéro :"); Lire(Ind);
      exit when Ind >= 1 and Ind <= 500;
   end loop;
   declare
      Lp : TV_Lexique(1..Nb_Mots("lex/POLITIQUE.txt"));
      Ls : TV_Lexique(1..Nb_Mots("lex/SPORTS.txt"));
      Lc : TV_Lexique(1..Nb_Mots("lex/CULTURE.txt"));
      Le : TV_Lexique(1..Nb_Mots("lex/ECONOMIE.txt"));
      Lt : TV_Lexique(1..Nb_Mots("lex/SCIENCES.txt"));
   begin
      Init_Lexique("lex/POLITIQUE.txt", Lp);
      Init_Lexique("lex/SPORTS.txt", Ls);
      Init_Lexique("lex/CULTURE.txt", Lc);
      Init_Lexique("lex/ECONOMIE.txt", Le);
      Init_Lexique("lex/SCIENCES.txt", Lt);
      
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
