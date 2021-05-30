#' Georeferência para CEP das unidades prisionais
#'
#' A base foi baixada usando a API do CEP Aberto, mais especificamente
#' a função [cepR::busca_cep()].
#'
#' @format :
#' \describe{
#'   \item{cep}{CEP da unidade prisional}
#'   \item{lat}{latitude}
#'   \item{long}{longitude}
#' }
#' @source \url{https://www.cepaberto.com/api_key}
"base_cep"
