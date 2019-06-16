with P_Depeche; use P_Depeche;
with Text_Io; use Text_Io;

package p_generation is
   
   type TR_Info is record
      Min, Q1, Med, Q3, Max : Integer;
      NbPos, Nb0, Nb1, Nb2, Nb3 : Integer;
   end record;
   
   type TR_Entree is record
      Mot : String(1..30);
      Score, Freq : Integer;
   end record;
   
   type TV_Dico is array(Integer range <>) of TR_Entree;
   
   function Recherche(VM: in out Tv_Dico; N: in Integer; M: in String) return Integer;
   -- {} => {Resultat= Indice Du Mot M Dans Le Vecteur VM Si Il Est Présent Et -1 Sinon. N Est Le Nombre De Mots Rangés Dans Le vecteur}
   
   procedure Insert_Dico(VM : out TV_Dico; N : in out Integer; Mot : in String);
   -- {} => {Insert Mot dans VM de facon à ce que le dico soit toujours trié, si Mot est dejà présent dans VM, il n'est pas inséré}
   
   procedure Init_Dico(VD: in Tv_Depeche; C: in T_Categorie; VM: out Tv_Dico; N: in out Integer);
   -- {} => {Charge Dans VM Tous Les Mots Présents Dans Au Moins Une Dépêche De La Catégorie C Du Vecteur De Dépêches VD. Attention, Même Si Le Mot Est Présent Plusieurs Fois, Il Ne Doit Apparaître Qu'Une Fois Dans Le Vecteur VM. La Procédure Initialise Aussi Tous Les Scores À 0 Et range Dans N Le Nombre De Mots Ajoutés Dans VM }
   
   procedure Calcul_Scores(VD : in Tv_Depeche; C : in T_Categorie; VM : in out Tv_Dico; N, A, B : in Integer);
   -- {} => {Cette procédure met à jour les scores des différents mots présents dans VM. Lorsqu'un mot présent dans VM apparaît dans une dépêche du vecteur VD, son score est décrémenté si la dépêche n'est pas dans la catégorie C et incrémenté si la dépêche est dans la catégorie C}
   
   procedure Infos_Scores(VM : in out TV_Dico; N : in Integer; Inf : in out TR_Info);
   --{} => {Calcul total, min, q1, med, q3, max, nb positifs et nb entre les quartiles}
   
   function Poids_Score(S, F : in Integer; Inf : in TR_Info; A,B,C,D : in Integer) return Integer;
   -- {} => {resultat = valeur du poids à attribuer étant donné un score S et une Frequence F}
   
   procedure Generation_Lexique(VD : in Tv_Depeche; C : in T_Categorie; Fl : in String; A,B,D,E,G,H : in Integer);
   -- {} => {Cette Procédure Créé Pour La Catégorie C Le Fichier Lexique De Nom Fl À Partir Du Vecteur De Dépêches De Nom VD. Cette Procédure Doit Déclarer Un Vecteur De type TV_Dico Puis Le Remplir En Utilisant Init_Dico, Puis Calcul_Scores Et Enfin Utiliser Le Vecteur Résultant Pour Créer Un Fichier Lexique En Utilisant La Fonction Poids_Score}
   
end p_generation;
