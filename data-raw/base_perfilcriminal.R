library(penitenciaR)

# Carregar a base ---------------------------------------------------------
base_perfilcriminal <- carrega_e_aplica(arruma_bloco_perfilcriminal)

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
