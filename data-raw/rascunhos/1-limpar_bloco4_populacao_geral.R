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
                dplyr::matches(match = "^[4]\\."))

# stringr::str_c(names(base), collapse = "\n") %>% cat()


# Renomear colunas --------------------------------------------------------

# base_renomeada <-
base %>%
  # provisórios
  renomeia_coluna("quantidade_presoprovisorio_jusestadual_mas", "4.1 .*provisórios.*Estadual Masc") %>%
  renomeia_coluna("quantidade_presoprovisorio_jusestadual_fem", "4.1 .*provisórios.*Estadual Femin") %>%
  renomeia_coluna("quantidade_presoprovisorio_jusfederal_mas", "4.1 .*provisórios.*Federal Masc") %>%
  renomeia_coluna("quantidade_presoprovisorio_jusfederal_fem", "4.1 .*provisórios.*Federal Femin") %>%
  renomeia_coluna("quantidade_presoprovisorio_outrajus_mas", "4.1 .*provisórios.*Outros.* Masc") %>%
  renomeia_coluna("quantidade_presoprovisorio_outrajus_fem", "4.1 .*provisórios.*Outros.* Femin") %>%
  # presos sentenciados - regime fechado
  renomeia_coluna("quantidade_sentenca_rf_jusestadual_mas", "4.1 .*sentenciados.*fechado.*Estadual Masc") %>%
  renomeia_coluna("quantidade_sentenca_rf_jusestadual_fem", "4.1 .*sentenciados.*fechado.*Estadual Femin") %>%
  renomeia_coluna("quantidade_sentenca_rf_jusfederal_mas", "4.1 .*sentenciados.*fechado.*Federal Masc") %>%
  renomeia_coluna("quantidade_sentenca_rf_jusfederal_fem", "4.1 .*sentenciados.*fechado.*Federal Femin") %>%
  renomeia_coluna("quantidade_sentenca_rf_outrajus_mas", "4.1 .*sentenciados.*fechado.*Outros.* Masc") %>%
  renomeia_coluna("quantidade_sentenca_rf_outrajus_fem", "4.1 .*sentenciados.*fechado.*Outros.* Femin") %>%
  # presos sentenciados - regime semi aberto
  renomeia_coluna("quantidade_sentenca_rsa_jusestadual_mas", "4.1 .*sentenciados.*semiaberto.*Estadual Masc") %>%
  renomeia_coluna("quantidade_sentenca_rsa_jusestadual_fem", "4.1 .*sentenciados.*semiaberto.*Estadual Femin") %>%
  renomeia_coluna("quantidade_sentenca_rsa_jusfederal_mas", "4.1 .*sentenciados.*semiaberto.*Federal Masc") %>%
  renomeia_coluna("quantidade_sentenca_rsa_jusfederal_fem", "4.1 .*sentenciados.*semiaberto.*Federal Femin") %>%
  renomeia_coluna("quantidade_sentenca_rsa_outrajus_mas", "4.1 .*sentenciados.*semiaberto.*Outros.* Masc") %>%
  renomeia_coluna("quantidade_sentenca_rsa_outrajus_fem", "4.1 .*sentenciados.*semiaberto.*Outros.* Femin") %>%
  # presos sentenciados - regime aberto
  renomeia_coluna("quantidade_sentenca_ra_jusestadual_mas", "4.1 .*sentenciados.* aberto.*Estadual Masc") %>%
  renomeia_coluna("quantidade_sentenca_ra_jusestadual_fem", "4.1 .*sentenciados.* aberto.*Estadual Femin") %>%
  renomeia_coluna("quantidade_sentenca_ra_jusfederal_mas", "4.1 .*sentenciados.* aberto.*Federal Masc") %>%
  renomeia_coluna("quantidade_sentenca_ra_jusfederal_fem", "4.1 .*sentenciados.* aberto.*Federal Femin") %>%
  renomeia_coluna("quantidade_sentenca_ra_outrajus_mas", "4.1 .*sentenciados.* aberto.*Outros.* Masc") %>%
  renomeia_coluna("quantidade_sentenca_ra_outrajus_fem", "4.1 .*sentenciados.* aberto.*Outros.* Femin") %>%
  # presos em medida de segurança - internação
  renomeia_coluna("quantidade_medseg_internacao_jusestadual_mas", "4.1 .*de segurança.* interna.*Estadual Masc") %>%
  renomeia_coluna("quantidade_medseg_internacao_jusestadual_fem", "4.1 .*de segurança.* interna.*Estadual Femin") %>%
  renomeia_coluna("quantidade_medseg_internacao_jusfederal_mas", "4.1 .*de segurança.* interna.*Federal Masc") %>%
  renomeia_coluna("quantidade_medseg_internacao_jusfederal_fem", "4.1 .*de segurança.* interna.*Federal Femin") %>%
  renomeia_coluna("quantidade_medseg_internacao_outrajus_mas", "4.1 .*de segurança.* interna.*Outros.* Masc") %>%
  renomeia_coluna("quantidade_medseg_internacao_outrajus_fem", "4.1 .*de segurança.* interna.*Outros.* Femin") %>%
  # presos em medida de segurança - tratamento ambulatorial
  renomeia_coluna("quantidade_medseg_ambulatorial_jusestadual_mas", "4.1 .*de segurança.* ambulatorial.*Estadual Masc") %>%
  renomeia_coluna("quantidade_medseg_ambulatorial_jusestadual_fem", "4.1 .*de segurança.* ambulatorial.*Estadual Femin") %>%
  renomeia_coluna("quantidade_medseg_ambulatorial_jusfederal_mas", "4.1 .*de segurança.* ambulatorial.*Federal Masc") %>%
  renomeia_coluna("quantidade_medseg_ambulatorial_jusfederal_fem", "4.1 .*de segurança.* ambulatorial.*Federal Femin") %>%
  renomeia_coluna("quantidade_medseg_ambulatorial_outrajus_mas", "4.1 .*de segurança.* ambulatorial.*Outros.* Masc") %>%
  renomeia_coluna("quantidade_medseg_ambulatorial_outrajus_fem", "4.1 .*de segurança.* ambulatorial.*Outros.* Femin") #%>%
  # # presos em RDD
  # renomeia_coluna("quantidade_presos_rdd", "4.1 .*regime disciplinar diferenciado") %>%
  # # estabelecimento - controle se provisórios estão a mais de 90 dias
  # renomeia_coluna("controle_excesso_prazo_existe", "4.2 .*controle.*90 dias.*\\?$") %>%
  # renomeia_coluna("quantidade_excesso_prazo_mas", "4.2 .*controle.*90 dias.*Masc") %>%
  # renomeia_coluna("quantidade_excesso_prazo_fem", "4.2 .*controle.*90 dias.*Fem") %>%
  #



base_renomeada %>%
  View()


