with P_Classification; use P_Classification;
with P_Generation; use P_Generation;
with P_Depeche; use P_Depeche;
with P_Lexique; use P_Lexique;
with P_Chaine; use P_Chaine;
with Text_Io; use Text_Io;

with Calendar; use Calendar;

procedure P8 is
   
   type TV_Files is array(T_Categorie) of String(1..30);
   
   F : TV_Files;
   TVD : TV_Depeche;
   
   -- TIME --
   Time1, Time2 : Time;
   Annee : year_number;
   Mois : month_number;
   Jour : day_number;
   Sec1, Sec2 : Day_Duration;
begin
   Time1 := Clock;
   
   Charge("txt/depeches.txt", TVD);
   
   F := (uTrim("lex/POLITIQUE-2.txt", 30),
	 uTrim("lex/SPORTS-2.txt", 30),
	 uTrim("lex/CULTURE-2.txt", 30),
	 uTrim("lex/ECONOMIE-2.txt", 30),
	 uTrim("lex/SCIENCES-2.txt", 30));
   
   for I in F'range loop
      Generation_Lexique(TVD, I, Trim(F(I)));
   end loop;
   
   -- TIME --
   Time2 := Clock;
   Split (Time1, Annee, Mois, Jour, Sec1);
   Split (Time2, Annee, Mois, Jour, Sec2);
   Put_Line("Durée:" & Day_Duration'Image(Sec2 - Sec1));
   
end;
