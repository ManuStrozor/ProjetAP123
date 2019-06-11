package body P_Classification is
   
   function Score(D: in TR_Depeche; L : in TV_Lexique) return Integer is
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
   
   function Max_Score(VS : in TV_Score) return T_Categorie is
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
      F : Text_Io.File_Type;
      Tmp : TV_Lexique;
      type TV_Cnt is array(T_Categorie) of Positive;
      Counter : TV_Cnt := (others => 0);
      Moy : Float := 0.0;
   begin
      Open(F, Out_File, Nomfic);
      for I in VD'Range loop
	 Put_Line(F, VD(i).Id & ':' & VD(I).Cat);
	 
	 if VD(I).Cat = Politique then
	    Tmp := Lp;
	 elsif VD(I).Cat = Sports then
	    Tmp := Ls;
	 elsif VD(I).Cat = Culture then
	    Tmp := Lc;
	 elsif VD(I).Cat = Economie then
	    Tmp := Le;
	 else
	    Tmp := Lt;
	 end if;
	 
	 Counter(VD(I).Cat) := Counter(VD(I).Cat) + Score(VD(I), Tmp);
      end loop;
      for I in T_Categorie loop
	 Put_Line(Image(I) & ':' & Integer'Image(Counter(I)));
	 Moy := Moy + Float(Counter(I));
      end loop;
      Put_Line("MOYENNE:" & Float'Image(Moy/5.0));
   end;
   
end P_Classification;
