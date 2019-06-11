with P_Classification, Text_io, P_Depeche, P_Lexique;
use P_Classification, Text_io, P_Depeche, P_Lexique;  

procedure P5 is
begin
   declare
      Le: TV_Lexique(1..Nb_Mots("ECONOMIE.txt"));
      Ls: TV_Lexique(1..Nb_Mots("SPORTS.txt"));
      Lc: TV_Lexique(1..Nb_Mots("CULTURE.txt"));
      Lp: TV_Lexique(1..Nb_Mots("POLITIQUE.txt"));
      Lt: TV_Lexique(1..Nb_Mots("ENVIRONNEMENT-SOCIAL.txt"));
      TVD: TV_Depeche; 
   begin
      Charge("depeches.txt", TVD);  
      Init_Lexique("ECONOMIE.txt", Le);
      Init_Lexique("SPORTS.txt", Ls);
      Init_Lexique("CULTURE.txt", Lc);
      Init_Lexique("POLITIQUE.txt", Lp);
      Init_Lexique("ENVIRONNEMENT-SOCIAL.txt", Lt);
      Run(TVD;Le,Ls,Lc,Lp,Lt;"fichierréponse");
   end;
end P5;   
