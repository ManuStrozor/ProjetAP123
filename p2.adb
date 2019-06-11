with P_Classification, Text_Io, P_Lexique;
use P_Classification, Text_Io, P_Lexique;  

procedure P2 is
   Rep : String(1..30);
   QUIT : String(1..30) := ('q', others => ' ');
   Ln : Integer;
begin
   declare
      Lp : TV_Lexique(1..Nb_Mots("POLITIQUE.txt"));
   begin
      Init_Lexique("POLITIQUE.txt", Lp);
      
      loop
	 Put("Saisir un mot qui est dans le lexique POLITIQUE: ");
	 Get_Line(Rep, Ln);
	 exit when Rep = QUIT;
	 Put_line("Le poids du mot " & Rep(1..Ln) & ": " & Integer'Image(Poids_Mot(Rep(1..Ln), Lp)));
      end loop;
   end;
end;   
