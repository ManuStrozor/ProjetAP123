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
      if N = 0 then
	 VM(I).Mot := Mot;
	 N := 1;
      else
	 while I <= N and then Mot > VM(I).Mot loop
	    I := I + 1;
	 end loop;
	 if I <= VM'last and then Mot /= VM(I).Mot then
	    if N = VM'Last then
	       VM(I+1..N) := VM(I..N-1);
	    else
	       VM(I+1..N+1) := VM(I..N);
	    end if;
	    VM(I).Mot := Mot;
	    if N < VM'Last then N := N + 1; end if;
	 else
	    VM(I).Freq := VM(I).Freq + 1;
	 end if;
      end if;
   end;
   
   procedure Init_Dico(VD: in Tv_Depeche; C: in T_Categorie; VM: out Tv_Dico; N : in out Integer) is
      -- {} => {Charge Dans VM Tous Les Mots Présents Dans Au Moins Une Dépêche De La Catégorie C Du Vecteur De Dépêches VD. Attention, Même Si Le Mot Est Présent Plusieurs Fois, Il Ne Doit Apparaître Qu'Une Fois Dans Le Vecteur VM. La Procédure Initialise Aussi Tous Les Scores À 0 Et range Dans N Le Nombre De Mots Ajoutés Dans VM }
      I : Integer := VD'First;
   begin
      VM := (others => ((others => ' '), 0, 1));
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
   
   procedure Infos_Scores(VM : in TV_Dico; N : in Integer; Inf : in out TR_Info) is
      --{} => {Calcul total, min, q1, med, q3, max, nb positifs et nb entre les quartiles}
      VMtemp : TV_Dico(1..N) := VM(1..N);
      procedure TriBullesOpt(V : in out TV_Dico; N : in integer) is
	 -- {} => {V trié par ordre croissant}
	 I : Integer;
	 Onapermute : Boolean;
	 Tmp : TR_Entree;
      begin
	 I := V'First; Onapermute := True;
	 while Onapermute loop
	    Onapermute := False;
	    for J in reverse I+1..N loop
	       if V(J).score < V(J-1).score then
		  Tmp := V(J);
		  V(J) := V(J-1);
		  V(J-1) := tmp;
		  Onapermute := True;
	       end if;
	    end loop;
	    I := I + 1;
	 end loop;
      end;
      I, Sco : Integer := VMtemp'First;
   begin
      Tribullesopt(VMtemp, N);
      
      Inf.Max := Vmtemp(N).score;
      Sco := Inf.Max / 4;
      Inf.Q1 := Sco;
      Inf.Med := Sco * 2;
      Inf.Q3 := Sco * 3;
      
      while I <= N and then VMtemp(I).Score < 0 loop
	 I := I + 1;
      end loop;
      
      Inf.Nb0 := I; -- debut de Nb0 (Min -> Q1)
      
      while I <= N and then VMtemp(I).Score = 0 loop
	 I := I + 1;
      end loop;
      
      Inf.NbPos := N-I+1;
      
      --  for J in I..N loop
      --  	 VMtemp(J).Score := Integer(Float(VMtemp(J).Score) + (Float(VMtemp(J).Score)*(Float(VMtemp(J).Score)/Float(VMtemp(J).Freq))));
      --  end loop;
      --  Tribullesopt(VMtemp, N);
      
      while I <= N and then VMtemp(I).Score < Inf.Q1 loop
	 I := I + 1;
      end loop;
      
      Inf.Nb0 := I-Inf.Nb0;
      Inf.Nb1 := I; -- debut de Nb1 (Q1 -> Med)
      
      while I <= N and then VMtemp(I).Score < Inf.Med loop
	 I := I + 1;
      end loop;
      
      Inf.Nb1 := I-Inf.Nb1;
      Inf.Nb2 := I; -- debut de Nb2 (Med -> Q3)
      
      while I <= N and then VMtemp(I).Score < Inf.Q3 loop
	 I := I + 1;
      end loop;
      
      Inf.Nb2 := I-Inf.Nb2;
      Inf.Nb3 := N-I+1;
   end;
   
   function Poids_Score(S, F : in Integer; Inf : in TR_Info) return Integer is
      -- {} => {resultat = valeur du poids à attribuer étant donné un score S}
      --NewP : Integer;
   begin
      if S > Inf.Q3 then
      	 return 8;
      elsif S > Inf.Med then
      	 return 4;
      elsif S > Inf.Q1 then
      	 return 2;
      else
      	 return 1;
      end if;      
      --  newP := Integer(Float(S) + (Float(S)*(Float(S)/Float(F))));
      --  if NewP > 0 then return NewP; else return 1; end if;
   end;
   
   procedure Generation_Lexique (VD: in Tv_Depeche; C : in T_Categorie; Fl: in String) is
     --   {} => {Cette Procédure Créé Pour La Catégorie C Le Fichier Lexique De Nom Fl À Partir Du Vecteur De Dépêches De Nom VD. Cette Procédure Doit Déclarer Un Vecteur De type TV_Dico Puis Le Remplir En Utilisant Init_Dico, Puis Calcul_Scores Et Enfin Utiliser Le Vecteur Résultant Pour Créer Un Fichier Lexique En Utilisant La Fonction Poids_Score}
     F : File_Type;
     VM : TV_Dico(1..2000);
     N : Integer := 0;
     Poids : Integer := 0;
     Inf : TR_Info := (0, 0, 0, 0, 0,
		       0, 0, 0, 0, 0);
   begin
      Create(F, Out_File, Fl);
      Init_Dico(Vd, C, VM, N);
      Calcul_Scores(VD, C, VM, N);
      Infos_Scores(VM, N, Inf);
      for I in Vm'First..N loop
         if VM(I).Score > Inf.Min then
	    Poids := Poids_Score(Vm(I).Score, VM(I).Freq, Inf);
	    Put_line(F, Vm(I).Mot & ':' & Integer'Image(Poids));
         end if;
      end loop;
      Close(F);
   end;
   
end p_generation;
