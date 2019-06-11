with P_Depeche; use P_Depeche;

package P_classification is
   
   function Score(D: in TR_Depeche; L : in TV_Lexique) return Integer;
   -- {} => { Résultat = Score De La Dépêche D Pour La Catégorie Dont Le Lexique Est L}
     
   function Max_Score(VS : in TV_Score) return T_Categorie;
   -- {} => {resultat = Catégorie ayant le score maximal dans VS}
   
   procedure Run (VD : in TV_Depeche; Lp, Ls, Lc, Le, Lt : TV_Lexique; Nomfic : String);
   -- {} => {Génère le fichier texte réponse Nomfic étant donné les dépêches et les lexiques passés en argument}
   
end p_classification;
