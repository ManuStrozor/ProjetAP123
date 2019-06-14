package body p_generation is
   
   function Recherche(VM : in out TV_Dico; N: in Integer; M : in string) return Integer is
      --{VM trié, non vide} => {résultat = indice de la première occurrence de val si val = V'Last + 1 sinon}
      Me, Inf, Sup : Integer;
   begin
      if N > 0 and then VM(N).Mot < M then
   	 return -1;
      else
   	 Inf := VM'First; Sup := VM'First+N;
   	 while Inf < Sup loop
   	    Me := (Inf + Sup) / 2 ;
   	    if VM(Me).mot >= M then
   	       Sup := Me;
   	    else
   	       Inf := Me + 1;
   	    end if;
   	 end loop;
   	 if VM(Sup).Mot = M then 
   	    return Sup;
   	 else 
   	    return -1;
   	 end if;
      end if;
   end;
   
   procedure Insert_Dico(VM : out TV_Dico; N : in out Integer; Mot : in String) is
      -- {} => {Insert Mot dans VM de facon à ce que le dico soit toujours trié, si Mot est dejà présent dans VM, il n'est pas inséré}
      I : Integer := VM'First;
   begin
      while I <= N and then Mot > VM(I).Mot loop
	 I := I + 1;
      end loop;
      if Mot > VM(I).Mot then
	 VM(I).Mot := Mot;
	 N := N + 1;
      elsif Mot < VM(I).Mot and N < VM'Last then
	 VM(I+1..N+1) := VM(I..N);
	 VM(I).Mot := Mot;
	 N := N + 1;
      end if;
   end;
   
   procedure Init_Dico(VD: in Tv_Depeche; C: in T_Categorie; VM: out Tv_Dico; N : in out Integer) is
      -- {} => {Charge Dans VM Tous Les Mots Présents Dans Au Moins Une Dépêche De La Catégorie C Du Vecteur De Dépêches VD. Attention, Même Si Le Mot Est Présent Plusieurs Fois, Il Ne Doit Apparaître Qu'Une Fois Dans Le Vecteur VM. La Procédure Initialise Aussi Tous Les Scores À 0 Et range Dans N Le Nombre De Mots Ajoutés Dans VM }
      I : Integer := VD'First;
   begin
      VM := (others => ((others => ' '), 0));
      while I <= VD'Last and then VD(I).Cat /= C loop
	 I := I + 1;
      end loop;
      while I <= VD'Last and then VD(I).Cat = C loop
	 for J in VD(I).Texte'First..VD(I).Nbmots loop
	    Insert_Dico(VM, N, VD(I).Texte(J));
	 end loop;
	 I := I + 1;
      end loop;
   end;
   
   procedure Calcul_Scores(VD : in Tv_Depeche; C : in T_Categorie; VM : in out Tv_Dico; N : in Integer) is
      -- {} => {Cette procédure met à jour les scores des différents mots présents dans VM. Lorsqu'un mot présent dans VM apparaît dans une dépêche du vecteur VD,
      -- son score est décrémenté si la dépêche n'est pas dans la catégorie C
      --            et incrémenté si la dépêche       est dans la catégorie C}
      I, Indice : Integer := VD'First;
   begin
      for I in VD'Range loop
	 if Vd(I).Cat = C then 
	    for J in VD(I).Texte'First..VD(I).Nbmots loop
	       Indice := Recherche(VM, N, VD(I).Texte(J));
	       if Indice /= -1 then
		  VM(Indice).Score := VM(Indice).Score + 1;
	       end if;
	    end loop;
	 else
	    for J in VD(I).Texte'First..VD(I).Nbmots loop
	       Indice := Recherche(VM, N, VD(I).Texte(J));
	       if Indice /= -1 then
		  VM(Indice).Score := VM(Indice).Score - 1;
	       end if;
	    end loop;
	 end if;
      end loop;
   end Calcul_scores;
   
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
     VM : TV_Dico(1..2000);
     N : Integer := 0;
   begin
      Create(F, Out_File, Fl);
      Init_Dico(Vd, C, VM, N);
      Calcul_Scores(VD, C, VM, N);
      for I in Vm'First..N loop
         if VM(I).Score > 0 then
            Put_line(F, Vm(I).Mot & ':' & Integer'Image(Poids_Score(Vm(I).Score)));
         end if;
      end loop;
      Close(F);
   end;
   
end p_generation;
