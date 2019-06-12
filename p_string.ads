package P_String is
   
   function uTrim(Str : in String; Ln : in Integer) return String;
   -- {} => {Ajoute des espaces à la fin de Str pour un total de Ln characteres dans Str}
   
   function Trim(Str : in String) return String;
   -- {} => {Retire les espaces à la fin de Str}
   
end;
