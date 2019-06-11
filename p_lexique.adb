package body P_Lexique is
   
   function Nb_Mots(Nomfic : in String) return Integer is
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
   
   function Trim(Str : in String; Ln : in Integer) return String is
      Tmp : String(1..Ln-Str'Length) := (others => ' ');
   begin
      return Str & Tmp;
   end;
   
   procedure Init_Lexique(Nomfic: in String; L : out Tv_lexique) is
      F : Text_Io.File_Type;
      Str : String(1..32);
      Ln, I : Integer := L'first;
   begin
      Open(F, In_File, NomFic);
      while not End_Of_File(F) loop
	 Get_Line(F, Str, ln);
	 L(I).chaine := Trim(Str(1..Ln-2), 30);
	 L(I).Poids := Integer'Value(Str(Ln..Ln));
	 I := I + 1;
      end loop;
      Close(F);
   end;
   
   function Poids_Mot(M : in String; L : in Tv_lexique) return Integer is
      I : Integer := L'First;
   begin
      while I <= L'Last and then L(I).Chaine /= M loop
	 I := I + 1;
      end loop;
      if I = L'Last+1 then
	 return 0;
      else
	 return L(I).Poids;
      end if;
   end;
   
end;
