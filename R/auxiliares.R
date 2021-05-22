#' Renomeia colunas
#'
#' @description
#'
#' Aplica a função dplyr::rename() à uma base, mudando o nome da coluna indicada.
#' Será aplicada a função dplyr::matches() para identificar a coluna.
#'
#'Ao final, a coluna nova será
#' @param base Tibble da base
#' @param nome Nome que será recebido
#' @param coluna Expressão que identificará a coluna
#' @param fixa Por padrão, "cod_ibge". Identifica após qual coluna a nova será
#' recolocada.
#'
#' @return Tibble renomeada
#' @encoding UTF-8
#' @export
#'

renomeia_coluna <- function (base, nome, coluna, fixa = "cod_ibge") {
  base %>%
    dplyr::rename({{nome}} := dplyr::matches(match = coluna,
                                             ignore.case = TRUE)) %>%
    dplyr::relocate({{nome}}, .after = {{fixa}})
}
