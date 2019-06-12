with P_Generation; use P_Generation;
with P_Classification; use P_Classification;
with P_Depeche; use P_Depeche;
with P_Lexique; use P_Lexique;
with P_Esiut; use P_Esiut;
with Text_Io; use Text_Io;

procedure P7 is
   TVD : TV_Depeche;
   Dico : TV_Dico;
   Nb : Integer := 0;
   Moy : Float;
   Max, Min : Integer;
begin
   Charge("depeches.txt", TVD);
   Init_Dico(TVD, Sports, Dico, Nb);
   Calcul_Scores(TVD, Sports, Dico, Nb);
   for I in Dico'First..Nb loop
      Put_Line(Integer'Image(I) & ' ' & Dico(I).Mot &':'& Integer'Image(Dico(I).Score));
   end loop;
   A_La_Ligne;
   Infos_Score(Dico, Nb, Moy, Max, Min);
   Ecrire_Ligne("Moy : " & Image(Moy));
   Ecrire_Ligne("Max : " & Image(Max));
   Ecrire_Ligne("Min : " & Image(Min));
end;
