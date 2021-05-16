## penitenciaR
## Rodrigo Dornelles - 15/05/2021
## Carregar e analisar a base de junho de 2020 do SISDEPEN


# Pacotes -----------------------------------------------------------------
library(magrittr)


# Carregar a base ---------------------------------------------------------

sisdepen2020 <- readxl::read_excel("data-raw/sisdepen/InfopenJunhode2020.xlsx")


# Explorar ----------------------------------------------------------------

# são 1331 variáveis!
# criar uma tabela com os nomes

variaveis <- names(sisdepen2020) %>%
  tibble::as_tibble() %>%
  dplyr::mutate(separadores = stringr::str_count(value, " | ")) %>%
  dplyr::arrange(-separadores)

# separar as variaveis por assuntos
variaveis <- variaveis %>%
  dplyr::mutate(
    topico = stringr::str_extract(value, "^\\d\\.\\d+")
  ) %>%
  tidyr::separate(col = topico,
                  into = c("topico_principal", "topico_outro"),
                  sep = "\\.") %>%
  dplyr::mutate(
    dplyr::across(.cols = dplyr::contains("topico"),
                              .fns = as.numeric)) %>%
  dplyr::relocate(value, .after = topico_outro)

variaveis %>%
  dplyr::group_by(topico_principal) %>%
  dplyr::filter(topico_outro == min(topico_outro)) %>%
  dplyr::distinct(topico_principal, .keep_all = TRUE) %>%
  dplyr::arrange(topico_principal) %>%
  View("Tópico principal")

## São 7 grandes temas. Vou separar em 7 bases, tendo como chaves
# os dados de identificacao do estabelecimento

# 1 - dados do estabelecimento
# 2 - estrutura física e de atendimento
# 3 - parte administrativa / servidores
# 4 - população prisional
# 5 - perfil da população
# 6 - assistências
# 7 - inspeções

# vou fazer a limpeza de cada uma delas, conforme me interesse o tópico
# isso deve diminuir os problemas de compatibilidade


# Identificar chaves ------------------------------------------------------

variaveis %>%
  dplyr::filter(is.na(topico_principal))

# Vou selecionar como chaves:
# `Nome do Estabelecimento`
# `UF`
# `Código IBGE`

sisdepen2020 <- sisdepen2020 %>%
  dplyr::rename(estabelecimento_nm = `Nome do Estabelecimento`,
                uf = UF,
                cod_ibge = `Código IBGE`) %>%
  dplyr::select(-1:-2)

sisdepen2020 %>%
  dplyr::distinct(estabelecimento_nm, uf,  .keep_all = TRUE)

# usethis::use_data(sisdepen_junho2020, overwrite = TRUE)
