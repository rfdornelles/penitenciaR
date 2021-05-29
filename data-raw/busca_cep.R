
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
  unique() %>%
  #head(10) %>%
  purrr::map_df(~{
   (resposta <- cepR::busca_cep(.x, token = token_cep))

    Sys.sleep(1)

    resposta <- tibble::tibble(
      "cep" = .x,
      "lat" = resposta$latitude,
      "long" = resposta$longitude
    )
   # print(resposta)
    return(resposta)

    })

# Salvar base -------------------------------------------------------------

usethis::use_data(base_cep, overwrite = TRUE)


