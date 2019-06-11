with P_Esiut;
use P_Esiut;
with Calendar; use Calendar;

procedure temps_execution is 
   S:String(1..30); 
   Ce_Time1 : Time;
   ce_Time2 : time;
   cette_annee : year_number;
   ce_mois : month_number;
   ce_jour : day_number;
   ces_Secondes1 : Day_Duration;
   Ces_Secondes2 : Day_Duration;
   ces_secondes3 : day_duration;
begin
   
  

         ce_time1 := clock;
         ecrire("entrez un mot:");
         Lire(S);
         ce_time2 := clock;
         
         Split (Ce_Time1,Cette_Annee,Ce_Mois,Ce_Jour,Ces_Secondes1);
         Split (Ce_Time2,Cette_Annee,Ce_Mois,Ce_Jour,Ces_Secondes2);
         ces_secondes3:=ces_secondes2-ces_secondes1;
         ecrire("duree:");ecrire(day_duration'Image(ces_secondes3));
     
end temps_execution;
