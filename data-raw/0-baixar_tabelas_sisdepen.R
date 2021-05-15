## penitenciaR
## Rodrigo Dornelles - 15/05/2021
## Baixar as tabela disponibilizadas pelo Departamento Penitenciário Nacional


# Pacotes -----------------------------------------------------------------
library(magrittr)

# Raspar página -----------------------------------------------------------

# url do SisDEPEN
url_depen <- "https://www.gov.br/depen/pt-br/sisdepen/mais-informacoes/bases-de-dados"

# requisição inicial
r0 <- httr::GET(url_depen)

# lista com os links para arquivos disponíveis
links_arquivos_depen <- r0 %>%
  httr::content() %>%
  # pega o link para tudo que tenha final .xlsx
  xml2::xml_find_all("//a[contains(@href, '.xlsx')]") %>%
  xml2::xml_attr("href")


# função para baixar ------------------------------------------------------
baixar_sisdepen_xlsx <- function(url_planilha, force = FALSE) {

  if (missing(url_planilha)) {
    rlang::abort("A url não foi informada")
    }

  # checar se o arquivo existe
  # se existir e force = FALSE, pular

  arquivo <- stringr::str_extract(
    string = url_planilha,
    pattern = "(?i)infopen.*(\\.xlsx)$"
  )

  caminho <- paste0("data-raw/sisdepen/", arquivo)

  if (file.exists(caminho) & force == FALSE) {
    rlang::warn(paste("O arquivo", arquivo, "já existe. Para forçar use force = TRUE"))
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
  # retorna o caminho até o arquivo se deu certo
  if (file.exists(caminho)) {
    message(paste("O arquivo", arquivo, "foi baixado com sucesso!"))
    return(caminho)

  } else {
    rlang::warn(paste("Erro ao baixar o arquivo", arquivo))
  }
}


# Baixar todas as planilhas -----------------------------------------------

links_arquivos_depen %>%
  purrr::map(baixar_sisdepen_xlsx)
