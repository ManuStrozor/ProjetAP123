with P_Esiut, P_Depeche;
use P_Esiut, P_Depeche;

procedure p1 is 
   Vd : Tv_Depeche;
begin 
   Ecrire_Ligne("Chargement des depeches");
   Charge("txt/depeches.txt", VD);
   Ecrire_Ligne("Fin du chargement");
   Affiche(VD(1));
end;
