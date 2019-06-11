with P_Classification, P_Depeche, P_Lexique;
use P_Classification, P_Depeche, P_Lexique;  

procedure P5 is
begin
   declare
      Le: TV_Lexique(1..Nb_Mots("ECONOMIE.txt"));
      Ls: TV_Lexique(1..Nb_Mots("SPORTS.txt"));
      Lc: TV_Lexique(1..Nb_Mots("CULTURE.txt"));
      Lp: TV_Lexique(1..Nb_Mots("POLITIQUE.txt"));
      Lt: TV_Lexique(1..Nb_Mots("ENVIRONNEMENT-SCIENCES.txt"));
      TVD: TV_Depeche; 
   begin
      Charge("depeches.txt", TVD);  
      Init_Lexique("ECONOMIE.txt", Le);
      Init_Lexique("SPORTS.txt", Ls);
      Init_Lexique("CULTURE.txt", Lc);
      Init_Lexique("POLITIQUE.txt", Lp);
      Init_Lexique("ENVIRONNEMENT-SCIENCES.txt", Lt);
      Run(TVD, Lp, Ls, Lc, Le, Lt, "FicRep.txt");
   end;
end P5;   
