with P_Classification, P_Depeche, P_Lexique;
use P_Classification, P_Depeche, P_Lexique;  

procedure P52 is
   TVD : TV_Depeche; 
begin
   Charge("test.txt", TVD);
   
   declare
      Le: TV_Lexique(1..Nb_Mots("ECONOMIE-2.txt"));
      Ls: TV_Lexique(1..Nb_Mots("SPORTS-2.txt"));
      Lc: TV_Lexique(1..Nb_Mots("CULTURE-2.txt"));
      Lp: TV_Lexique(1..Nb_Mots("POLITIQUE-2.txt"));
      Lt: TV_Lexique(1..Nb_Mots("SCIENCES-2.txt"));
   begin
      Init_Lexique("ECONOMIE-2.txt", Le);
      Init_Lexique("SPORTS-2.txt", Ls);
      Init_Lexique("CULTURE-2.txt", Lc);
      Init_Lexique("POLITIQUE-2.txt", Lp);
      Init_Lexique("SCIENCES-2.txt", Lt);
      
      Run(TVD, Lp, Ls, Lc, Le, Lt, "FicRep-2.txt");
   end;
end;   
