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

#' Variáveis relativas ao estabelecimento prisional
#'
#' Seleção das principais variáveis relativas ao estabelecimento prisional
#' contidas no item 1 do formulário do SISDEPEN. Em geral, dizem respeito
#' às caractarísticas da unidade e seu perfil administrativo.
#'
#' A base possui os dados desde 2014 até junho de 2020.
#'
#' \describe{
#'   \item{id_origem_sisdepen}{ID de qual edição do SISDEPEN a base
#'   corresponde}
#'   \item{id_ano_sisdepen}{Ano em que as informações foram enviadas}
#'   \item{id_mes_sisdepen}{Qual o período se refere, em geral sendo junho,
#'   dezembro ou "único", nos anos em que era enviado apenas uma vez}
#'   \item{nome_estabelecimento}{Nome do estabelecimento prisional}
#'   \item{situacao_estabelecimento}{Se está ativo ou inativo}
#'   \item{nome_estabelecimento_outro}{Outros nomes pelo qual o estabelecimento
#'   é conhecido}
#'   \item{bairro_estabelecimento}{Bairro onde é localizado}
#'   \item{ambito_federativo}{A qual esfera pertence: Estadual ou Federal}
#'   \item{sigla_uf}{Sigla da UF onde está localizado o estabelecimento}
#'   \item{cod_ibge}{Código IBGE (7 dígitos) do município onde o estabelecimento
#'   está localizado}
#'   \item{terceiriza_administrativo}{Há terceirização de função administrativa?}
#'   \item{terceiriza_ass_juridica}{Há terceirização de assistência jurídica?}
#'   \item{terceiriza_ass_social}{Há terceirização de assistência social?}
#'   \item{terceiriza_laboral}{terapeuta ocupacional, instrutor, coordenador de trabalho que acompanham as atividades oferecidas na Unidadeassistência laboral (ex.:
#'   terapeuta ocupacional, instrutor, coordenador de trabalho que acompanham as
#'   atividades oferecidas na Unidade)?}
#'   \item{terceiriza_educacao}{Há terceirização de atividade educacional?}
#'   \item{terceiriza_saude}{Há terceirização de serviços de saúde?}
#'   \item{terceiriza_lavanderia}{Há terceirização de lavanderia?}
#'   \item{terceiriza_limpeza}{Há terceirização de limpeza?}
#'   \item{terceiriza_seguranca}{Há terceirização de segurança?}
#'   \item{terceiriza_alimentacao}{Há terceirização da alimentação?}
#'   \item{terceiriza_nenhum}{Não há nenhum serviço terceirizado. Teoricamente
#'   se essa resposta for positiva todas as modalidades de terceirização
#'   seriam negativas.}
#'   \item{capacidade_interditada_fem e capacidade_interditada_mas}{Quantidade
#'   de vagas femininas e masculinas (respectivamente) que foram interditadas
#'   ou consideradas não aptas. Esse quantitativo não deve ter sido considerado
#'   no total de vagas do estabelecimento.}
#'   \item{quantidade_celas_interditadas}{}
#'   \item{capacidade_outro_fem}{}
#'   \item{capacidade_outro_mas}{}
#'   \item{capacidade_aberto_fem}{}
#'   \item{capacidade_aberto_mas}{}
#'   \item{capacidade_mseg_fem}{}
#'   \item{capacidade_mseg_mas}{}
#'   \item{capacidade_rdd_fem}{}
#'   \item{capacidade_rdd_mas}{}
#'   \item{capacidade_semiaberto_fem}{}
#'   \item{capacidade_semiaberto_mas}{}
#'   \item{capacidade_rfechado_fem}{}
#'   \item{capacidade_rfechado_mas}{}
#'   \item{capacidade_provisorio_fem}{}
#'   \item{capacidade_provisorio_mas}{}
#'   \item{regimento_interno_exclusivo}{}
#'   \item{regimento_interno_possui}{}
#'   \item{tipo_gestao}{}
#'   \item{dest_original_original}{}
#'   \item{dest_original_tipo}{}
#'   \item{dest_original_genero}{}
#'   \item{data_inauguracao}{}
#'   \item{cep_estabelecimento}{}
#'   \item{nome_municipio}{}
#'   \item{endereco_estabelecimento}{}
#'   \item{lat}{}
#'   \item{long}{}
#'
#' }
#' @source SISDEPEN
#' @encoding UTF-8
#' @note Por terceirização se entende: "Contratação de entidade privada
#' para descentralização de serviços, mediante contrato oneroso
#' (remunerado), em que a empresa contratada oferece a mão-de-obra do
#' contrato pactuado entre as partes."
"base_estabelecimento"

#' Base estabelecimento....
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
#' @source SISDEPEN
"base_populacao"

#' Base estabelecimento....
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
#' @source SISDEPEN
"base_perfilcriminal"

#' Base estabelecimento....
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
#' @source SISDEPEN
"base_perfilpessoal"
