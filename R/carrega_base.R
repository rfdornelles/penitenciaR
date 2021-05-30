
#' Carrega base do SISDEPEN
#'
#' @description
#' Carrega a base indicada de modo que todas as colunas sejam strings e
#' que a coluna de contendo o nome do estabelecimento seja renomeada para
#' `nome_estabelcimento` e UF seja renomeada para `sigla_uf`.
#'
#'  Além disso, será gerado um identificador para a base na coluna
#'  `id_origem_sisdepen` de acordo com o ano e período a que ela se referir.
#'
#' @param path Caminho para a base. Deve conter o ano e mês de origem.
#' Deve ser `.xlsx`
#'
#' @param padrao "guess" por default. Indica o tipo de coluna padrão. Se
#' tiver problema de compatibilidade pode ser uma boa colocar "text".
#'
#' @return Tibble
#' @export
#' @encoding UTF-8

carregar_base_sisdepen <- function(path, padrao = "guess") {

  # identificador da base
  # verificar o ano
  ano_base <- stringr::str_extract(path, "[0-9]+")

  # verificar a "rodada", se é junho/dezembro/único
  rodada <- dplyr::case_when(
    stringr::str_detect(path, "(?i)jun") ~ "junho",
    stringr::str_detect(path, "(?i)dez") ~ "dezembro",
    TRUE ~ "unico"
  )

  # gerar identificador
  identificador <- paste0(ano_base, "-", rodada)

  # importar a base
  base_xlsx <- readxl::read_excel(path = path,
                                  # ler como <padrao> definido
                                  # posso colcoar como "text" caso tenha
                                  # problema de compatibilidade
                                  col_types = padrao)

  # garantir que as colunas chave sejam iguais em todas as bases
  base_xlsx %>%
    dplyr::rename(
      nome_estabelecimento =
        tidyselect::matches("nome.*(unidade|estabelecimento)",
                             ignore.case = TRUE),
      sigla_uf =
        tidyselect::matches("UF",
                             ignore.case = TRUE)
    ) %>%
    # identificar a origem
    dplyr::mutate(id_origem_sisdepen = identificador) %>%
    # retira colunas inuteis
    dplyr::select(-1:-2)

}
