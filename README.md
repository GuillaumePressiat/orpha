
# Travaux autour des codes Orphanet


## Harvesting des données sur orphanet (python selenium)

**Première option :** avec selenium on récupère les informations présentées sur le site (python notebook et premier projet [selenium](https://fr.wikipedia.org/wiki/Selenium_(informatique)) pour moi).

Les informations suivantes sont récupérées, par exemple pour le code :

```
ORPHA:370927  SSR4-CDG
Plus d'informations
Synonyme(s) : Anomalie congénitale de la glycosylation type 1y ; Anomalie congénitale de la glycosylation type Iy ; CDG-Iy ; CDG1Y ; Syndrome CDG type Iy ; Syndrome des glycoprotéines déficientes en hydrates de carbone type Iy
--
Détails
--
Synonyme(s) :
Anomalie congénitale de la glycosylation type 1y
Anomalie congénitale de la glycosylation type Iy
CDG-Iy
CDG1Y
Syndrome CDG type Iy
Syndrome des glycoprotéines déficientes en hydrates de carbone type Iy
Prévalence : <1 / 1 000 000
Hérédité : Récessive liée à l'X 
Âge d'apparition : Petite enfance, Néonatal
CIM-10 : E77.8
OMIM : 300934
UMLS : -
MeSH : -
GARD : 12405
MedDRA : -
```

Et on peut structurer ces données sous forme d'une table ensuite (pgm parse_orpha.R), exemple sur ce même code :

```
# A tibble: 1 x 11
  code   libelle  age_apparition           cim   GARD  MedDRA MeSH  OMIM   prevalence     synonymes                            UMLS 
  <chr>  <chr>    <chr>                    <chr> <chr> <chr>  <chr> <chr>  <chr>          <chr>                                <chr>
1 370927 SSR4-CDG Petite enfance, Néonatal E77.8 12405 -      -     300934 <1 / 1 000 000 Anomalie congénitale de la glycosyl… -  
```

Inconvénient : c'est long.

## Import du fichier json disponible sur orphadata  (R)

**Deuxième option :** on importe le json téléchargeable [ici](http://www.orphadata.org/cgi-bin/inc/product1.inc.php) et on le structure sous la forme d'un fichier tabulaire contenant les informations suivantes :

```r
glimpse(arrange(orpha_table, as.integer(OrphaNumber)))
```

```
Observations: 9,540
Variables: 12
$ id          <chr> "3555", "3297", "1242", "335", "390", "1056", "378", "771", "252", "148", "177", "776", "3621", "3362", "3296", "402", "459", "3376", "3564", "...
$ OrphaNumber <chr> "5", "6", "7", "8", "9", "10", "11", "13", "14", "15", "16", "17", "18", "19", "20", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31"...
$ ExpertLink  <chr> "http://www.orpha.net/consor/cgi-bin/OC_Exp.php?lng=fr&Expert=5", "http://www.orpha.net/consor/cgi-bin/OC_Exp.php?lng=fr&Expert=6", "http://www...
$ Name        <chr> "Déficit en 3-hydroxyacyl-CoA déshydrogénase des acides gras à chaîne longue", "Déficit en 3-méthylcrotonyl-CoA carboxylase", "Syndrome 3C", "S...
$ statut      <chr> "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", ...
$ Synonymes   <chr> "Déficit en 3-hydroxyacyl-coenzyme A déshydrogénase des acides gras à chaîne longue ; Déficit en LCHAD ; LCHADD", "3-méthylcrotonyl glycinurie ...
$ nsyn        <int> 3, 3, 2, 2, 3, NA, 3, 1, 2, NA, 5, NA, 5, 1, 3, 3, 5, 1, 5, 2, 3, 2, 2, 3, 1, 1, 1, 1, 3, 1, 2, 5, NA, NA, 1, 4, 3, 1, 2, 2, 2, 2, 2, 1, 2, 3, ...
$ `ICD-10`    <chr> "E71.3", "E71.1", "Q87.8", "Q98.5", "Q97.1", "Q98.8", "Q97.1", "E70.1", "E78.6", "Q77.4", "H53.5", "E71.1", "N25.8", "E72.8", "E71.1", "E72.8",...
$ MedDRA      <chr> "", "", "", "10056894", "", "10048230", "", "", "", "10000452", "", "", "10045224", "", "", "", "10058299", "", "", "", "", "", "10072219", "10...
$ MeSH        <chr> "", "C535308", "C535313", "C535317 ; D014997", "C536502", "D007713", "C535319", "C535325", "D000012", "D000130", "C536238 ; C538165", "", "", "...
$ OMIM        <chr> "609016", "210200 ; 210210", "220210 ; 300963", "", "", "", "", "261640", "200100", "100800", "303700", "245400", "179800 ; 267300 ; 602722 ; 6...
$ UMLS        <chr> "C0342786 ; C1969443", "C0268600", "C0796137", "C3266843 ; C0043379", "C0265496", "C2936741", "C2937419 ; C0265497", "C0878676", "C0000744", "C...
```

Ce fichier est disponible aux formats csv tsv et csv comma.

- [csv](https://github.com/GuillaumePressiat/orpha/blob/master/data/orpha_table.csv)
- [tsv](https://github.com/GuillaumePressiat/orpha/blob/master/data/orpha_table.tsv)
- [comma csv ou csv2 ;](https://github.com/GuillaumePressiat/orpha/blob/master/data/orpha_table_comma.csv)

J'ai réalisé cette extraction le 05/06/2018.
