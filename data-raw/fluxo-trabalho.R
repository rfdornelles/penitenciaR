library(magrittr)
library(penitenciaR)

# Carregar a base ---------------------------------------------------------
lista_arquivos <- fs::dir_info(path = "data-raw/sisdepen/")$path

teste <- purrr::map_dfr(lista_arquivos, ~{
  print(.x)

  purrr::possibly(
    .f = gerar_base_total_sisdepen, otherwise = NULL)(.x, "text")

  })


teste_fun <- function (lista, funcao) {

  lista %>%
    purrr::map(penitenciaR::carregar_base_sisdepen, "text") %>%
    purrr::map_df(
      .f = purrr::possibly(funcao, otherwise = NULL, quiet = FALSE)
    )

}

bloco1 <- teste_fun(lista_arquivos, arruma_bloco_estabelecimento)
bloco4 <- teste_fun(lista_arquivos, arruma_bloco_populacao)
bloco5a <- teste_fun(lista_arquivos, arruma_bloco_perfilpessoal)
bloco5b <- teste_fun(lista_arquivos, arruma_bloco_perfilcriminal)

teste %>%
  janitor::get_dupes()

teste %>%
  janitor::remove_empty(quiet = FALSE)

ler_colunas(teste)

teste %>%
  dplyr::mutate(
    dplyr::across(
      .cols = dplyr::starts_with("quantidade_"),
      .fns = as.numeric
    )
  )
    )
  )
