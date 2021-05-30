
# Pacotes -----------------------------------------------------------------
library(magrittr)
library(penitenciaR)



# Carregar a base ---------------------------------------------------------
lista_arquivos <- fs::dir_info(path = "data-raw/sisdepen/")$path

path_base <- lista_arquivos[1] # seleciona junho 2020


# Colunas chave -----------------------------------------------------------

base <- penitenciaR::carregar_base_sisdepen(path_base)

base <- base %>%
  renomeia_coluna("cod_ibge", "ibge", FALSE)
# Bloco 1 - estabelecimento -----------------------------------------------


base_bloco1 <- base %>%
  dplyr::select(nome_estabelecimento:dplyr::matches("1\\.1"),
                dplyr::matches(match = "^[1]\\.")) %>%
  dplyr::mutate(cod_ibge = if ("cod_ibge" %in% names(.)) {
    cod_ibge
  } else {
    NA_character_
  })

base_bloco1 <- base_bloco1 %>%
  renomeia_coluna("nome_estabelecimento_outro", "outras denomina..es") %>%
  renomeia_coluna("endereco_estabelecimento", "endere.o") %>%
  renomeia_coluna("nome_municipio", "munic.pio") %>%
  renomeia_coluna("ambito_federativo", ".mbito") %>%
  renomeia_coluna("bairro_estabelecimento", "bairro") %>%
  renomeia_coluna("cep_estabelecimento", "cep") %>%
  renomeia_coluna("situacao_estabelecimento", "situa..o do estabelecimento") %>%
  renomeia_coluna("data_inauguracao", "1.6 Data de inauguração") %>%
  renomeia_coluna("dest_original_genero", "1.1 Estabelecimento originalmente") %>%
  renomeia_coluna("dest_original_tipo", "1.2 Tipo de estabelecimento") %>%
  renomeia_coluna("dest_original_original", "1.7 O estabelecimento") %>%
  renomeia_coluna("tipo_gestao", "1.4 Gestão do estabelecimento") %>%
  renomeia_coluna("regimento_interno_possui", "1.8 Possui regimento") %>%
  renomeia_coluna("regimento_interno_exclusivo", "1.9 O regimento interno") %>%
  renomeia_coluna("capacidade_provisorio_mas", "1.3 .* provisórios \\| Masculino") %>%
  renomeia_coluna("capacidade_provisorio_fem", "1.3 .* provisórios \\| Feminino") %>%
  renomeia_coluna("capacidade_rfechado_mas", "1.3 .* fechado \\| Masculino") %>%
  renomeia_coluna("capacidade_rfechado_fem", "1.3 .* fechado \\| Feminino") %>%
  renomeia_coluna("capacidade_semiaberto_mas", "1.3 .* semiaberto \\| Masculino") %>%
  renomeia_coluna("capacidade_semiaberto_fem", "1.3 .* semiaberto \\| Feminino") %>%
  renomeia_coluna("capacidade_rdd_mas", "1.3 .* disciplinar .* \\| Masculino") %>%
  renomeia_coluna("capacidade_rdd_fem", "1.3 .* disciplinar .* \\| Feminino") %>%
  renomeia_coluna("capacidade_mseg_mas", "1.3 .* medidas de seg.* \\| Masculino") %>%
  renomeia_coluna("capacidade_mseg_fem", "1.3 .* medidas de seg.* \\| Feminino") %>%
  renomeia_coluna("capacidade_aberto_mas", "1.3 .* Regime aberto.* \\| Masculino") %>%
  renomeia_coluna("capacidade_aberto_fem", "1.3 .* Regime aberto.* \\| Feminino") %>%
  renomeia_coluna("tipo_capacidade_outros", "1.3 Capacidade .* (Qual\\(is\\)\\?)$") %>%
  renomeia_coluna("capacidade_outro_mas", "1.3 Capacidade .* Outro.* \\| Masculino") %>%
  renomeia_coluna("capacidade_outro_fem", "1.3 Capacidade .* Outro.* \\| Feminino") %>%
  renomeia_coluna("quantidade_celas_interdidatas", "1.3 .* \\| Celas não aptas") %>%
  renomeia_coluna("capacidade_interditada_mas", "1.3 .* desativadas .* Masculino") %>%
  renomeia_coluna("capacidade_interditada_fem", "1.3 .* desativadas .* Feminino") %>%
  # ver com cuidado essa: terceiriza_nenhum deveria ser não para todos os demais
  renomeia_coluna("terceiriza_nenhum", "1.5 .* Nenhum") %>%
  renomeia_coluna("terceiriza_alimentacao", "1.5 .* Alimenta..o") %>%
  renomeia_coluna("terceiriza_seguranca", "1.5 .* Seguran.a") %>%
  renomeia_coluna("terceiriza_limpeza", "1.5 .* Limpeza") %>%
  renomeia_coluna("terceiriza_lavanderia", "1.5 .* Lavanderia") %>%
  renomeia_coluna("terceiriza_saude", "1.5 .* Sa.de")  %>%
  renomeia_coluna("terceiriza_educacao", "1.5 .* educacional")  %>%
  renomeia_coluna("terceiriza_laboral", "1.5 .* laboral")  %>%
  renomeia_coluna("terceiriza_ass_social", "1.5 .* Assist.ncia social")  %>%
  renomeia_coluna("terceiriza_ass_juridica", "1.5 .* Assist.ncia jurídica") %>%
  renomeia_coluna("terceiriza_administrativo", "1.5 .* administrativos")  %>%
  renomeia_coluna("terceiriza_quais_outros", "1.5 .* Outro") %>%
  renomeia_coluna("total_capacidade_provisorios", "1.3 .*presos provis.rios.*Total$") %>%
  renomeia_coluna("total_capacidade_regimefechado", "1.3 .*regime fechado.*Total$") %>%
  renomeia_coluna("total_capacidade_regimeaberto", "1.3 .*regime aberto.*Total$") %>%
  renomeia_coluna("total_capacidade_regimesemiaberto", "1.3 .*regime semi?aberto.*Total$") %>%
  renomeia_coluna("total_capacidade_regimedisciplinardiferenciado", "1.3 .*regime disciplinar.*Total$") %>%
  renomeia_coluna("total_capacidade_medidasegurancainternacao", "1.3 .* medidas de seguran.a .*Total$") %>%
  renomeia_coluna("total_capacidade_outrasvagas", "1.3 .*outro.*Total$") %>%
  renomeia_coluna("total_capacidade_masculino", "1.3 .*capacidade do estabelecimento.*Masculino.*Total$") %>%
  renomeia_coluna("total_capacidade_feminino", "1.3 .*capacidade do estabelecimento.*feminino.*Total$")



# Bloco 4 - população geral -----------------------------------------------


# Bloco 5-A - perfil pessoal ----------------------------------------------


# Bloco 5-B - perfil criminal ---------------------------------------------


# Derrubar colunas não usadas ---------------------------------------------


# Corrigir classes --------------------------------------------------------


# Ajustes de compatibilidade ----------------------------------------------


# Salvar ------------------------------------------------------------------


