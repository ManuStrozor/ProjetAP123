with P_Chaine; use P_Chaine;

package body P_Classification is
   
   function Score(D: in TR_Depeche; L : in TV_Lexique) return Integer is
      
      function Rech(Mot : in String; L : in TV_Lexique; Ln : in Integer) return Integer is
	 -- {L non trié},=> {résultat = indice si L contient le mot}
	 Me, Inf, Sup : Integer;
      begin
	 if L(L'last).Chaine(1..Ln) < Mot then
	    return L'Last+1;
	 else
	    Inf := L'First; Sup := L'Last;
	    while Inf < Sup loop
	       Me := (Inf + Sup) / 2 ;
	       if L(Me).Chaine(1..Ln) >= Mot then
		  Sup := Me;
	       else
		  Inf := Me + 1;
	       end if;
	    end loop;
	    if L(Sup).Chaine(1..Ln) = Mot then 
	       return Sup;
	    else 
	       return L'Last+1;
	    end if;
	 end if;
      end;
      
      Total : Integer := 0;
      Ind : Natural;
      M : String(1..30);
   begin
      for I in D.Texte'First..D.Nbmots loop
	 M := D.Texte(I);
	 Ind := Rech(M, L, 30);
	 if Ind /= L'Last+1 then
	    Total := Total + L(Ind).Poids;
	 elsif Trim(M)'Length > 13 then
	    Ind := Rech(M(1..5), L, 5);
	    if Ind /= L'Last+1 then
	       Total := Total + L(Ind).Poids;
	    end if;
	 end if;
      end loop;
      
      return Total;
   end;
   
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
      
      type TV_Cnt is array(T_Categorie) of Integer;
      
      Cnt : TV_Cnt := (others => 0);
      F : Text_Io.File_Type;
      Sc : TV_Score;
      Moy : Float := 0.0;
      Mx : T_Categorie;
      
      --  function Rech(Mot : in String; L : in TV_Lexique) return Integer is
      --  	 -- {L non trié},=> {résultat = indice si L contient le mot}
      --  	 Me, Inf, Sup : Integer;
      --  begin
      --  	 if L(L'last).Chaine < Mot then
      --  	    return L'Last+1;
      --  	 else
      --  	    Inf := L'First; Sup := L'Last;
      --  	    while Inf < Sup loop
      --  	       Me := (Inf + Sup) / 2 ;
      --  	       if L(Me).Chaine >= Mot then
      --  		  Sup := Me;
      --  	       else
      --  		  Inf := Me + 1;
      --  	       end if;
      --  	    end loop;
      --  	    if L(Sup).Chaine = Mot then 
      --  	       return Sup;
      --  	    else 
      --  	       return L'Last+1;
      --  	    end if;
      --  	 end if;
      --  end;
      --  type TV_Files is array(T_Categorie) of String(1..30);
      --  Z : TV_Files;
   begin
      Create(F, Out_File, Nomfic);
      for I in VD'Range loop
	 Sc(Politique) := Score(VD(I), Lp);
	 Sc(Sports) := Score(VD(I), Ls);
	 Sc(Culture) := Score(VD(I), Lc);
	 Sc(Economie) := Score(VD(I), Le);
	 Sc(Science) := Score(VD(I), Lt);
	 Mx := Max_Score(Sc);
	 Put_Line(F, VD(i).Id &':'& Image(Mx));
	 if Mx = VD(I).Cat then
	    Cnt(Mx) := Cnt(Mx) + 1;
	 --  else
	 --     Ecrire_Ligne(VD(I).Id &":("& Image(VD(I).Cat) &')'& Image(Sc(VD(I).Cat)) & " -> [" & Image(Mx) &']'& Image(Sc(Mx)));
	 --     for J in VD(I).Texte'First..VD(I).NbMots loop
	 --        Z := (uTrim("lex/POLITIQUE-2.txt", 30),
	 --     	     uTrim("lex/SPORTS-2.txt", 30),
	 --     	     uTrim("lex/CULTURE-2.txt", 30),
	 --     	     uTrim("lex/ECONOMIE-2.txt", 30),
	 --     	     uTrim("lex/SCIENCES-2.txt", 30));
	 --        declare
	 --     	  L1 : TV_Lexique(1..Nb_Mots(Trim(Z(VD(I).Cat))));
	 --     	  L2 : TV_Lexique(1..Nb_Mots(Trim(Z(Mx))));
	 --        begin
	 --     	  Init_Lexique(Trim(Z(VD(I).Cat)), L1);
	 --     	  Init_Lexique(Trim(Z(Mx)), L2);
	 --     	  if Rech(VD(i).Texte(J), L1) /= L1'Last+1 then
	 --     	     Ecrire('(' & Trim(VD(I).Texte(J)) & ") ");
	 --     	  elsif Rech(VD(i).Texte(J), L2) /= L2'Last+1 then
	 --     	     Ecrire('[' & Trim(VD(I).Texte(J)) & "] ");
	 --     	  else
	 --     	     Ecrire(Trim(VD(I).Texte(J)) & ' ');
	 --     	  end if;
	 --        end;
	 --     end loop;
	 --     A_La_Ligne(2);
	 end if;
      end loop;
      for I in T_Categorie loop
	 Put_Line(F, Image(I) & ':' & Image(Cnt(I)));
	 Moy := Moy + Float(Cnt(I));
      end loop;
      Put_Line(F, "MOYENNE:" & Image(Moy/5.0));
      Close(F);
      Ecrire_Ligne("Moyenne:" & Image(Moy/5.0));
   end;
   
end;
