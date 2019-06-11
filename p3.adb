with P_Classification, Text_io, P_Depeche, P_Lexique;
use P_Classification, Text_io, P_Depeche, P_Lexique;  

procedure P3 is
begin
   declare
      L: TV_Lexique(1..Nb_Mots("ECONOMIE.txt"));
      TVD: TV_Depeche; 
   begin
      Init_Lexique("ECONOMIE.txt", L);
      Charge("depeches.txt", TVD);
      for I in TVD'Range loop
	 if TVD(I).Cat = Economie then 
	    Put_line("Le score pour la dépêche"&TVD(I).Id&": "&Integer'image(Score(TVD(I),L)));
	 end if;
      end loop;
   end;
end P3;   
