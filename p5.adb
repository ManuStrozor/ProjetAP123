with P_Classification, P_Depeche, P_Lexique, Text_io;
use P_Classification, P_Depeche, P_Lexique, Text_io;  

with Calendar; use Calendar;

procedure P5 is
   TVD : TV_Depeche;
   
   -- TIME --
   Time1, Time2 : Time;
   Annee : year_number;
   Mois : month_number;
   Jour : day_number;
   Sec1, Sec2 : Day_Duration;
begin
   Time1 := Clock;
   
   Charge("txt/test.txt", TVD);
   declare
      Le: TV_Lexique(1..Nb_Mots("lex/ECONOMIE-2.txt"));
      Ls: TV_Lexique(1..Nb_Mots("lex/SPORTS-2.txt"));
      Lc: TV_Lexique(1..Nb_Mots("lex/CULTURE-2.txt"));
      Lp: TV_Lexique(1..Nb_Mots("lex/POLITIQUE-2.txt"));
      Lt: TV_Lexique(1..Nb_Mots("lex/SCIENCES-2.txt"));
   begin
      Init_Lexique("lex/ECONOMIE-2.txt", Le);
      Init_Lexique("lex/SPORTS-2.txt", Ls);
      Init_Lexique("lex/CULTURE-2.txt", Lc);
      Init_Lexique("lex/POLITIQUE-2.txt", Lp);
      Init_Lexique("lex/SCIENCES-2.txt", Lt);
      
      Run(TVD, Lp, Ls, Lc, Le, Lt, "txt/FicRep-2.txt");
   end;
   
   -- TIME --
   Time2 := Clock;
   Split (Time1, Annee, Mois, Jour, Sec1);
   Split (Time2, Annee, Mois, Jour, Sec2);
   Put_Line("Durée:" & Day_Duration'Image(Sec2 - Sec1));
end;
