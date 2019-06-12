package body P_String is
   
   function uTrim(Str : in String; Ln : in Integer) return String is
      -- {} => {Ajoute des espaces à la fin de Str pour un total de Ln characteres dans Str}
      Tmp : String(1..Ln-Str'Length) := (others => ' ');
   begin
      return Str & Tmp;
   end;
   
   function Trim(Str : in String) return String is
      -- {} => {Retire les espaces à la fin de Str}
      I : Integer := Str'First;
   begin
      while I <= Str'Last and then Str(I) /= ' ' loop
	 I := I + 1;
      end loop;
      return Str(Str'first..I-1);
   end;
   
end;
