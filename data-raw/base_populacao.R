library(penitenciaR)

# Carregar a base ---------------------------------------------------------
base_populacao <- carrega_e_aplica(arruma_bloco_populacao)


# Ajustar classe ----------------------------------------------------------

base_populacao <- base_populacao %>%
  dplyr::mutate(
    dplyr::across(
      .cols = dplyr::starts_with("quantidade"),
      .fns = as.numeric
    )
  )

usethis::use_data(base_populacao, overwrite = TRUE, version = 3)
