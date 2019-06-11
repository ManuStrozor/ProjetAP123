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
   
   procedure Init_Dico(VD: in Tv_Depeche; C: in T_Categorie; VM: out Tv_Dico; N: out Integer) is
      -- {} => {Charge Dans VM Tous Les Mots Présents Dans Au Moins Une Dépêche De La Catégorie C Du Vecteur De Dépêches VD. Attention, Même Si Le Mot Est Présent Plusieurs Fois, Il Ne Doit Apparaître Qu'Une Fois Dans Le Vecteur VM. La Procédure Initialise Aussi Tous Les Scores À 0 Et range Dans N Le Nombre De Mots Ajoutés Dans VM }
   begin
      VM := (others => ((others => ' '), 0));
      N := 0;
      for I in VD'Range loop
	 if VD(I).Cat = C then
	    for J in VD(I).Texte'Range loop
	       if Recherche(VM, N, VD(I).Texte(J)) = -1 and N < VM'last then
		  VM(VM'First+N).Mot := VD(I).Texte(J);
		  N := N + 1;
	       end if;
	    end loop;
	 end if;
      end loop;
   end;
   
   procedure Calcul_Scores(VD : in Tv_Depeche; C : in T_Categorie; VM : in out Tv_Dico; N : in Integer) is
      -- {} => {Cette procédure met à jour les scores des différents mots présents dans VM. Lorsqu'un mot présent dans VM apparaît dans une dépêche du vecteur VD,
      -- son score est décrémenté si la dépêche n'est pas dans la catégorie C
      --            et incrémenté si la dépêche       est dans la catégorie C}
      Indice : Integer;
   begin
      for I in VD'Range loop
	 if VD(I).Cat = C then
	    for J in VD(I).Texte'Range loop
	       Indice := Recherche(VM, N, VD(I).Texte(J));
	       if Indice /= -1 then
		  VM(Indice).Score := VM(Indice).Score + 1;
	       end if;
	    end loop;
	 else
	    for J in VD(I).Texte'Range loop
	       Indice := Recherche(VM, N, VD(I).Texte(J));
	       if Indice /= -1 then
		  VM(Indice).Score := VM(Indice).Score - 1;
	       end if;
	    end loop;
	 end if;
      end loop;      
   end;
   
   function Poids_Score(S : in Integer) return Integer is
      -- {} => {resultat = valeur du poids à attribuer étant donné un score S}
   begin
      if S > 12 then
	 return 3;
      elsif S > 6 then
	 return 2;
      elsif S > 0 then
	 return 1;
      else
	 return 0;
      end if;
   end;
   
end p_generation;
