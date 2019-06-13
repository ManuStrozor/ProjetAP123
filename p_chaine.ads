package P_Chaine is
   
      subtype String600 is String(1..600);
   
      type TR_Chaine_Longue is record
         Ch : String600;
         Long : integer;
      end record;
      
      
      function Index(C: in Character;S : in String) return Integer;
      
      function IndexSeparateur(S : in String; d : in natural) return Integer;
   
      function Minuscule (C : Character ) return Character;
      
      procedure Minuscule (s: in out String);
	                  
end p_chaine;
