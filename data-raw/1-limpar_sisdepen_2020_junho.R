## Rodrigo Dornelles - Sun May 23 19:17:54 2021
## penitenciaR
## Objetivo: Limpar base SISDEPEN
## Bloco 1 e 2


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

# Dados estabelecimento ---------------------------------------------------

# pegar as variáveis do bloco 1 e talvez 2

base <- sisdepen2020 %>%
  dplyr::select(estabelecimento_nm:cod_ibge,
                dplyr::matches(match = "^[1]\\."))

names(base)


base_renomeada <- base %>%
  renomeia_coluna("data_inauguracao", "1.6 Data de inauguração") %>%
  renomeia_coluna("dest_original_genero", "1.1 Estabelecimento originalmente") %>%
  renomeia_coluna("dest_original_tipo", "1.2 Tipo de estabelecimento") %>%
  renomeia_coluna("dest_original_original", "1.7 O estabelecimento") %>%
  renomeia_coluna("tipo_gestao", "1.4 Gestão do estabelecimento") %>%
  renomeia_coluna("regimento_interno_possui", "1.8 Possui regimento") %>%
  renomeia_coluna("regimento_interno_exclusivo", "1.9 O regimento interno") %>%
  renomeia_coluna("cap_provisorio_mas", "1.3 .* provisórios \\| Masculino") %>%
  renomeia_coluna("cap_provisorio_fem", "1.3 .* provisórios \\| Feminino") %>%
  renomeia_coluna("cap_rfechado_mas", "1.3 .* fechado \\| Masculino") %>%
  renomeia_coluna("cap_rfechado_fem", "1.3 .* fechado \\| Feminino") %>%
  renomeia_coluna("cap_semiaberto_mas", "1.3 .* semiaberto \\| Masculino") %>%
  renomeia_coluna("cap_semiaberto_fem", "1.3 .* semiaberto \\| Feminino") %>%
  renomeia_coluna("cap_rdd_mas", "1.3 .* disciplinar .* \\| Masculino") %>%
  renomeia_coluna("cap_rdd_fem", "1.3 .* disciplinar .* \\| Feminino") %>%
  renomeia_coluna("cap_mseg_mas", "1.3 .* medidas de seg.* \\| Masculino") %>%
  renomeia_coluna("cap_mseg_fem", "1.3 .* medidas de seg.* \\| Feminino") %>%
  renomeia_coluna("cap_aberto_mas", "1.3 .* Regime aberto.* \\| Masculino") %>%
  renomeia_coluna("cap_aberto_fem", "1.3 .* Regime aberto.* \\| Feminino") %>%
  renomeia_coluna("tipo_capacidade_outros", "1.3 Capacidade .* (Qual\\(is\\)\\?)$") %>%
  renomeia_coluna("cap_outro_mas", "1.3 Capacidade .* Outro.* \\| Masculino") %>%
  renomeia_coluna("cap_outro_fem", "1.3 Capacidade .* Outro.* \\| Feminino") %>%
  renomeia_coluna("qnt_celas_interdidatas", "1.3 .* \\| Celas não aptas") %>%
  renomeia_coluna("cap_interditada_mas", "1.3 .* desativadas .* Masculino") %>%
  renomeia_coluna("cap_interditada_fem", "1.3 .* desativadas .* Feminino") %>%
  # ver com cuidado essa: terceiriza_nenhum deveria ser não para todos os demais
  renomeia_coluna("terceiriza_nenhum", "1.5 .* Nenhum") %>%
  renomeia_coluna("terceiriza_alimentacao", "1.5 .* Alimentação") %>%
  renomeia_coluna("terceiriza_limpeza", "1.5 .* Limpeza") %>%
  renomeia_coluna("terceiriza_lavanderia", "1.5 .* Lavanderia") %>%
  renomeia_coluna("terceiriza_saude", "1.5 .* Saúde")  %>%
  renomeia_coluna("terceiriza_educacao", "1.5 .* educacional")  %>%
  renomeia_coluna("terceiriza_laboral", "1.5 .* laboral")  %>%
  renomeia_coluna("terceiriza_ass_social", "1.5 .* Assistência social")  %>%
  renomeia_coluna("terceiriza_ass_juridica", "1.5 .* Assistência jurídica") %>%
  renomeia_coluna("terceiriza_administrativo", "1.5 .* administrativos")  %>%
  renomeia_coluna("terceiriza_quais_outros", "1.5 .* Outro")


base_renomeada %>%
  View()

#TODO: comparar as colunas que sobraram pra conferir a confiabilidade
#TODO: checar se rola fazer para os outros anos

