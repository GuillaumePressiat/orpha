



## Works around orpha.net disorders cross referenced JSON

Goal is to have tabular data.

### json file import and tabulation (R)

We import json file [from here](http://www.orphadata.org/cgi-bin/inc/product1.inc.php) and make a table containing theses columns:


```r
glimpse(arrange(orpha_table, as.integer(OrphaNumber)))
```

```
Observations: 9,573
Variables: 13
$ id          <chr> "3555", "3297", "1242", "335", "390", "1056", "378", "771", "252", "148", "177", "776", "3621", "3362", "3296", "402", "459", "...
$ OrphaNumber <chr> "5", "6", "7", "8", "9", "10", "11", "13", "14", "15", "16", "17", "18", "19", "20", "22", "23", "24", "25", "26", "27", "28", ...
$ ExpertLink  <chr> "http://www.orpha.net/consor/cgi-bin/OC_Exp.php?lng=en&Expert=5", "http://www.orpha.net/consor/cgi-bin/OC_Exp.php?lng=en&Expert...
$ Name        <chr> "Long chain 3-hydroxyacyl-CoA dehydrogenase deficiency", "3-methylcrotonyl-CoA carboxylase deficiency", "3C syndrome", "47,XYY ...
$ Type        <chr> "Disease", "Disease", "Malformation syndrome", "Malformation syndrome", "Malformation syndrome", "Malformation syndrome", "Malf...
$ statut      <chr> "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-li...
$ Synonymes   <chr> "LCHAD deficiency ; LCHADD ; Long-chain 3-hydroxyacyl-coenzyme A dehydrogenase deficiency", "3-methylcrotonylglycinuria ; MCC d...
$ nsyn        <int> 3, 3, 2, 3, 3, NA, 3, 1, 2, NA, 6, NA, 4, 1, 3, 3, 5, 1, 5, 2, 3, 2, 2, 2, 1, 1, 1, 1, 3, 1, 3, 4, NA, NA, 1, 5, 3, 1, 2, 2, 2,...
$ `ICD-10`    <chr> "E71.3", "E71.1", "Q87.8", "Q98.5", "Q97.1", "Q98.8", "Q97.1", "E70.1", "E78.6", "Q77.4", "H53.5", "E71.1", "N25.8", "E72.8", "...
$ MedDRA      <chr> "", "", "", "10056894", "", "10048230", "", "", "", "10000452", "", "", "10045224", "", "", "", "10058299", "", "", "", "", "",...
$ MeSH        <chr> "", "C535308", "C535313", "C535317 ; D014997", "C536502", "D007713", "C535319", "C535325", "D000012", "D000130", "C536238 ; C53...
$ OMIM        <chr> "609016", "210200 ; 210210", "220210 ; 300963", "", "", "", "", "261640", "200100", "100800", "303700", "245400", "179800 ; 267...
$ UMLS        <chr> "C0342786 ; C1969443", "C0268600", "C0796137", "C3266843 ; C0043379", "C0265496", "C2936741", "C2937419 ; C0265497", "C0878676"...
```

Multiples records like synonymes are concatened with a " ; ".

The file is available as: csv tsv or csv comma.

- [csv](https://github.com/GuillaumePressiat/orpha/blob/master/data/orpha_table_comma_en_2019-05-01.csv)
- [tsv](https://github.com/GuillaumePressiat/orpha/blob/master/data/orpha_table_en_2019-05-01.tsv)
- [semicolon csv (csv2 ;)](https://github.com/GuillaumePressiat/orpha/blob/master/data/orpha_table_semicolon_en_2019-05-01.csv)


#### Version

```r
> u$JDBOR$version
[1] "1.2.11 / 4.1.6 [2018-04-12] (orientdb version)"
> u$JDBOR$date
[1] "2019-05-01 04:55:41"
```


# En français dans le texte (french people and french labels)

## Travaux autour des codes Orphanet


### Import du fichier json disponible sur orphadata (R)

**Première option :** on importe le json téléchargeable [ici](http://www.orphadata.org/cgi-bin/inc/product1.inc.php) et on le structure sous la forme d'un fichier tabulaire contenant les informations suivantes :

```r
glimpse(arrange(orpha_table, as.integer(OrphaNumber)))
```

```
Observations: 9,573
Variables: 13
$ id          <chr> "3555", "3297", "1242", "335", "390", "1056", "378", "771", "252", "148", "177", "776", "3621", "3362", "3296", "4...
$ OrphaNumber <chr> "5", "6", "7", "8", "9", "10", "11", "13", "14", "15", "16", "17", "18", "19", "20", "22", "23", "24", "25", "26",...
$ ExpertLink  <chr> "http://www.orpha.net/consor/cgi-bin/OC_Exp.php?lng=fr&Expert=5", "http://www.orpha.net/consor/cgi-bin/OC_Exp.php?...
$ Name        <chr> "Déficit en 3-hydroxyacyl-CoA déshydrogénase des acides gras à chaîne longue", "Déficit en 3-méthylcrotonyl-CoA ca...
$ Type        <chr> "Maladie", "Maladie", "Syndrome  malformatif", "Syndrome  malformatif", "Syndrome  malformatif", "Syndrome  malfor...
$ statut      <chr> "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-line", "on-...
$ Synonymes   <chr> "Déficit en 3-hydroxyacyl-coenzyme A déshydrogénase des acides gras à chaîne longue ; Déficit en LCHAD ; LCHADD", ...
$ nsyn        <int> 3, 3, 2, 2, 3, NA, 3, 1, 2, NA, 5, NA, 5, 1, 3, 3, 5, 1, 5, 2, 3, 2, 2, 3, 1, 1, 1, 1, 3, 1, 2, 5, NA, NA, 1, 4, 3...
$ `ICD-10`    <chr> "E71.3", "E71.1", "Q87.8", "Q98.5", "Q97.1", "Q98.8", "Q97.1", "E70.1", "E78.6", "Q77.4", "H53.5", "E71.1", "N25.8...
$ MedDRA      <chr> "", "", "", "10056894", "", "10048230", "", "", "", "10000452", "", "", "10045224", "", "", "", "10058299", "", ""...
$ MeSH        <chr> "", "C535308", "C535313", "C535317 ; D014997", "C536502", "D007713", "C535319", "C535325", "D000012", "D000130", "...
$ OMIM        <chr> "609016", "210200 ; 210210", "220210 ; 300963", "", "", "", "", "261640", "200100", "100800", "303700", "245400", ...
$ UMLS        <chr> "C0342786 ; C1969443", "C0268600", "C0796137", "C3266843 ; C0043379", "C0265496", "C2936741", "C2937419 ; C0265497...
```

Ce fichier est disponible aux formats csv tsv et csv semicolon.

- [csv](https://github.com/GuillaumePressiat/orpha/blob/master/data/orpha_table_comma_fr_2019-05-01.csv)
- [tsv](https://github.com/GuillaumePressiat/orpha/blob/master/data/orpha_table_fr_2019-05-01.tsv)
- [semicolon csv (csv2 ;)](https://github.com/GuillaumePressiat/orpha/blob/master/data/orpha_table_semicolon_fr_2019-05-01.csv)




### Harvesting des données sur orphanet (old / python selenium)

**Deuxième option :** avec selenium on récupère les informations présentées sur le site (python notebook et premier projet [selenium](https://fr.wikipedia.org/wiki/Selenium_(informatique)) pour moi).

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
