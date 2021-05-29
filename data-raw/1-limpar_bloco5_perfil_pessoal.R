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
  dplyr::select(estabelecimento_nm, uf, cod_ibge,
                dplyr::matches(match = "^[5]\\.[^8] .*[^incidências]"))
names(base)


# Renomear colunas --------------------------------------------------------

base %>%
  renomeia_coluna("possui_registro_idade", "5.1 .* tem condições de obter") %>%
  renomeia_coluna("possui_registro_raca", "5.2 .* tem condições de obter") %>%
  renomeia_coluna("possui_registro_procedencia", "5.3 .* tem condições de obter") %>%
  renomeia_coluna("possui_registro_estadocivil", "5.3 .* tem condições de obter") %>%

  # quanidade por idade
  # 18 a 24
  renomeia_coluna("quantidade_idade_18a24_fem", "5.1 .* faixa etária .* 18 a 24.* Femi") %>%
  renomeia_coluna("quantidade_idade_18a24_mas", "5.1 .* faixa etária .* 18 a 24.* Masc") %>%
  # 25 a 29
  renomeia_coluna("quantidade_idade_25a29_fem", "5.1 .* faixa etária .* 25 a 29.* Femi") %>%
  renomeia_coluna("quantidade_idade_25a29_mas", "5.1 .* faixa etária .* 25 a 29.* Masc") %>%
  # 30 a 34
  renomeia_coluna("quantidade_idade_30a34_fem", "5.1 .* faixa etária .* 30 a 34.* Femi") %>%
  renomeia_coluna("quantidade_idade_30a34_mas", "5.1 .* faixa etária .* 30 a 34.* Masc") %>%
  # 35 a 45
  renomeia_coluna("quantidade_idade_35a45_fem", "5.1 .* faixa etária .* 35 a 45.* Femi") %>%
  renomeia_coluna("quantidade_idade_35a45_mas", "5.1 .* faixa etária .* 35 a 45.* Masc") %>%
  # 46 a 60
  renomeia_coluna("quantidade_idade_46a60_fem", "5.1 .* faixa etária .* 46 a 60.* Femi") %>%
  renomeia_coluna("quantidade_idade_46a60_mas", "5.1 .* faixa etária .* 46 a 60.* Masc") %>%
  # 61 a 70
  renomeia_coluna("quantidade_idade_61a70_fem", "5.1 .* faixa etária .* 61 a 70.* Femi") %>%
  renomeia_coluna("quantidade_idade_61a70_mas", "5.1 .* faixa etária .* 61 a 70.* Masc") %>%
  # mais 70
  renomeia_coluna("quantidade_idade_mais70_fem", "5.1 .* faixa etária .* mais de 70.* Femi") %>%
  renomeia_coluna("quantidade_idade_mais70_mas", "5.1 .* faixa etária .* mais de 70.* Masc") %>%
  # não informada
  renomeia_coluna("quantidade_idade_naoinformada_fem", "5.1 .* faixa etária .*Não informado .* Femi") %>%
  renomeia_coluna("quantidade_idade_naoinformada_mas", "5.1 .* faixa etária .*Não informado .* Masc") %>%
  ### raça
  # branca
  renomeia_coluna("quantidade_raca_branca_fem", "5.2 .*raça.* Branca .* Femi") %>%
  renomeia_coluna("quantidade_raca_branca_mas", "5.2 .*raça.* Branca .* Masc") %>%
  # preta
  renomeia_coluna("quantidade_raca_preta_fem", "5.2 .*raça.* Preta .* Femi") %>%
  renomeia_coluna("quantidade_raca_preta_mas", "5.2 .*raça.* Preta .* Masc") %>%
  # parda
  renomeia_coluna("quantidade_raca_parda_fem", "5.2 .*raça.* Parda .* Femi") %>%
  renomeia_coluna("quantidade_raca_parda_mas", "5.2 .*raça.* Parda .* Masc") %>%
  # indígena
  renomeia_coluna("quantidade_raca_amarela_fem", "5.2 .*raça.* Amarela .* Femi") %>%
  renomeia_coluna("quantidade_raca_amarela_mas", "5.2 .*raça.* Amarela .* Masc") %>%
  # amarela
  renomeia_coluna("quantidade_raca_indigena_fem", "5.2 .*raça.* Indígena .* Femi") %>%
  renomeia_coluna("quantidade_raca_indigena_mas", "5.2 .*raça.* Indígena .* Masc") %>%
  # não informada
  renomeia_coluna("quantidade_raca_naoinformada_fem", "5.2 .*raça.* Não informado .* Femi") %>%
  renomeia_coluna("quantidade_raca_naoinformada_mas", "5.2 .*raça.* Não informado .* Masc") %>%
  ## procedência
  # urbana - interior
  renomeia_coluna("quantidade_procedencia_interior_mas", "5.3 .*proced.ncia.* Interior .* Masc") %>%
  renomeia_coluna("quantidade_procedencia_interior_fem", "5.3 .*proced.ncia.* Interior .* Femi") %>%
  # urbana - RM
  renomeia_coluna("quantidade_procedencia_rmetropolitana_mas", "5.3 .*proced.ncia.* Metropolitanas .* Masc") %>%
  renomeia_coluna("quantidade_procedencia_rmetropolitana_fem", "5.3 .*proced.ncia.* Metropolitanas .* Femi") %>%
  # zona rural
  renomeia_coluna("quantidade_procedencia_rural_mas", "5.3 .*proced.ncia.* rural .* Masc") %>%
  renomeia_coluna("quantidade_procedencia_rural_fem", "5.3 .*proced.ncia.* rural .* Femi") %>%
  ## estado civil
  ## pessoas com deficiência
  ## grau de instrução
  ## documentos pessoais
  ## filhos
  names()




