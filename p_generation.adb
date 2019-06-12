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
      if S > 2 then
	 return 3;
      elsif S > 1 then
	 return 2;
      elsif S > 0 then
	 return 1;
      else
	 return 0;
      end if;
   end;
   
   procedure Generation_Lexique (VD: in Tv_Depeche; C : in T_Categorie; Fl: in String) is
     --   {} => {Cette Procédure Créé Pour La Catégorie C Le Fichier Lexique De Nom Fl À Partir Du Vecteur De Dépêches De Nom VD. Cette Procédure Doit Déclarer Un Vecteur De type TV_Dico Puis Le Remplir En Utilisant Init_Dico, Puis Calcul_Scores Et Enfin Utiliser Le Vecteur Résultant Pour Créer Un Fichier Lexique En Utilisant La Fonction Poids_Score}
     F : File_Type;
     VM : TV_Dico;
     N : Integer := 0;
   begin
      Create(F, Out_File, Fl);
      Init_Dico(Vd, C, VM, N);
      Calcul_Scores(VD, C, VM, N);
      for I in Vm'First..N loop
         if VM(I).Score > 0 then
            Put_line(F, Vm(I).Mot & ":" & Integer'Image(Poids_Score(Vm(I).Score)));
         end if;
      end loop;
   end;
   
end p_generation;
