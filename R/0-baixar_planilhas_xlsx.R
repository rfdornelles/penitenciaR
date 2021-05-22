#' Baixar planilhas disponíveis no SISDEPEN
#'
#' Faz scrap da página do DEPEN ("https://www.gov.br/depen/pt-br/sisdepen") e baixa
#' a planilha {.xlsx} informada, salvando na pasta /data-raw/sisdepen
#'
#' @param url_planilha Endereço da planilha raspada do site do DEPEN
#' @param force Caso o arquivo já exista na sua pasta ele deve ser subscrito? Por padrão é FALSE.
#'
#' @return O endereço para o arquivo baixado
#' @encoding UTF-8
#' @export
#'

baixar_sisdepen_xlsx <- function(url_planilha, force = FALSE) {
  if (missing(url_planilha)) {
    rlang::abort("A url n\\u00e3o foi informada")
  }

  # checar se o arquivo existe
  # se existir e force = FALSE, pular

  arquivo <- stringr::str_extract(
    string = url_planilha,
    pattern = "(?i)infopen.*(\\.xlsx)$"
  )

  caminho <- paste0("data-raw/sisdepen/", arquivo)

  if (file.exists(caminho) & force == FALSE) {
    rlang::warn(paste("O arquivo", arquivo, "j\u00e1 existe. Para for\u00e7ar use force = TRUE"))
    return(caminho)
  }

  # garantir que a pasta existe
  dir.create("data-raw/sisdepen", showWarnings = FALSE)

  # baixar arquivo

  httr::GET(
    url_planilha,
    httr::progress(),
    httr::write_disk(path = caminho, overwrite = TRUE)
  )

  # checar se deu certo e informar o resultado
  # retorna o caminho ate o arquivo se deu certo
  if (file.exists(caminho)) {
    message(paste("O arquivo", arquivo, "foi baixado com sucesso!"))
    return(caminho)
  } else {
    rlang::warn(paste("Erro ao baixar o arquivo", arquivo))
  }
}
