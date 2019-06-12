with Text_Io; use Text_Io;
with P_Chaine; use P_Chaine;

package P_Lexique is
   
   type TR_Mot is record
      Chaine : String(1..30);
      Poids : Positive;
   end record;
   
   type TV_Lexique is array(Integer range <>) of TR_Mot;
   
   function Nb_Mots(Nomfic : in String) return Integer;
   -- {} => {résultat = nombre de lignes du fichier Nomfic et donc de mots dans le lexique correspondant}
   
   procedure Init_Lexique(Nomfic: in String; L : out Tv_lexique);
   -- {On suppose que la taille du vecteur L correspond exactement au nombre de mots contenus dans le fichier}
   -- => {Range dans le vecteur L, les mots contenus dans le fichier lexique Nomfic et les poids associés}
   
   function Poids_Mot(M : in String; L : in Tv_lexique) return integer ;
   -- {} => {résultat = le poids de M dans le lexique L et 0 si le mot n'est pas présent dans le lexique}
     
end p_lexique;
