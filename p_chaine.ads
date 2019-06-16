package P_Chaine is
   
   subtype String600 is String(1..600);
   
   type TR_Chaine_Longue is record
      Ch : String600;
      Long : integer;
   end record;
   
   function Index(C : in Character; S : in String) return Integer;
   
   function IndexSeparateur(S : in String; D : in natural) return Integer;
   
   function Minuscule(C : Character) return Character;
   
   procedure Minuscule(S : in out String);
   
   function uTrim(Str : in String; Ln : in Integer) return String;
   -- {} => {Ajoute des espaces à la fin de Str pour un total de Ln characteres dans Str}
   
   function Trim(Str : in String) return String;
   -- {} => {Retire les espaces à la fin de Str}
   
end;
