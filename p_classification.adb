package body P_Classification is
   
   function Score(D: in TR_Depeche; L : in TV_Lexique) return Integer is
      -- {} => { Résultat = Score De La Dépêche D Pour La Catégorie Dont Le Lexique Est L}
      function RechmotdansL(mot: in string; L : in TV_Lexique) return natural is
	 -- {L non trié},=> {résultat = indice si L contient le mot}
	 I : Integer:= L'first;
      begin
	 while I < L'Last+1 and then L(I).chaine < mot loop
	    I := I + 1;
	 end loop;
	 return I;
      end RechmotdansL;
      Total: Integer:=0;
      Indice: Natural;
   begin
      for I in D.Texte'Range loop
	 Indice:=RechmotdansL(D.Texte(I),L);
	 if Indice/=L'Last+1 then 
	    total:=total+L(Indice).poids;
	 end if;
      end loop;
      return total;
   end Score;
   
   end P_Classification;
