package body P_chaine is
     
   function Index(C: in Character;S : in String) return Integer is
      -- retourne la position de C dans S
      I:integer;
   begin
      I:=1;
      while ((I <S'Length) and then (S(I)/=C)) loop
         I:=I+1;
         end loop;
      if I=S'Length then return -1; 
      else begin return I; end;
      end if;  
   end Index;
   
       --------------------------------------------------------------------
   function Minuscule (C : Character ) return Character is 
      -- c caractere quelconque
      -- si c est une lettre majuscule delivre la minuscule correspondante
      -- sinon delivre c
      Ecart : constant Integer := Character'Pos ('a') - Character'Pos ('A');  
   begin
      if C in 'A'..'Z'
            then
         return Character'Val(Character'Pos(C) + Ecart);
      else
         return C;
      end if;
   end Minuscule;
   
   procedure Minuscule (S: in out String) is
      -- modifie S en changeant toutes les majuscules en minuscules   
   begin
         for I in S'range loop
         S(I) := Minuscule(S(I));
      end loop;   
   end Minuscule;


   

   function Indexseparateur(S : in String;D : in Natural) return Integer is
      -- retourne la position du prochain caractère séparateur dans S à partir de la position D
      -- Les caractères séparateurs sont ' ',':','.','?',''','"','(',')',','
      I:natural;
   begin
      I:=D;
      while ((I <S'Length) and then ((S(I)/=' ') and  (S(I)/=':') and  (S(I)/='.') and  (S(I)/='?')and  (S(I)/=''') and  (S(I)/='"') and  (S(I)/='(') and  (S(I)/=')') and (S(I)/=',')))loop
         I:=I+1;
      end loop;
      if (I=S'Length) then begin return -1; end;
      else  return I; 
      end if;  
   end Indexseparateur;

   
   end p_chaine;

