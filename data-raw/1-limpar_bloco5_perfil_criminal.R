## Rodrigo Dornelles - Sun May 23 19:17:54 2021
## penitenciaR
## Objetivo: Limpar base SISDEPEN
## Bloco 5 - Perfil criminal


# Pacotes -----------------------------------------------------------

library(magrittr)
library(penitenciaR)


# Lista de arquivos -------------------------------------------------------

lista_arquivos <- fs::dir_info(path = "data-raw/sisdepen/")$path


# Carregar a base ---------------------------------------------------------
path_base <- lista_arquivos[11] # seleciona junho 2020


base_sisdepen <- readxl::read_excel(path_base)

# Vou selecionar como chaves:
# `Nome do Estabelecimento`
# `UF`
# `Código IBGE`

sisdepen2020 <- base_sisdepen %>%
  dplyr::rename(estabelecimento_nm = `Nome do Estabelecimento`,
                uf = UF,
                cod_ibge = `Código IBGE`) %>%
  # retira colunas inuteis
  dplyr::select(-1:-2)

# Dados população ---------------------------------------------------------

# pegar as variáveis do bloco 4
base <- sisdepen2020 %>%
  dplyr::select(estabelecimento_nm, uf, cod_ibge,
                dplyr::matches("5\\.14"))

base %>%
names() %>%
  stringr::str_c(collapse = "\n") %>%
  cat()


# Renomear colunas --------------------------------------------------------

# tópico 5.14 - mais importante, com os grupos penais
# tópicos 5.12, 5.13


base %>%
  renomeia_coluna("existe_registro_incidenciapenal", "5.14 .* registro que permite a obten..o") %>%
  renomeia_coluna("metodologia_registro_incidenciapenal", "5.14 .*como . registrada") %>%
  renomeia_coluna("quantidade_com_informacao_incidencia", "5.* com informa..o sobre tipific.*Total$") %>%
  renomeia_coluna("quantidade_sem_informacao_incidencia", "5.* sem informa..o sobre tipific.*Total$") %>%
  ### código penal
  ## contra a pessoa
  renomeia_coluna("quantidade_incidencia_homicidio_simples", "homic.dio simples .*Total") %>%
  renomeia_coluna("quantidade_incidencia_homicidio_culposo", "homic.*io culposo.*.121.*Total") %>%
  renomeia_coluna("quantidade_incidencia_homicidio_qualificado", "homic.dio qualificado .*Total") %>%
  renomeia_coluna("quantidade_incidencia_homicidio_simples", "homic.dio simples .*Total") %>%
  renomeia_coluna("quantidade_incidencia_aborto", "aborto .*Total") %>%
  renomeia_coluna("quantidade_incidencia_lesaocorporal", "les.o corporal .*Total") %>%
  renomeia_coluna("quantidade_incidencia_violenciadomestica", "viol.ncia dom.stica .*Total") %>%
  renomeia_coluna("quantidade_incidencia_sequestrocarcereprivado", "seq..stro e c.rcere .*Total") %>%
  renomeia_coluna("quantidade_incidencia_outros_contrapessoa", "outros .* artigos 122 .*Total") %>%
  # contra o patrimônio
  renomeia_coluna("quantidade_incidencia_furto_simples", "furto simples .*Total") %>%
  renomeia_coluna("quantidade_incidencia_furto_qualificado", "furto qualificado .*Total") %>%
  renomeia_coluna("quantidade_incidencia_roubo_simples", "roubo simples .*Total") %>%
  renomeia_coluna("quantidade_incidencia_roubo_qualificado", "roubo qualificado .*Total") %>%
  renomeia_coluna("quantidade_incidencia_furto_qualificado", "furto qualificado .*Total") %>%
  renomeia_coluna("quantidade_incidencia_latrocinio", "latroc.nio .*Total") %>%
  renomeia_coluna("quantidade_incidencia_extorsaomedsequestro", "extors.o mediante seq.*Total") %>%
  renomeia_coluna("quantidade_incidencia_extorsao", "extors.o .*Total") %>%
  renomeia_coluna("quantidade_incidencia_apropindebita_previdenciaria", "apropria..o ind.bita previdenci.ria .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_apropindebita", "apropria..o ind.bita .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_estelionato", "estelionato .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_receptacao_qualificada", "recepta..o qualificada .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_receptacao", "recepta..o .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_outros_contrapatrimonio", "outros .* artigos 156 .*Total$") %>%
  # dignidade sexual
  renomeia_coluna("quantidade_incidencia_estupro_vulneravel", "estupro de vulner.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_estupro", "estupro .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_atentadoviolentopudor", "violento ao pudor .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_corrupcaomenores", "corrup..o de menores.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_traficopessoasexploracaosexual_internacional", "tr.fico internacional.*pessoa .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_traficopessoasexploracaosexual_interno", "tr.fico interno.*pessoa .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_outros_dignidadesexual", "outros .artigos 215.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_quadrilha", "quadrilha.*288.*Total$") %>%
  # outros crimes do CP
  renomeia_coluna("quantidade_incidencia_moedafalsa", "moeda falsa.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_falsificacaodocpublicos", "falsifica..o.*p.blicos.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_falisadeideologica", "falsidade ideol.gica.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_usodocfalso", "uso de documento falso.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_peculato", "peculato.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_concussao", "concuss.o e excesso de.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_corrupcao_passiva", "corrup..o passiva.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_corrpcao_ativa", "corrup..o ativa.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_contrabando", "contrabando ou descaminho.*Total$") %>%
  ### leis especiais
  # drogas
  renomeia_coluna("quantidade_incidencia_drogas_trafico_internacional", "tr.fico internacional de drogas .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_drogas_trafico", "tr.fico de drogas \\(art. 12.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_drogas_associacao", "associa..o .*o tr.fico.*Total$") %>%
  # armas
  renomeia_coluna("quantidade_incidencia_armas_usopermitido", "porte.*uso permitido.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_armas_disparo", "disparo de arma.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_armas_usorestrito", "porte.*uso restrito.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_armas_comercioilegal", "com.rcio ilegal.*arma.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_armas_traficointernacional", "tr.fico internacional de arma.*Total$") %>%
  # trânsito
  renomeia_coluna("quantidade_incidencia_transito_homicidioculposo", "homic.dio.*ve.culo.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_transito_outros", "outros.*303.*Total$") %>%
  # legislação específica
  renomeia_coluna("quantidade_incidencia_estatutocriancaadolescente", "estatuto da crian.a.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_contrameioambiente", "contra o meio ambiente.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_genocidio", "genoc.dio.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_tortura", "tortura .*Total$") %>%
  names() %>%
  stringr::str_c(collapse = "\n") %>%
  cat()

base_renomeada %>%
  View()


