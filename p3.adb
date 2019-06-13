with P_Classification, Text_io, P_Depeche, P_Lexique;
use P_Classification, Text_io, P_Depeche, P_Lexique;  

procedure P3 is
   TVD: TV_Depeche;
begin
   Charge("depeches.txt", TVD);
   
   declare
      Ls : TV_Lexique(1..Nb_Mots("SPORTS.txt"));
   begin
      Init_Lexique("SPORTS.txt", Ls);
      
      for I in TVD'Range loop
	 if TVD(I).Cat = Sports then 
	    Put_line("Le score pour la dépêche" & TVD(I).Id & ": " & Integer'image(Score(TVD(I), Ls)));
	 end if;
      end loop;
   end;
end;
