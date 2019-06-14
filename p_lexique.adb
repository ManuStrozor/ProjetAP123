package body P_Lexique is
   
   function Nb_Mots(Nomfic : in String) return Integer is
   -- {} => {résultat = nombre de lignes du fichier Nomfic et donc de mots dans le lexique correspondant}
      F : Text_Io.File_type;
      Str : String(1..32);
      Ln, Nb : Integer := 0;
   begin
      Open(F, In_File, Nomfic);
      while not End_Of_File(F) loop
	 Get_Line(F, Str, ln);
	 if Ln /= 32 and Ln > 0 then
	    Nb := Nb + 1;
	 end if;
      end loop;
      Close(F);
      return Nb;
   end;
   
   procedure Init_Lexique(Nomfic: in String; L : out Tv_lexique) is
   -- {On suppose que la taille du vecteur L correspond exactement au nombre de mots contenus dans le fichier}
   -- => {Range dans le vecteur L, les mots contenus dans le fichier lexique Nomfic et les poids associés}
      F : Text_Io.File_Type;
      Str : String(1..40);
      Ind : Integer;
      Ln, I : Integer := L'first;
   begin
      Open(F, In_File, NomFic);
      L := (others => ((others => ' '), 1));
      while not End_Of_File(F) loop
	 Get_Line(F, Str, ln);
	 Ind := Index(':', Str);
	 L(I).Chaine(1..Ind-1) := Str(1..Ind-1);
	 L(I).Poids := Integer'Value(Str(Ind+2..Ind+2));
	 I := I + 1;
      end loop;
      Close(F);
   end;
   
   function Poids_Mot(M : in String; L : in Tv_lexique) return Integer is
    -- {} => {résultat = le poids de M dans le lexique L et 0 si le mot n'est pas présent dans le lexique}
      I : Integer := L'First;
   begin
      while I <= L'Last and then L(I).Chaine(1..M'length) /= M loop
	 I := I + 1;
      end loop;
      if I = L'Last+1 then
	 return 0;
      else
	 return L(I).Poids;
      end if;
   end;
   
end;
