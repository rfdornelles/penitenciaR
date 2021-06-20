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
#' @param fixa Por padrão, "sigla_uf". Identifica após qual coluna a nova será
#' recolocada.
#'
#' @return Tibble renomeada
#' @encoding UTF-8
#' @export
#'

renomeia_coluna <- function (base, nome, coluna, fixa = "sigla_uf") {

  base_resposta <- base %>%
    dplyr::rename({{nome}} := dplyr::matches(match = coluna,
                                             ignore.case = TRUE))

  if(fixa != FALSE) {

    base_resposta <- base_resposta %>%
       dplyr::relocate({{nome}}, .after = {{fixa}})
  }

  return(base_resposta)

}


# checa_consistência ------------------------------------------------------


#' Chaca consistência
#'
#' @description
#'
#' Testa a consistência das colunas: vai pegar as que não tem total, somar
#' e comparar com a que tem.
#'
#' @param base Qual a base
#' @param nome_coluna Nome da coluna "
#'
#' @return
#' @export
#'
#'

checa_consistencia_numero <- function(base, nome_coluna) {

  base %>%
    dplyr::select(
      dplyr::contains(nome_coluna)) %>%
    dplyr::mutate(
      sem_total = rowSums(
        dplyr::across(
          dplyr::matches(match = "[^(Total)]")
        ), na.rm = TRUE),
      total = rowSums(dplyr::across(dplyr::contains("Total")), na.rm = TRUE),
      consistente = sem_total == total
    )
}
