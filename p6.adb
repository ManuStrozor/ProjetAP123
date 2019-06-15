with P_Generation; use P_Generation;
with P_Classification; use P_Classification;
with P_Depeche; use P_Depeche;
with P_Lexique; use P_Lexique;
with Text_Io; use Text_Io;

procedure P6 is
   TVD : TV_Depeche;
   Dico : TV_Dico;
   Nb : Integer := 0;
begin
   Charge("txt/depeches.txt", TVD);
   Init_Dico(TVD, Sports, Dico, Nb);
   for I in Dico'First..Nb loop
      Put_Line(Integer'Image(I) &' '& Dico(I).Mot &':'& Integer'Image(Dico(I).Score));
   end loop;
end;
