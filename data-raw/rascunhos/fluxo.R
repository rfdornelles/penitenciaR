# Pacotes -----------------------------------------------------------------
library(magrittr)
library(penitenciaR)

# Carregar a base ---------------------------------------------------------
lista_arquivos <- fs::dir_info(path = "data-raw/sisdepen/")$path

path_base <- lista_arquivos[11] # seleciona junho 2020

gerar_base_total_sisdepen <- function (path_base, ...) {

# Colunas chave -----------------------------------------------------------

base <- penitenciaR::carregar_base_sisdepen(path_base, ...)

# Bloco 1 - estabelecimento -----------------------------------------------

base_bloco1 <- arruma_bloco_estabelecimento(base)


# Bloco 4 - população geral -----------------------------------------------

base_bloco4 <- arruma_bloco_populacao(base)

# Bloco 5-A - perfil pessoal ----------------------------------------------

base_bloco5_a <- arruma_bloco_perfilpessoal(base)


# Bloco 5-B - perfil criminal ---------------------------------------------

base_bloco5_b <- arruma_bloco_perfilcriminal(base)

# Juntar as bases ---------------------------------------------------------

sisdepen2020_selecionado <- base_bloco1 %>%
  dplyr::left_join(base_bloco4) %>%
  dplyr::left_join(base_bloco5_a) %>%
  dplyr::left_join(base_bloco5_b)

return(sisdepen2020_selecionado)

}

# Ajustes de compatibilidade ----------------------------------------------


# Salvar ------------------------------------------------------------------


