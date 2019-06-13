with P_Generation; use P_Generation;
with P_Classification; use P_Classification;
with P_Depeche; use P_Depeche;
with P_Lexique; use P_Lexique;
with Text_Io; use Text_Io;
with P_String; use P_String;

procedure P8 is
   
   type TV_Files is array(T_Categorie) of String(1..30);
   
   F : TV_Files := (uTrim("POLITIQUE-2.txt", 30),
			uTrim("SPORTS-2.txt", 30),
			uTrim("CULTURE-2.txt", 30),
			uTrim("ECONOMIE-2.txt", 30),
			uTrim("SCIENCES-2.txt", 30));
   
   TVD : TV_Depeche;
   Dico : TV_Dico;
   Nb : Integer := 0;
begin
   Charge("depeches.txt", TVD);
   
   for I in F'range loop
      Generation_Lexique(TVD, I, Trim(F(I)));
   end loop;
end;
