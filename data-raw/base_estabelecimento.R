library(penitenciaR)

# Carregar a base ---------------------------------------------------------
base_estabelecimento <- carrega_e_aplica(arruma_bloco_estabelecimento)


# Checagem de consistência ------------------------------------------------

base_estabelecimento %>%
  janitor::get_dupes()

# quais anos foram lidos
base_estabelecimento %>%
  dplyr::distinct(id_origem_sisdepen)

base_estabelecimento %>%
  janitor::tabyl(terceiriza_administrativo)



base_estabelecimento %>%
  dplyr::select(dplyr::starts_with("terceiriza")) %>%
  dplyr::mutate(dplyr::across(.fns = as.factor)) %>%
  dplyr::summarise(dplyr::across(.fns = ~dplyr::count(.x)))


base_estabelecimento %>%
  dplyr::count(
    dplyr::across(.cols = dplyr::starts_with("terceiriza"))
  )

base_estabelecimento %>%
  dplyr::select(
    dplyr::starts_with("terceiriza")
  ) %>%
  dplyr::mutate(
    dplyr::across(.fns = numero_para_sim_nao, transforma_na = TRUE, logico = TRUE)
  ) %>%
  conta_valores()

base_estabelecimento %>%
  dplyr::select(
    dplyr::starts_with("terceiriza")
  ) %>%
  dplyr::mutate(
    dplyr::across(.fns = numero_para_sim_nao, transforma_na = TRUE,
                  logico = TRUE
  )) -> teste

base_estabelecimento %>%
  conta_valores("terceiriza")

teste %>%
conta_valores("terceiriza")

base_estabelecimento %>%
  dplyr::mutate(
    dplyr::across(
      .cols = dplyr::matches("^(capacidade|quantidade)"),
      .fns = as.numeric
    )
  )

penitenciaR::ler_colunas(base_estabelecimento)

base_estabelecimento %>%
  conta_valores("capacidade")



