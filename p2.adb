with P_Classification, Text_io, P_Depeche, P_Lexique;
use P_Classification, Text_io, P_Depeche, P_Lexique;  

procedure P2 is
begin
   declare
      L: TV_Lexique(1..Nb_Mots("ECONOMIE.txt"));
   begin
      Init_Lexique("ECONOMIE.txt", L);
      for I in L'Range loop
	 Put_line("Le poids du mot"&L(I).chaine&": "&Integer'Image(Poids_Mot(L(I).Chaine,L)));
      end loop;
   end;
end P2;   
