--g)

with P_Classification, Text_io, P_Lexique;
use P_Classification, Text_io, P_Lexique;  

procedure P2 is
   mot: String(1..30);
   Nbcar: Natural:=0;
begin
   declare
      L: TV_Lexique(1..Nb_Mots("POLITIQUE.txt"));
      I: Integer:= L'First;
   begin
      Init_Lexique("POLITIQUE.txt", L);
      Put("Saisir un mot qui est dans le lexique POLITIQUE: ");
      Get_Line(Mot(1..Nbcar),Nbcar);
      --  while I<L'Last+1 and then Mot<L(I).Chaine loop
      --  	 I:=I+1;
      --  end loop;
      Put_line("Le poids du mot "&mot&": "&Integer'Image(Poids_Mot(L(I).Chaine,L)));
   end;
end P2;   
