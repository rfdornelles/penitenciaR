
renomeia_bloco_estabelecimento <- function(base) {

  # selecionar colunas úteis para bloco estabelcimento
  dplyr::select(estabelecimento_nm:cod_ibge,
                dplyr::matches(match = "^[1]\\."))


  # renomear as colunas



  base_renomeada <- base %>%
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


  # retornar




}
