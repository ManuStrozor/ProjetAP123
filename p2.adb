with P_Depeche; use P_Depeche, P_Depeche.P_CategorieIO;
with P_Classification; use P_Classification;
with P_Lexique; use P_Lexique;
with P_Chaine; use P_Chaine;
with P_Esiut; use P_Esiut;
with Text_Io; use Text_Io;

procedure P2 is
   
   type TV_Files is array(T_Categorie) of String(1..30);
   
   F : TV_Files;
   Rep : String(1..30);
   Cat : T_Categorie;
   QUIT : String(1..30) := ('q', others => ' ');
   Ln : Integer;
begin
   Ecrire("Categorie: "); Lire(Cat);
   
   F := (uTrim("lex/POLITIQUE-2.txt", 30),
	 uTrim("lex/SPORTS-2.txt", 30),
	 uTrim("lex/CULTURE-2.txt", 30),
	 uTrim("lex/ECONOMIE-2.txt", 30),
	 uTrim("lex/SCIENCES-2.txt", 30));
   
   declare
      L : TV_Lexique(1..Nb_Mots(Trim(F(Cat))));
   begin
      Init_Lexique(Trim(F(Cat)), L);
      loop
	 Ecrire("Saisir un mot qui est dans le lexique " & Image(Cat) & ": "); Lire(Rep);
	 exit when Rep = QUIT;
	 Ecrire_ligne("Poids du mot " & Trim(Rep) & ": " & Image(Poids_Mot(Trim(Rep), L)));
      end loop;
   end;
end;
