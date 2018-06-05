library(dplyr, warn.conflicts = FALSE)

u <- jsonlite::read_json('http://www.orphadata.org/data/export/fr_product1.json', simplifyVector = TRUE)

uu <- u$JDBOR$DisorderList[[1]]$Disorder[[1]]
names(u$JDBOR$DisorderList[[1]]$Disorder[[1]]) %>% cat(sep = "\n")

# Partie liste à profondeur 1
w <- dplyr::as_tibble(uu) %>%
  tidyr::gather(key, val, - id, - OrphaNumber) %>%
  mutate(multiple = purrr::map(val, 'count'),
         lang = purrr::map(val, 'lang')) %>%
  filter(lang != 'NULL') %>%
  mutate(
    contenu =
      case_when(!(lang == "NULL") & key == 'ExpertLink' ~ purrr::map(val, 'link'),
                !(lang == "NULL") & key == 'Name' ~ purrr::map(val, 'label'))) %>%
  select(id, OrphaNumber, contenu, key) %>%
  tidyr::spread(key, contenu) %>%
  mutate_all(unlist)

# Partie liste à profondeur > 1
z <- dplyr::as_tibble(uu) %>%
  tidyr::gather(key, val, - id, - OrphaNumber) %>%
  mutate(multiple = purrr::map(val, 'count'),
         lang = purrr::map(val, 'lang')) %>%
  mutate(
    contenu =
      case_when(key == 'SynonymList'  ~ purrr::map(val, 'Synonym'),
                key == 'DisorderFlagList'  ~ purrr::map(val, 'DisorderFlag'),
                key == 'DisorderType'  ~ val,
                key == 'ExternalReferenceList' ~ purrr::map(val, 'ExternalReference'),
                key == 'DisorderDisorderAssociationList' ~ purrr::map(val, 'DisorderDisorderAssociation'),
                key == 'TextualInformationList' ~ purrr::map(val, 'TextualInformation')))


extz <- function(x){unlist(lapply(x, function(x)paste0(x, collapse = " ; ")))}

extract_element <- function(cc, el){purrr::flatten(purrr::modify_depth(cc, 2, el))}


y <- z %>%
  filter(key == 'SynonymList') %>%
  filter(multiple > 0) %>% 
  select(id, OrphaNumber, contenu) %>%
  group_by(id, OrphaNumber) %>%
  mutate(lang  = extz(extract_element(contenu, 'lang')),
         label = extz(extract_element(contenu, 'label')),
         nsyn  = purrr::map(extract_element(contenu, 'label'), length)) %>%
  select(-contenu)

x <- z %>%
  filter(key == 'DisorderFlagList') %>%
  select(id, OrphaNumber, contenu) %>%
  group_by(id, OrphaNumber) %>%
  mutate(idd  = extz(extract_element(contenu, 'id')),
         label = extz(extract_element(contenu, 'Label')),
         nb  = purrr::map(extract_element(contenu, 'Label'), length)) %>%
  select(-contenu)

refs2 <- z %>%
  filter(key == 'ExternalReferenceList') %>%
  filter(multiple > 0) %>% 
  select(id, OrphaNumber, contenu) %>%
  group_by(id, OrphaNumber) %>%
  mutate(idd  = extz(extract_element(contenu, 'id')),
         sources = extract_element(contenu, 'Source'),
         references = extract_element(contenu,  'Reference'),
         nb  = purrr::map(extract_element(contenu,'Source'), length)) %>%
  select(-contenu)

sources <- purrr::flatten_chr(refs2$sources) %>% stringr::str_trim()
references <- purrr::flatten_chr(refs2$references) %>% stringr::str_trim()
refs3 <- refs2 %>% dplyr::select(id, OrphaNumber, nb) %>% mutate(nb = unlist(nb)) %>% ungroup()
refs3 <- as.data.frame(lapply(refs3, rep, refs3$nb), stringsAsFactors = F) %>% dplyr::tbl_df()
refs3 <- dplyr::bind_cols(refs3,data.frame(Source = sources, stringsAsFactors = F),
                          data.frame(References = references, stringsAsFactors = F) ) %>%
  dplyr::tbl_df()

refs <- refs3 %>%
  group_by(id, OrphaNumber, Source) %>%
  summarise(References = paste0(References, collapse = " ; ")) %>%
  tidyr::spread(Source, References, fill = "")


types <- z %>%
  filter(key == 'DisorderType') %>%
  select(id, OrphaNumber, contenu) %>%
  group_by(id, OrphaNumber) %>% 
  mutate(Type = extz(purrr::map(contenu, 'Name') %>% purrr::modify_depth(2, 'label')))

assocs <- z %>%
  filter(key == 'DisorderDisorderAssociationList') %>%
  filter(multiple > 0) %>% 
  select(id, OrphaNumber, contenu) %>%
  group_by(id, OrphaNumber)

textes  <- z %>%
  filter(key == 'TextualInformationList') %>%
  select(id, OrphaNumber, contenu) %>%
  group_by(id, OrphaNumber) %>%
  mutate(idd  = purrr::flatten(purrr::modify_depth(contenu, 2, 'id')),
         texte = purrr::modify_depth(contenu, 2, 'TextSectionList'))

# Constitution d'une table avec les éléments présentables sous la forme d'un tableau
orpha_table <- list(w ,
                    types %>% select(id, OrphaNumber, Type),
                    x %>% select(-idd, -nb) %>% rename(statut = label),
                    y %>% select(-lang) %>% rename(Synonymes = label) %>% mutate(nsyn = unlist(nsyn)),
                    refs) %>%
  purrr::reduce(left_join, by = c('id', 'OrphaNumber')) %>% 
  arrange(as.integer(OrphaNumber))

glimpse(orpha_table)

readr::write_tsv(orpha_table, 'data/orpha_table.tsv', na = "")
readr::write_csv(orpha_table, 'data/orpha_table.csv', na = "")
readr::write_delim(orpha_table, 'data/orpha_table_comma.csv', na = "", delim = ";")


