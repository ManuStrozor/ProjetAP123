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
   
   procedure Run (VD : in TV_Depeche; Lp, Ls, Lc, Le, Lt : TV_Lexique; Nomfic : String; A,B,C,D,E,G : in Integer) is
      -- {} => {Génère le fichier texte réponse Nomfic étant donné les dépêches et les lexiques passés en argument}
      F : Text_Io.File_Type;
      Sc : TV_Score;
      type TV_Cnt is array(T_Categorie) of Integer;
      Cnt : TV_Cnt := (others => 0);
      Moy : Float := 0.0;
      Mx : T_Categorie;
   begin
      Create(F, Out_File, Nomfic);
      for I in VD'Range loop
	 Sc(Politique) := Score(VD(i), Lp);
	 Sc(Sports) := Score(VD(i), Ls);
	 Sc(Culture) := Score(VD(i), Lc);
	 Sc(Economie) := Score(VD(i), Le);
	 Sc(Science) := Score(VD(i), Lt);
	 Mx := Max_Score(Sc);
	 Put_Line(F, VD(i).Id &':'& Image(Mx));
	 Put_Line(VD(I).Id &':'& Image(VD(I).Cat) & " -> " & Image(Mx));
	 if Mx = VD(I).Cat then
	    Cnt(Mx) := Cnt(Mx) + 1;
	 else
	    for J in Sc'Range loop
	       Put(Image(J) &':'& Integer'Image(Sc(J)) &' ');
	    end loop;
	    New_Line;
	 end if;
      end loop;
      for I in T_Categorie loop
	 Put_Line(F, Image(I) & ':' & Image(Cnt(I)));
	 Moy := Moy + Float(Cnt(I));
      end loop;
      Put_Line(F, "MOYENNE:" & Image(Moy/5.0));
      Close(F);
      Put_Line(Image(Moy/5.0));
      Put_Line("A:" & Image(A) & " B:" & Image(B) & " Min:" & Image(C) & " Q1:" & Image(D) & " Med:" & Image(E) & " Q3:" & Image(G));
   end;
end;
