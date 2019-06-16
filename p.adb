with P_Classification; use P_Classification;
with P_Generation; use P_Generation;
with P_Depeche; use P_Depeche;
with P_Lexique; use P_Lexique;
with P_Chaine; use P_Chaine;
with Text_Io; use Text_Io;

with Calendar; use Calendar;

procedure P is
   
   E_EMPTYLEX : exception;
   type TV_Files is array(T_Categorie) of String(1..30);
   
   F : TV_Files;
   TVD, TVT : TV_Depeche;
   
   -- TIME --
   T1, T2 : Time;
   A : year_number;
   M : month_number;
   J : day_number;
   S1, S2 : Day_Duration;
begin
   T1 := Clock;
   
   Charge("txt/depeches.txt", TVD);
   Charge("txt/test.txt", TVT);
   
   F := (uTrim("lex/POLITIQUE-2.txt", 30),
	 uTrim("lex/SPORTS-2.txt", 30),
	 uTrim("lex/CULTURE-2.txt", 30),
	 uTrim("lex/ECONOMIE-2.txt", 30),
	 uTrim("lex/SCIENCES-2.txt", 30));
   
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
      
      If Lp'length /= 0 AND Ls'length /= 0 AND Lc'length /= 0 AND Le'length /= 0 AND Lt'length /= 0 then
	 Run(TVT, Lp, Ls, Lc, Le, Lt, "txt/FicRep-2.txt");
      Else
	 Raise E_EMPTYLEX;
      End if;
   end;
   
   -- TIME --
   T2 := Clock;
   Split(T1, A, M, J, S1);
   Split(T2, A, M, J, S2);
   Put_Line("Durée:" & Day_Duration'Image(S2-S1));

exception
   when E_EMPTYLEX =>
      for I in T_Categorie loop
	 if Nb_Mots(Trim(F(I))) = 0 then
	    Put_Line("Le lexique "&Trim(F(I))&" est vide");
	 end if;
      end loop;
end;
