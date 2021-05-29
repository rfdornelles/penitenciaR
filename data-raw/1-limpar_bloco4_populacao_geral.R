## Rodrigo Dornelles - Sun May 23 19:17:54 2021
## penitenciaR
## Objetivo: Limpar base SISDEPEN
## Bloco 4


# Pacotes -----------------------------------------------------------

library(magrittr)
library(penitenciaR)


# Lista de arquivos -------------------------------------------------------

lista_arquivos <- fs::dir_info(path = "data-raw/sisdepen/")$path


# Carregar a base ---------------------------------------------------------
path_base <- lista_arquivos[11] # seleciona junho 2020


base_sisdepen <- readxl::read_excel(path_base)

# Vou selecionar como chaves:
# `Nome do Estabelecimento`
# `UF`
# `Código IBGE`

sisdepen2020 <- base_sisdepen %>%
  dplyr::rename(estabelecimento_nm = `Nome do Estabelecimento`,
                uf = UF,
                cod_ibge = `Código IBGE`) %>%
  # retira colunas inuteis
  dplyr::select(-1:-2)

# Dados população ---------------------------------------------------------

# pegar as variáveis do bloco 4
base <- sisdepen2020 %>%
  dplyr::select(estabelecimento_nm:cod_ibge,
                dplyr::matches(match = "^[4]\\."))

names(base)


# Renomear colunas --------------------------------------------------------

base_renomeada <- base %>%
  renomeia_coluna("data_inauguracao", "1.6 Data de inauguração") %>%
  renomeia_coluna("terceiriza_quais_outros", "1.5 .* Outro")


base_renomeada %>%
  View()


