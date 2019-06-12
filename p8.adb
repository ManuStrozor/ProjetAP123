with P_Generation; use P_Generation;
with P_Classification; use P_Classification;
with P_Depeche; use P_Depeche;
with P_Lexique; use P_Lexique;
with Text_Io; use Text_Io;

procedure P8 is
   TVD : TV_Depeche;
   Dico : TV_Dico;
   Nb : Integer := 0;
begin
   Charge("depeches.txt", TVD);
   
   Init_Dico(TVD, Politique, Dico, Nb);
   Calcul_Scores(TVD, Politique, Dico, Nb);
   Generation_Lexique(TVD, Politique, "POLITIQUE-2.txt");
   
   Init_Dico(TVD, Sports, Dico, Nb);
   Calcul_Scores(TVD, Sports, Dico, Nb);
   Generation_Lexique(TVD, Sports, "SPORTS-2.txt");
   
   Init_Dico(TVD, Culture, Dico, Nb);
   Calcul_Scores(TVD, Culture, Dico, Nb);
   Generation_Lexique(TVD, Culture, "CULTURE-2.txt");
   
   Init_Dico(TVD, Economie, Dico, Nb);
   Calcul_Scores(TVD, Economie, Dico, Nb);
   Generation_Lexique(TVD, Economie, "ECONOMIE-2.txt");
   
   Init_Dico(TVD, Science, Dico, Nb);
   Calcul_Scores(TVD, Science, Dico, Nb);
   Generation_Lexique(TVD, Science, "ENVIRONNEMENT-SCIENCES-2.txt");
end;
