with P_Classification, Text_Io, P_Lexique;
use P_Classification, Text_Io, P_Lexique;  

procedure P2 is
   Rep : String(1..30);
   QUIT : String(1..30) := ('q', others => ' ');
   Ln : Integer;
begin
   declare
      Ls : TV_Lexique(1..Nb_Mots("lex/SPORTS.txt"));
   begin
      Init_Lexique("lex/SPORTS.txt", Ls);
      loop
	 Put("Saisir un mot qui est dans le lexique SPORTS: ");
	 Get_Line(Rep, Ln);
	 exit when Rep = QUIT;
	 Put_line("Poids du mot " & Rep(1..Ln) & ": " & Integer'Image(Poids_Mot(Rep(1..Ln), Ls)));
      end loop;
   end;
end;
