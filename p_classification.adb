package body P_Classification is
   
   function Score(D: in TR_Depeche; L : in TV_Lexique) return Integer is
      
      function Rech(Mot : in String; L : in TV_Lexique) return Integer is
	 -- {L non trié},=> {résultat = indice si L contient le mot}
	 Me, Inf, Sup : Integer;
      begin
	 if L(L'last).Chaine < Mot then
	    return L'Last+1;
	 else
	    Inf := L'First; Sup := L'Last;
	    while Inf < Sup loop
	       Me := (Inf + Sup) / 2 ;
	       if L(Me).Chaine >= Mot then
		  Sup := Me;
	       else
		  Inf := Me + 1;
	       end if;
	    end loop;
	    if L(Sup).Chaine = Mot then 
	       return Sup;
	    else 
	       return L'Last+1;
	    end if;
	 end if;
      end;
            
      Total : Integer := 0;
      Ind : Natural;
   begin
      for I in D.Texte'First..D.Nbmots loop
	 Ind := Rech(D.Texte(I), L);
	 if Ind /= L'Last+1 then
	    Total := Total + L(Ind).Poids;
	 end if;
      end loop;
      return Total;
   end Score;
   
   function Max_Score(VS : in TV_Score) return T_Categorie is
      -- {} => {resultat = Catégorie ayant le score maximal dans VS}
      Max : Integer := VS(VS'first);
      Cat : T_Categorie := VS'first;
   begin
      for I in VS'Range loop
	 if VS(I) > Max then
	    Max := VS(I);
	    Cat := I;
	 end if;
      end loop;
      return Cat;
   end;
   
   procedure Run (VD : in TV_Depeche; Lp, Ls, Lc, Le, Lt : TV_Lexique; Nomfic : String) is
      -- {} => {Génère le fichier texte réponse Nomfic étant donné les dépêches et les lexiques passés en argument}
      F : Text_Io.File_Type;
      Sc : TV_Score;
      type TV_Cnt is array(T_Categorie) of Integer;
      Counter : TV_Cnt := (others => 0);
      Moy : Float := 0.0;
   begin
      Create(F, Out_File, Nomfic);
      for I in VD'Range loop
	 Put_Line(F, VD(i).Id &':'& Image(VD(I).Cat));
	 Sc(Politique) := Score(VD(i), Lp);
	 Sc(Sports) := Score(VD(i), Ls);
	 Sc(Culture) := Score(VD(i), Lc);
	 Sc(Economie) := Score(VD(i), Le);
	 Sc(Science) := Score(VD(i), Lt);
	 if VD(I).Cat = Max_Score(Sc) then
	    Counter(VD(I).Cat) := Counter(VD(I).Cat) + 1;
	 end if;
      end loop;
      for I in T_Categorie loop
	 Put_Line(F, Image(I) & ':' & Integer'Image(Counter(I)));
	 Moy := Moy + Float(Counter(I));
      end loop;
      Put(F, "MOYENNE:" & Image(Moy/5.0));
   end;
   
end P_Classification;
