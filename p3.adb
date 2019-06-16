with P_Classification, Text_io, P_Depeche, P_Lexique;
use P_Classification, Text_io, P_Depeche, P_Lexique;  

procedure P3 is
   TVD : TV_Depeche;
begin
   Charge("txt/depeches.txt", TVD);
   declare
      Ls : TV_Lexique(1..Nb_Mots("lex/SPORTS-2.txt"));
   begin
      Init_Lexique("lex/SPORTS-2.txt", Ls);
      for I in TVD'Range loop
	 if TVD(I).Cat = Sports then 
	    Put_Line(TVD(I).Id & ':' & Integer'Image(Score(TVD(I), Ls)));
	 end if;
      end loop;
   end;
end;
