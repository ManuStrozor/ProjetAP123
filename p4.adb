with P_Classification; use P_Classification;
with P_Lexique; use P_Lexique;
with P_Depeche; use P_Depeche, P_Depeche.P_CategorieIO;
with P_Esiut; use P_Esiut;

procedure P4 is
   Dep : TV_Depeche;
   Sc : TV_Score;
begin
   Charge("depeches.txt", Dep);
   
   declare
      Lp : TV_Lexique(1..Nb_Mots("POLITIQUE.txt"));
      Ls : TV_Lexique(1..Nb_Mots("SPORTS.txt"));
      Lc : TV_Lexique(1..Nb_Mots("CULTURE.txt"));
      Le : TV_Lexique(1..Nb_Mots("ECONOMIE.txt"));
      Lt : TV_Lexique(1..Nb_Mots("ENVIRONNEMENT-SCIENCES.txt"));
   begin
      Init_Lexique("POLITIQUE.txt", Lp);
      Init_Lexique("SPORTS.txt", Ls);
      Init_Lexique("CULTURE.txt", Lc);
      Init_Lexique("ECONOMIE.txt", Le);
      Init_Lexique("ENVIRONNEMENT-SCIENCES.txt", Lt);
      Sc(Politique) := Score(Dep(1), Lp);
      Sc(Sports) := Score(Dep(1), Ls);
      Sc(Culture) := Score(Dep(1), Lc);
      Sc(Economie) := Score(Dep(1), Le);
      Sc(Science) := Score(Dep(1), Lt);
   end;
   
   Affiche(Dep(1));
   
   for I in Sc'Range loop
      Ecrire_Ligne("Score " & Image(I) & " :" & Image(Sc(I)));
   end loop;
   
   A_La_Ligne;
   
   Ecrire_Ligne("Max score :" & Image(Max_Score(Sc)));
end;
