with P_Generation; use P_Generation;
with P_Classification; use P_Classification;
with P_Depeche; use P_Depeche;
with P_Lexique; use P_Lexique;
with Text_Io; use Text_Io;

procedure P7 is
   TVD : TV_Depeche;
   Dico : TV_Dico;
   Nb : Integer := 0;
begin
   Charge("depeches.txt", TVD);
   declare
      Ls : TV_Lexique(1..Nb_Mots("SPORTS.txt"));
   begin
      Init_Lexique("SPORTS.txt", Ls);
      Init_Dico(TVD, Sports, Dico, Nb);
      Calcul_Scores(TVD, Sports, Dico, Nb);
      for I in Dico'First..Nb loop
	 Put_Line(Integer'Image(I) & ' ' & Dico(I).Mot &':'& Integer'Image(Dico(I).Score));
      end loop;
   end;
end;
