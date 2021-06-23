library(penitenciaR)

# Carregar a base ---------------------------------------------------------
base_perfilpessoal <- carrega_e_aplica(arruma_bloco_perfilpessoal)


# Classes -----------------------------------------------------------------

base_perfilpessoal <- base_perfilpessoal %>%
  dplyr::mutate(
    dplyr::across(
      .cols = dplyr::starts_with("quantidade"),
      .fns = as.numeric
    )
  )


usethis::use_data(base_perfilpessoal, overwrite = TRUE, version = 3)
