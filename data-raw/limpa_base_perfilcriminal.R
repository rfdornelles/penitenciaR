library(penitenciaR)

# Carregar a base ---------------------------------------------------------
base_perfilcriminal <- carrega_e_aplica(arruma_bloco_perfilcriminal)


# Remove colunas vazias ---------------------------------------------------

base_perfilcriminal <- base_perfilcriminal %>%
  dplyr::select(-dplyr::contains("..."))

# Ajusta classes  ---------------------------------------------------------

base_perfilcriminal <- base_perfilcriminal %>%
  dplyr::mutate(
    dplyr::across(
      .cols = dplyr::starts_with("quantidade"),
      .fns = as.numeric
    )
  )

# Exportar ----------------------------------------------------------------

usethis::use_data(base_perfilcriminal, overwrite = TRUE, version = 3)
