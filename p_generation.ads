package p_generation is
   
   type TR_Entree is record
      Mot: String(1..30);
      Score: Integer;
   end record;
   
   type TV_Dico is array(1..2000) of TR_Entree;
   
   function Recherche(VM: in Tv_Dico; N: in Integer; M: in String) return Integer;
   -- {} => {Resultat= Indice Du Mot M Dans Le Vecteur VM Si Il Est Présent Et -1 Sinon. N Est Le Nombre De Mots Rangés Dans Le vecteur}
     
   procedure Init_Dico(VD: in Tv_Depeche; C: in T_Categorie; VM: out Tv_Dico; N: out Integer);
   -- {} => {Charge Dans VM Tous Les Mots Présents Dans Au Moins Une Dépêche De La Catégorie C Du Vecteur De Dépêches VD. Attention, Même Si Le Mot Est Présent Plusieurs Fois, Il Ne Doit Apparaître Qu'Une Fois Dans Le Vecteur VM. La Procédure Initialise Aussi Tous Les Scores À 0 Et range Dans N Le Nombre De Mots Ajoutés Dans VM }
   
   procedure Generation_Lexique (VD: in Tv_Depeche; C : in T_Categorie; Fl: in String);
   -- {} => {Cette Procédure Créé Pour La Catégorie C Le Fichier Lexique De Nom Fl À Partir Du Vecteur De Dépêches De Nom VD. Cette Procédure Doit Déclarer Un Vecteur De type TV_Dico Puis Le Remplir En Utilisant Init_Dico, Puis Calcul_Scores Et Enfin Utiliser Le Vecteur Résultant Pour Créer Un Fichier Lexique En Utilisant La Fonction Poids_Score}
   
   procedure Calcul_Scores(VD: in Tv_Depeche;C: in T_Categorie; VM: in out Tv_Dico;N: in Integer);
   -- {} => {Cette procédure met à jour les scores des différents mots présents dans VM. Lorsqu'un mot présent dans VM apparaît dans une dépêche du vecteur VD, son score est décrémenté si la dépêche n'est pas dans la catégorie C et incrémenté si la dépêche est dans la catégorie C}
   
end p_generation;
