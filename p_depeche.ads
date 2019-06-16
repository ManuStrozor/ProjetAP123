with P_Chaine; use P_Chaine;
with P_Esiut; use P_Esiut;
with Text_Io; use Text_Io;

package p_depeche is
   
   type T_Categorie is (Politique, Sports, Culture, Economie, Science);
   
   type TV_Score is array(T_Categorie) of Integer;
   
   type TV_mot is array(1..100) of String(1..30);
   
   package P_CategorieIO is new P_Enum(T_Categorie); use P_CategorieIO;
   
   type TR_Depeche is record
      Id : String(1..3);
      Date : String(1..6);
      Cat  : T_Categorie;
      Nbmots : natural;
      Texte : TV_mot;
   end record;
   
   type Tv_Depeche is array(1..500) of Tr_Depeche;
   
   procedure Affiche(D : in TR_Depeche);
   
   procedure Charge(Nomfic : in String; V : out Tv_Depeche);
   
   procedure Decompose(C : in TR_Chaine_Longue; V : out TV_mot; N : out natural);
   
end;
