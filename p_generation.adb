package body p_generation is
   
   function Recherche(VM: in Tv_Dico; N: in Integer; M: in String) return Integer is
      -- {} => {Resultat= Indice Du Mot M Dans Le Vecteur VM Si Il Est Présent Et -1 Sinon. N Est Le Nombre De Mots Rangés Dans Le vecteur}
      I : Integer := VM'first;
   begin
      while I < VM'First+N and then VM(I).Mot /= M loop
	 I := I + 1;
      end loop;
      if I >= VM'First+N then
	 return -1;
      else
	 return I;
      end if;
   end;
   
   procedure Calcul_Scores(VD : in Tv_Depeche; C : in T_Categorie; VM : in out Tv_Dico; N : in Integer) is
      -- {} => {Cette procédure met à jour les scores des différents mots présents dans VM. Lorsqu'un mot présent dans VM apparaît dans une dépêche du vecteur VD,
      -- son score est décrémenté si la dépêche n'est pas dans la catégorie C
      --            et incrémenté si la dépêche       est dans la catégorie C}
      Indice : Integer;
   begin
      for I in VD'Range loop
	 for J in VD(i).Texte'Range loop
	    Indice := Recherche(VM, N, VD(I).Texte(J));
	    if Indice /= -1 and VD(I).Cat = C then
	       VM(Indice).Score := VM(Indice).Score + 1;
	    elsif Indice /= -1 and VD(I).Cat /= C then
	       VM(Indice).Score := VM(Indice).Score - 1;
	    end if;
	 end loop;
      end loop;      
   end;
   
end p_generation;
