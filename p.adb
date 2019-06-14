with P_Classification; use P_Classification;
with P_Generation; use P_Generation;
with P_Depeche; use P_Depeche;
with P_Lexique; use P_Lexique;
with P_String; use P_String;
with Text_Io; use Text_Io;

with Calendar; use Calendar;

procedure P is
   
   type TV_Files is array(T_Categorie) of String(1..30);
   
   F : TV_Files;
   TVD, TVD2 : TV_Depeche;
   
   -- TIME --
   Time1, Time2 : Time;
   Annee : year_number;
   Mois : month_number;
   Jour : day_number;
   Sec1, Sec2 : Day_Duration;
begin
   Time1 := Clock;
   
   Charge("depeches.txt", TVD);
   Charge("test.txt", TVD2);
   
   F := (uTrim("POLITIQUE-2.txt", 30),
	 uTrim("SPORTS-2.txt", 30),
	 uTrim("CULTURE-2.txt", 30),
	 uTrim("ECONOMIE-2.txt", 30),
	 uTrim("SCIENCES-2.txt", 30));
   
   for I in F'range loop
      Generation_Lexique(TVD, I, Trim(F(I)));
   end loop;
   
   declare
      Lp : TV_Lexique(1..Nb_Mots(Trim(F(Politique))));
      Ls : TV_Lexique(1..Nb_Mots(Trim(F(Sports))));
      Lc : TV_Lexique(1..Nb_Mots(Trim(F(Culture))));
      Le : TV_Lexique(1..Nb_Mots(Trim(F(Economie))));
      Lt : TV_Lexique(1..Nb_Mots(Trim(F(Science))));
   begin
      Init_Lexique(Trim(F(Politique)), Lp);
      Init_Lexique(Trim(F(Sports)), Ls);
      Init_Lexique(Trim(F(Culture)), Lc);
      Init_Lexique(Trim(F(Economie)), Le);
      Init_Lexique(Trim(F(Science)), Lt);
      
      Run(TVD2, Lp, Ls, Lc, Le, Ls, "FicRep-2.txt");
   end;
   
   -- TIME --
   Time2 := Clock;
   Split (Time1, Annee, Mois, Jour, Sec1);
   Split (Time2, Annee, Mois, Jour, Sec2);
   Put_Line("Duree:" & Day_Duration'Image(Sec2 - Sec1));
end;
