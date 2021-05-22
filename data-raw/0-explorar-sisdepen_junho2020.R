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


# Dados estabelecimento ---------------------------------------------------

# pegar as variáveis do bloco 1 e talvez 2

base <- sisdepen2020 %>%
  dplyr::select(estabelecimento_nm:cod_ibge,
                dplyr::matches(match = "^[1]\\."))

names(base)


base %>%
  renomeia_coluna("data_inauguracao", "1.6 Data de inauguração") %>%
  renomeia_coluna("dest_original_genero", "1.1 Estabelecimento originalmente") %>%
  renomeia_coluna("dest_original_tipo", "1.2 Tipo de estabelecimento") %>%
  renomeia_coluna("tipo_gestao", "1.4 Gestão do estabelecimento") %>%
  renomeia_coluna("regimento_interno_possui", "1.8 Possui regimento") %>%
  renomeia_coluna("regimento_interno_exclusivo", "1.9 O regimento interno") %>%
  renomeia_coluna("cap_provisorio_masc", "1.3 .* provisórios \\| Masculino") %>%
  renomeia_coluna("cap_provisorio_fem", "1.3 .* provisórios \\| Feminino") %>%
  renomeia_coluna("cap_rfechado_masc", "1.3 .* fechado \\| Masculino") %>%
  renomeia_coluna("cap_rfechado_fem", "1.3 .* fechado \\| Feminino") %>%
  renomeia_coluna("cap_rsemiaberto_masc", "1.3 .* semiaberto \\| Masculino") %>%
  renomeia_coluna("cap_rsemiaberto_fem", "1.3 .* semiaberto \\| Feminino")
    names()


