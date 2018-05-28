
u <- pdftools::pdf_text('https://www.orpha.net/orphacom/cahiers/docs/FR/Liste_maladies_rares_par_ordre_alphabetique.pdf')

library(magrittr)

v <- u[3:length(u)] %>% 
  paste0(., collapse = "\n") %>% 
  stringr::str_split('\n') %>% 
  purrr::flatten_chr()

liste_codes <- u[3:length(u)] %>% 
  paste0(., collapse = "\n") %>% 
  stringr::str_extract_all('[0-9]{2,}') %>% 
  purrr::flatten_chr() %>% 
  .[! (substr(.,1,2) %in% c('29', '43'))] %>% 
  unique()

readr::write_tsv(as.data.frame(liste_codes), '~/Documents/Developpements/Github/orpha/data/liste_codes_janvier_2018.txt')
