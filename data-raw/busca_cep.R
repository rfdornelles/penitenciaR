
# Pacotes -----------------------------------------------------------------

library(magrittr)


# Carregar token ----------------------------------------------------------
source(here::here("data-raw/tokenCEP.R"))


# Carregar base -----------------------------------------------------------
base <- readxl::read_excel(here::here(
  "data-raw/sisdepen/InfopenJunhode2020.xlsx"))


# Buscar CEPs -------------------------------------------------------------

base_cep <- base %>%
  dplyr::filter(!is.na(CEP)) %>%
  dplyr::pull(CEP) %>%
  purrr::map_df(~{
    cepR::busca_multi(.x, token = token_cep)
    Sys.sleep(1)
  })

# Salvar base -------------------------------------------------------------

usethis::use_data(base_cep, overwrite = TRUE)

