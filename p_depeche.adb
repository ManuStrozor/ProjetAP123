with P_Esiut; use P_Esiut;
with Text_IO;with p_chaine;

package body P_Depeche is
   
   --- Affiche une depeche
   procedure Affiche(d : in TR_Depeche) is
     I: integer;
      begin
         Ecrire("--- "); Ecrire (d.id); Ecrire (" -------------------------- ");
         A_La_Ligne;
         Ecrire("date: ");Ecrire(d.date); Ecrire("     ");
         A_la_ligne;
         Ecrire("categorie: ");Ecrire(d.cat);
         A_La_Ligne;
         I:=1;
         -- Affiche les mots de la depeche
         while (I<=D.Nbmots) loop
            Ecrire(D.Texte(I));
            i:=i+1;
            end loop;
         A_la_ligne;
         Ecrire (" -------------------------------- ");
         A_la_ligne;
end Affiche;

  --***********************************************************************
   procedure Charge(nomfic : String;V : out TV_Depeche) is 
      -- charge les depeches du fichier nomfic dans le vecteur de depeches V
      ------------------------------------------------------------------------- 
      I:Integer;
      Last:Natural;
      Ligne:String(1..100);
      Texte : p_chaine.TR_Chaine_Longue;
      F : Text_Io.File_Type;
      begin
            -- ouverture du fichier des depeches
            Text_IO.Open(F, Text_IO.in_File,nomfic);
            I:=1;
            
         while (not Text_Io.End_Of_File (F)) loop
            --initialisation de l'identifiant de la depeche
            Text_Io.Get_Line(F,Ligne,Last);
            V(I).Id:=Ligne(4..6);
            --initialisation de la date de la depeche
            Text_IO.Get_line(F,Ligne,Last);
            V(I).Date:= Ligne(4..9);
            --initialisation de la catégorie Cat de la depeche
            Text_IO.Get_line(F,Ligne,Last);
         if (Ligne(4..5)="PO") then V(I).Cat:=Politique;
         elsif (Ligne(4..5)="SP") then V(I).Cat:=Sports;
         elsif (Ligne(4..5)="EC") then V(I).Cat:=Economie;
         elsif (Ligne(4..5)="CU") then V(I).Cat:=Culture;
         elsif (Ligne(4..5)="EN") then V(I).Cat:=Science;
         else V(I).Cat:=Sports;
            end if;
            
            --initialisation du vecteur de mots de la depeche
            -- une chaine "Texte" est construite en concaténant toute les lignes
            -- de la depeche. 
            Text_Io.Get_Line(F,Ligne,Last);
            Ligne(1..Last-3):=Ligne(4..Last);
            Last:=Last-3;
            Texte.Long:=0;
            
            while (Last/=0) loop
            Texte.Ch(Texte.Long+1..Texte.Long+Last):=Ligne(1..Last);
            Texte.Ch(Texte.Long+Last+1):=' ';
            Texte.Long:=Texte.Long+Last+1;
            Text_Io.Get_Line(F,Ligne,Last);
            end loop;
            -- Toutes les majuscules de "Texte" sont convertie en minuscules
            P_Chaine.Minuscule(Texte.Ch);
            -- La chaine est décomposée en mots qui sont rangés dans un vecteur
            Decompose(Texte,V(I).Texte,V(I).Nbmots); -- transforme la chaîne en un vecteur de mots 
            I:=I+1;
         end loop;
      
         Text_Io.Close(F);
       end Charge;


   procedure Decompose(C : in P_Chaine.Tr_Chaine_Longue; V : out Tv_Mot; N : out natural) is
      I,J,pos:integer;
   begin
      I:=1;
      J:=1;
      -- la décomposition de la chaine consiste à parcourir la chaîne de séparateurs en séparateurs.
      while (I<=C.Long) loop
         Pos:=P_Chaine.Indexseparateur(C.Ch,I);
          -- Chaque mot isolé est rangé dans la case J du vecteur V
         if (I/=Pos) then 
            V(J):=(others=>' ');
            V(J)(1..Pos-I):=C.Ch(I..Pos-1);
               J:=J+1;
            end if;
         I:=Pos+1;
         end loop;
         N:=J-1;
   end Decompose;

       --------------------------------------------------------------------

   
end p_depeche;

