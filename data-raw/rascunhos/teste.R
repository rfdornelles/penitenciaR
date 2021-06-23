## Rodrigo Dornelles - Sun May 23 19:17:54 2021
## penitenciaR
## Objetivo: Limpar base SISDEPEN
## Bloco 5 - Perfil criminal


# Pacotes -----------------------------------------------------------

library(magrittr)
library(penitenciaR)


# Lista de arquivos -------------------------------------------------------

lista_arquivos <- fs::dir_info(path = "data-raw/sisdepen/")$path


# Testa função ------------------------------------------------------------
basegrande <- purrr::map_dfr(lista_arquivos, carregar_base_sisdepen)

basegrande %>%
  dplyr::select(
    dplyr::matches("^[^2-9]\\."))
  )
