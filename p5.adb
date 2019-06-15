with P_Classification, P_Depeche, P_Lexique;
use P_Classification, P_Depeche, P_Lexique;  

procedure P5 is
   TVD : TV_Depeche;
begin
   Charge("txt/depeches.txt", TVD);
   declare
      Le: TV_Lexique(1..Nb_Mots("lex/ECONOMIE.txt"));
      Ls: TV_Lexique(1..Nb_Mots("lex/SPORTS.txt"));
      Lc: TV_Lexique(1..Nb_Mots("lex/CULTURE.txt"));
      Lp: TV_Lexique(1..Nb_Mots("lex/POLITIQUE.txt"));
      Lt: TV_Lexique(1..Nb_Mots("lex/SCIENCES.txt"));
   begin
      Init_Lexique("lex/ECONOMIE.txt", Le);
      Init_Lexique("lex/SPORTS.txt", Ls);
      Init_Lexique("lex/CULTURE.txt", Lc);
      Init_Lexique("lex/POLITIQUE.txt", Lp);
      Init_Lexique("lex/SCIENCES.txt", Lt);
      
      Run(TVD, Lp, Ls, Lc, Le, Lt, "txt/FicRep.txt");
   end;
end;
