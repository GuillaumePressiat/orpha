
library(dplyr, warn.conflicts = FALSE)
# Exemple pour lire un fichier scrapé et le formater en table  
parse_orpha <- function(x){
  d <- readr::read_lines(paste0('python/res/', x))
  tibble(d = d) %>%
    mutate(code = stringr::str_extract(d, 'ORPHA:([0-9]+)') %>% stringr::str_remove('ORPHA:'),
           libelle = stringr::str_extract(d, 'ORPHA:[0-9]+.*') %>% stringr::str_remove('ORPHA:[0-9]+  '),
           synonymes = stringr::str_extract(d, 'Synonyme\\(s\\) : .*') %>% stringr::str_remove('Synonyme\\(s\\) : ') ,
           cim = stringr::str_extract(d, 'CIM-10 : .*') %>% stringr::str_remove('CIM-10 : '),
           prevalence = stringr::str_extract(d, 'Prévalence : .*') %>% stringr::str_remove('Prévalence : '),
           age_apparition = stringr::str_extract(d, "Âge d'apparition : .*") %>% stringr::str_remove("Âge d'apparition : "),
           OMIM = stringr::str_extract(d, 'OMIM : .*') %>% stringr::str_remove('OMIM : '),
           UMLS = stringr::str_extract(d, 'UMLS : .*') %>% stringr::str_remove('UMLS : '),
           MeSH = stringr::str_extract(d, 'MeSH : .*') %>% stringr::str_remove('MeSH : '),
           GARD = stringr::str_extract(d, 'GARD : .*') %>% stringr::str_remove('GARD : '),
           MedDRA = stringr::str_extract(d, 'MedDRA : .*') %>% stringr::str_remove('MedDRA : ')) %>%
    tidyr::fill(code, libelle) %>% 
    select(-d) %>%
    tidyr::gather(var, val, -code, -libelle) %>%
    filter(!is.na(val)) %>%
    tidyr::spread(var, val)
}

parse_orpha(13)

# A tibble: 1 x 11
# code  libelle                                          age_apparition           cim   GARD  MedDRA MeSH    OMIM   prevalence synonymes                                                                  UMLS    
# <chr> <chr>                                            <chr>                    <chr> <chr> <chr>  <chr>   <chr>  <chr>      <chr>                                                                      <chr>   
#   1 13    Déficit en 6-pyruvoyl-tétrahydroptérine synthase Petite enfance, Néonatal E70.1 5682  -      C535325 261640 Inconnu    Hyperphénylalaninémie par déficit en 6-pyruvoyl-tétrahydroptérine synthase C0878676


codes <- list.files('python/res') %>% sort

# test
tibble_orpha.net <- codes %>% purrr::map(parse_orpha) %>% bind_rows

readr::write_csv(tibble_orpha.net, 'data/test.csv')
