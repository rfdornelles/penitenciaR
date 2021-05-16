## penitenciaR
## Rodrigo Dornelles - 15/05/2021
## Baixar as tabela disponibilizadas pelo Departamento Penitenci\u00e1rio Nacional


# Pacotes -----------------------------------------------------------------
library(magrittr)

# Raspar pagina-----------------------------------------------------------

# url do SisDEPEN
url_depen <- "https://www.gov.br/depen/pt-br/sisdepen/mais-informacoes/bases-de-dados"

# requisicao inicial
r0 <- httr::GET(url_depen)

# lista com os links para arquivos disponiveis
links_arquivos_depen <- r0 %>%
  httr::content() %>%
  # pega o link para tudo que tenha final .xlsx
  xml2::xml_find_all("//a[contains(@href, '.xlsx')]") %>%
  xml2::xml_attr("href")

# Baixar todas as planilhas -----------------------------------------------

links_arquivos_depen %>%
  purrr::map(penitenciaR::baixar_sisdepen_xlsx)
