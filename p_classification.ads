package P_classification is
   
   function Score(D: in TR_Depeche; L : in TV_Lexique) return Integer;
   -- {} => { Résultat = Score De La Dépêche D Pour La Catégorie Dont Le Lexique Est L}
     
   function Max_Score(VS : in TV_Score) return T_Categorie;
   -- {} => {resultat = Catégorie ayant le score maximal dans VS}
     
end p_classification;
