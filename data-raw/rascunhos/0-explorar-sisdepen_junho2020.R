## penitenciaR
## Rodrigo Dornelles - 15/05/2021
## Carregar e analisar a base de junho de 2020 do SISDEPEN


# Pacotes -----------------------------------------------------------------
library(magrittr)
library(penitenciaR)


# Carregar a base ---------------------------------------------------------

sisdepen2020 <- readxl::read_excel("data-raw/sisdepen/InfopenJunhode2020.xlsx")


# Explorar ----------------------------------------------------------------

# são 1331 variáveis!
### criar uma tabela com os nomes

variaveis <- names(sisdepen2020) %>%
  # transforma em tibble
  tibble::as_tibble() %>%
  # contar quantos " | " há no nome, pra saber o quão "dividida" tá
  dplyr::mutate(separadores = stringr::str_count(value, " | ")) %>%
  # ordenar do mais pro menos dividido
  dplyr::arrange(-separadores)

#### separar as variaveis por assuntos
variaveis <- variaveis %>%
  dplyr::mutate(
    # itentificar o número do tópico pra podemos agrupar
    topico = stringr::str_extract(value, "^\\d\\.\\d+")
  ) %>%
  # separar o tópico principal dos demais
  tidyr::separate(col = topico,
                  into = c("topico_principal", "topico_outro"),
                  sep = "\\.") %>%
  dplyr::mutate(
    # trasnformar em numérico
    dplyr::across(.cols = dplyr::contains("topico"),
                              .fns = as.numeric)) %>%
  # organizar a ordem
  dplyr::relocate(value, .after = topico_outro)

# Olhar quais são os temas principais de cada variável
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
  # retira colunas inuteis
  dplyr::select(-1:-2)

# verifica se tem duplicados
sisdepen2020 %>%
  janitor::get_dupes(estabelecimento_nm, uf)


# deu bom!!



