
#' Gera bloco de colunas sobre o estabelecimento
#'
#' @param base
#'
#' @return Tibble
#' @export
#'
#' @encoding UTF-8
#'
#'
renomeia_bloco_estabelecimento <- function(base) {

  # selecionar colunas úteis para bloco estabelcimento
  base <- base %>%
  dplyr::select(id_origem_sisdepen, nome_estabelecimento, sigla_uf,
                dplyr::matches(match = "^[1]\\."))

  # renomear as colunas

  base_renomeada <- base %>%
    renomeia_coluna("data_inauguracao", "inaugura..o") %>%
    renomeia_coluna("dest_original_genero", "1.1.? Estabelecimento originalmente") %>%
    renomeia_coluna("dest_original_tipo", "1.2.* originalmente destinado.$") %>%
    renomeia_coluna("dest_original_original", "1.7. O estabelecimento") %>%
    renomeia_coluna("tipo_gestao", "1.4. Gestão do estabelecimento") %>%
    renomeia_coluna("regimento_interno_possui", "1.8. Possui regimento") %>%
   # renomeia_coluna("regimento_interno_exclusivo", "1.9. O regimento interno") %>%
    renomeia_coluna("capacidade_provisorio_mas", "1.3. .* provisórios \\| Masculino") %>%
    renomeia_coluna("capacidade_provisorio_fem", "1.3. .* provisórios \\| Feminino") %>%
    renomeia_coluna("capacidade_rfechado_mas", "1.3. .* fechado \\| Masculino") %>%
    renomeia_coluna("capacidade_rfechado_fem", "1.3. .* fechado \\| Feminino") %>%
    renomeia_coluna("capacidade_semiaberto_mas", "1.3. .* semiaberto \\| Masculino") %>%
    renomeia_coluna("capacidade_semiaberto_fem", "1.3. .* semiaberto \\| Feminino") %>%
    renomeia_coluna("capacidade_rdd_mas", "1.3. .* disciplinar .* \\| Masculino") %>%
    renomeia_coluna("capacidade_rdd_fem", "1.3. .* disciplinar .* \\| Feminino") %>%
    renomeia_coluna("capacidade_mseg_mas", "1.3. .* medidas de seg.* \\| Masculino") %>%
    renomeia_coluna("capacidade_mseg_fem", "1.3. .* medidas de seg.* \\| Feminino") %>%
    renomeia_coluna("capacidade_aberto_mas", "1.3. .* Regime aberto.* \\| Masculino") %>%
    renomeia_coluna("capacidade_aberto_fem", "1.3. .* Regime aberto.* \\| Feminino") %>%
   # renomeia_coluna("tipo_capacidade_outros", "1.3. Capacidade .* (Qual\\(is\\)\\?)$") %>%
    renomeia_coluna("capacidade_outro_mas", "1.3. Capacidade .* Outro.* \\| Masculino") %>%
    renomeia_coluna("capacidade_outro_fem", "1.3. Capacidade .* Outro.* \\| Feminino") %>%
    renomeia_coluna("quantidade_celas_interdidatas", "(1.3. .* \\| Celas não aptas)|(1.3.* Celas não aptas)") %>%
    renomeia_coluna("capacidade_interditada_mas", "(1.3. .* desativadas .* Masculino)|(1.3.* desativadas.*Masculino)") %>%
    renomeia_coluna("capacidade_interditada_fem", "(1.3. .* desativadas .* Masculino)|(1.3.* desativadas.*Feminino)") %>%
    # ver com cuidado essa: terceiriza_nenhum deveria ser não para todos os demais
    renomeia_coluna("terceiriza_nenhum", "(1.5. .* Nenhum)|(1.5.*nenhum)") %>%
    renomeia_coluna("terceiriza_alimentacao", "(1.5. .* Alimentação)|(1.5.*alimenta.*)") %>%
    renomeia_coluna("terceiriza_limpeza", "(1.5. .* Limpeza)|(1.5.*limpeza)") %>%
    renomeia_coluna("terceiriza_lavanderia", "(1.5 .* Lavanderia)|(1.5.*lavanderia)") %>%
    renomeia_coluna("terceiriza_saude", "(1.5. .* Sa.de)|(1.5.*sa.de)")  %>%
    renomeia_coluna("terceiriza_educacao", "1.5. .* educacional")  %>%
    renomeia_coluna("terceiriza_laboral", "1.5. .* laboral")  %>%
    renomeia_coluna("terceiriza_ass_social", "(1.5. .* Assist.ncia social)|(1.5.*assist.ncia social)")  %>%
    renomeia_coluna("terceiriza_ass_juridica", "(1.5.* Assist.ncia jur.dica)|(1.5.*assist.ncia jur.dica)") %>%
    renomeia_coluna("terceiriza_administrativo", "1.5. .* administrativos")  #%>%
    #renomeia_coluna("terceiriza_quais_outros", "1.5.*Outro.?")


  # retornar
return(base_renomeada)



}
