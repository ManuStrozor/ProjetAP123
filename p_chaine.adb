package body P_chaine is
   
   function Index(C : in Character; S : in String) return Integer is
      -- retourne la position de C dans S
      I : Integer := 1;
   begin
      while I < S'Length and then S(I) /= C loop
         I := I + 1;
      end loop;
      
      if I = S'Length then
	 return -1;
      else
	 return I;
      end if;
   end;
   
   function Indexseparateur(S : in String; D : in Natural) return Integer is
      -- retourne la position du prochain caractère séparateur dans S à partir de la position D
      -- Les caractères séparateurs sont ' ',':','.','?',''','"','(',')',','
      I : Natural := D;
   begin
      while I < S'Length and then (S(I) /= ' ' and S(I) /= ':' and S(I) /= '.' and S(I) /= '?' and S(I) /= ''' and S(I) /= '"' and S(I) /= '(' and S(I) /= ')' and S(I) /= ',') loop
         I := I + 1;
      end loop;
      
      if I = S'Length then
	 return -1;
      else
	 return I; 
      end if;  
   end;
   
   function Minuscule(C : Character) return Character is
      -- c caractere quelconque
      -- si c est une lettre majuscule delivre la minuscule correspondante
      -- sinon delivre c
      Ecart : constant Integer := Character'Pos('a') - Character'Pos('A');  
   begin
      if C in 'A'..'Z' then
         return Character'Val(Character'Pos(C) + Ecart);
      else
         return C;
      end if;
   end;
   
   procedure Minuscule(S : in out String) is
      -- modifie S en changeant toutes les majuscules en minuscules   
   begin
      for I in S'range loop
         S(I) := Minuscule(S(I));
      end loop;   
   end;
   
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
