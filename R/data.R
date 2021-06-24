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
#' @description
#' Seleção das principais variáveis relativas ao estabelecimento prisional
#' contidas no item 1 do formulário do SISDEPEN. Em geral, dizem respeito
#' às caractarísticas da unidade e seu perfil administrativo.
#'
#' @format Data frame:
#' \describe{
#'  \item{id_origem_sisdepen}{ID de qual edição do SISDEPEN a base
#'   corresponde}
#'   \item{id_ano_sisdepen}{Ano em que as informações foram enviadas}
#'   \item{id_mes_sisdepen}{Qual o período se refere, em geral sendo junho,
#'   dezembro ou "único", nos anos em que era enviado apenas uma vez}
#'   \item{nome_estabelecimento}{Nome do estabelecimento prisional}
#'   \item{situacao_estabelecimento}{Se está ativo ou inativo}
#'   \item{nome_estabelecimento_outro}{Outros nomes pelo qual o estabelecimento
#'   é conhecido}
#'   \item{ambito_federativo}{A qual esfera pertence: Estadual ou Federal}
#'   \item{terceiriza_administrativo, terceiriza_ass_juridica, terceiriza_ass_social,
#'   terceiriza_laboral, terceiriza_educacao, terceiriza_saude, terceiriza_lavanderia,
#'   terceiriza_limpeza, terceiriza_seguranca, terceiriza_alimentacao, terceiriza_nenhum}
#'   {Se há terceirização de alguma das modalidades de:
#'
#'   1. Serviços administrativos,
#'   2. Assistência jurídica,
#'   3. Assistência social,
#'   4. Assistência laboral (terapeuta ocupacional, instrutor,
#'   coordenador de trabalho que acompanham as atividades oferecidas na
#'   Unidade),
#'   5. Assistência educacional,
#'   6. Serviços de saúde,
#'   7. Lavanderia,
#'   8. Serviço de limpeza,
#'   9. Segurança,
#'   10. Alimentação.
#'
#'   Há também a variável "nenhum", que não há nenhum serviço terceirizado.
#'   Teoricamente se essa resposta for positiva todas as modalidades de terceirização
#'   seriam negativas.
#'
#'   *Nota* Por terceirização se entende: "Contratação de entidade privada
#' para descentralização de serviços, mediante contrato oneroso
#' (remunerado), em que a empresa contratada oferece a mão-de-obra do
#' contrato pactuado entre as partes.
#' }
#'   \item{quantidade_celas_interditadas, apacidade_interditada_fem e capacidade_interditada_mas}{Quantidade de celas e quantidade de vagas femininas e masculinas (respectivamente)
#' que foram interditadas ou consideradas não aptas.
#' Esse quantitativo teoricamente não foi sido considerado no total de vagas
#' do estabelecimento.}
#'   \item{capacidade_provisorio_mas, capacidade_provisorio_fem, capacidade_rfechado_mas,
#'   capacidade_rfechado_fem, capacidade_semiaberto_mas, capacidade_semiaberto_fem,
#'   capacidade_rdd_mas, capacidade_rdd_fem, capacidade_mseg_mas, capacidade_mseg_fem,
#'   capacidade_aberto_mas, capacidade_aberto_fem, capacidade_outro_mas,
#'   capacidade_outro_fem}{Informação sobre a capacidade (ou seja, número de pessoas) que para cada
#' regime e cada sexo, conforme tabela abaixo. O número *não* se confunde com a quantidade
#' de pessoas efetivamente existente. Será preenchido de acordo com a realidade
#' na data do envio do formulário ao DEPEN e não deve considerar as vagas de celas
#' interditadas, desativadas ou não aptas.
#'
#' Veja que não há uma definição clara de qual critério deve ser utilizado pela
#' unidade para definir sua capacidade, de modo que o dado deve ser visto com muito
#' cuidado já que é bastante arbitrário. Há estados que consideram a metragem
#' da cela, a quantidade de "camas", etc.
#'
#' _provisório_ - presos provisórios, sem condenação definitiva
#'
#' _rfechado_ - presos já condenados em regime fechado
#'
#' _semiaberto_ - presos já condenados em regime semiaberto
#'
#' _aberto_ - presos já condenados em regime aberto
#'
#' _rdd_ - regime disciplinar diferenciado
#'
#' _mseg_ - medida de segurança de internação/presos inimputáveis
#'
#' _outro_ - outros tipos de vaga}
#' \item{regimento_interno_possui e regimento_interno_exclusivo}{Se a unidade
#'   possui regimento disciplinar interno (podendo ser sim ou não) e se o
#'   regimento da unidade é exclusivo daquela unidade ou comum a todo o sistema.}
#' \item{tipo_gestao}{O modelo de gestão a que o estabelecimento prisional está
#'   submetido. Pode ser:
#'   - *Pública*: Ente público responsável pela gestão integral do estabelecimento,
#'   mesmo que determinados serviços sejam terceirizados.
#'   - *Parceria Público-Privada (PPP)*: Entende-se, a realização de contrato e
#'   outorga para entidade privada realizar construção e gestão integral do
#'   estabelecimento, cabendo ao ente público a fiscalização da atividade do
#'   parceiro privado.
#'   - *Co-gestão*: Modelo que envolve a Administração Pública e a iniciativa
#'    privada, em que o administrador privado é responsável pela gestão de
#'    determinados serviços da unidade, como segurança interna, alimentação,
#'    estimenta, higiene, lazer, saúde, assistência social, psicológica, etc.,
#'    cabendo ao Estado e ao ente privado o gerenciamento e administração
#'    conjunta do estabelecimento.
#'   - *Organização sem fins lucrativos*: A gestão do estabelecimento é
#'   compartilhada entre o Estado e entidades ou organizações sem fins
#'   lucrativos. Em geral, vai dizer respeito a modelos como da APAC.
#'
#'}
#' \item{dest_original_original e dest_original_genero}{Indicam respectivamente:
#'   1. A unidade foi originalmente concebida como estabelecimento penal ou foi
#'   adaptada para esse fim; e
#'   2. A que gênero originalmente se destinava (masculino, feminino, misto)
#'
#'}
#' \item{dest_original_tipo}{Tipo de estabelecimento por sua destinação prevista
#' no momento de sua construção, independente de criação posterior de alas e
#' anexos destinados a outros regimes, ou de alocação circunstancial de pessoas
#' privadas de liberdade que não se enquadravam na destinação original do
#' estabelecimento.
#'
#' Por exemplo: para os estabelecimentos que foram concebidos como Cadeias
#' Públicas mas possuem sentenciados (em ala separada ou não), deve ser
#' assinalado "Estabelecimento destinado ao recolhimento de presos provisórios";
#' para as Penitenciárias que foram adaptadas, com a construção de alas/anexos
#' de detenção provisória ou de progressão de regime, ou que passaram a acomodar
#' presos provisórios ou já promovidos ao regime semiaberto, deve ser assinalada
#' a opção "Estabelecimento destinado ao cumprimento de pena em regime fechado";
#' por outro lado, para estabelecimentos que foram concebidos para diversos tipos
#' de regime, como Centros de Ressocialização, deve ser assinalada a opção
#' "Estabelecimento destinado a diversos tipos de regime".
#'
#'As opções podem ser:
#'- Presos provisórios
#'- Regime fechado
#'- Regime semiaberto
#'- Regime aberto: incluindo limitação de final de semana
#'- Medida de segurança: internação ou tratamento ambulatorial
#'- Regimes diversos
#'- Triagem: unidades voltadas a exame criminológico
#'- Patronato: assistência a albergado e egressos
#'- APAC: unidade que segue a metodologia da FBAC
#'- RDD: regime discplinar diferenciado
#'- Delegacia de polícia: unidade que é/era carceragem de delegacia
#'
#'}
#' \item{data_inauguracao}{Data de inauguração do estabelecimento}
#' \item{endereco_estabelecimento, cep_estabelecimento, bairro_estabelecimento,
#'nome_municipio, sigla_uf}{Variáveis que identificam endereço, CEP, bairro e
#' UF de onde está o estabelecimento.}
#' \item{cod_ibge}{Código IBGE (7 dígitos) do município onde o estabelecimento
#' está localizado}
#' \item{lat e long}{Coordenadas geográficas obtidas para o CEP da unidade (
#' e não da unidade em si). Serve para ter noção aproximada de sua localização,
#' com baixa precisão.}
#'}
#' @source https://www.gov.br/depen/pt-br/sisdepen/mais-informacoes/bases-de-dados
#' @encoding UTF-8
"base_estabelecimento"

#' Variáveis relativas à população prisional
#'
#' @description
#' Seleção das principais variáveis relativas à população prisional contidas no
#' item 4 do formulário do SISDEPEN. Em geral, dizem respeito às caractarísticas
#' população custodiada na unidade.
#'
#' @format :
#' \describe{
#' \item{id_origem_sisdepen}{ID de qual edição do SISDEPEN a base
#'   corresponde}
#' \item{id_ano_sisdepen}{Ano em que as informações foram enviadas}
#' \item{id_mes_sisdepen}{Qual o período se refere, em geral sendo junho,
#'   dezembro ou "único", nos anos em que era enviado apenas uma vez}
#' \item{nome_estabelecimento, sigla_uf e cod_ibge}{Nome do estabelecimento prisional,
#' UF de onde está o estabelecimento e o código IBGE (7 dígitos) do município onde
#' está localizado}
#' \item{quantidade_(situação)_(regime)_(origem)_(gênero)}{Variáveis indicando a quantidade
#' de pessoas custodiadas no momento do envio das respostas ao SISDEPEN. Não se confunde
#' com a quantidade de "vagas", já que pode ser menor ou - infelizmente, na maior parte
#' dos casos - muito maior do que o esperado.
#'
#' Para fins do SISDEPEN a pessoa deixa de ser considerada provisória quando há sentença,
#' independente de ainda cabe recurso (ou seja, mesmo que não haja o trânsito em julgado).
#' Caso a pessoa esteja condenada mas também possua prisão provisória por outro processo ela
#' será considerada, para fins do SISDEPEN, condenada.
#'
#' Essas variáveis estão em uma estrutura divididos pela situação processual, regime,
#' origem da prisão (qual Justiça) e gênero:
#'
#' *Situação processual*
#' Pode ser:
#' 1. _presoprovisorio_ Indicando serem provisórios (sem sentença condenatória)
#' 2. _sentenca_ Indicando serem já sentenciados
#' 3. _medseg_ Medida de segurança
#'
#' *Regime de pena*
#' 1. Se _sentenca_ pode variar entre *ra* (regime aberto), *rsa* (regime semiaberto) ou
#' *rf* (regime fechado)
#' 2. Se _medseg_ pode ser *ambulatorial* (tratamento ambulatorial) ou *internacao*
#'
#' *Justiça de origem*
#' 1. _jusestadual_ : justiça estadual
#' 2. _jusfederal_ : justiça federal
#' 3. _outrajus_ : outras justiças como Trabalhista, Eleitoral ou cível.
#'
#' }
#' }
#' @source https://www.gov.br/depen/pt-br/sisdepen/mais-informacoes/bases-de-dados
#' @encoding UTF-8
"base_populacao"

#' Variáveis relativas ao perfil criminal
#'
#' @description
#' Seleção das principais variáveis relativas à população prisional contidas na
#' segunda parte do item 5 do formulário do SISDEPEN. Em geral, dizem respeito
#' ao crime pelo qual a pessoa está presa (seja em caráter provisório ou não).
#'
#' A incidência penal é considerada aquela classificada no auto de prisão em flagrante,
#' instauração de inquérito ou denúncia caso seja um preso provisório. No caso de
#' sentenciado, considera-se a capitulação dada na sentença ou acórdão.
#'
#' _*ATENÇÃO*_: O SISDEPEN determina que as incidências serão registradas de *forma cumulativa*: se uma pessoa foi condenada
#' por homicídio simples e por roubo simples, deve ser lançado um registro em
#' homicídio simples e outro registro em roubo simples, da mesma forma, se a pessoa
#' foi condenada por roubo simples e aguarda julgamento por tráfico de drogas, deve
#' ser lançado registro nos dois tipos penais.
#'
#'
#' @format :
#' \describe{
#' \item{id_origem_sisdepen}{ID de qual edição do SISDEPEN a base
#'   corresponde}
#' \item{id_ano_sisdepen}{Ano em que as informações foram enviadas}
#' \item{id_mes_sisdepen}{Qual o período se refere, em geral sendo junho,
#'   dezembro ou "único", nos anos em que era enviado apenas uma vez}
#' \item{nome_estabelecimento, sigla_uf e cod_ibge}{Nome do estabelecimento prisional,
#' UF de onde está o estabelecimento e o código IBGE (7 dígitos) do município onde
#' está localizado}
#' \item{existe_registro_incidenciapenal}{Informa se o estabelecimento tem alguma
#' forma de controlar o registro sobre a incidência penal}
#' \item{metodologia_registro_incidenciapenal}{Qual a metodologia utilizada para o
#' registro da incidência penal. Permite saber o grau de atualização dos dados e,
#' com isso, mensurar o quanto é possível confiar na informação.}
#' \item{quantidade_com_informacao_incidencia e quantidade_sem_informacao_incidencia}{Quantas
#' pessoas estão ou não com essa informação. Junto à variável de metodologia permite aferir
#' o quão atualizados estão os dados}
#' \item{quantidade_incidencia_(crime)(modalidade)}{Variáveis indicando a quantidade
#' de incidências penais para cada um dos crimes. Como dito acima, uma pessoa pode possuir
#' mais de uma incidência penal.
#'
#' Foram divididos de acordo com a categoria do crime, podendo ser divididos em modalidade
#' quando for o caso.
#'
#' _Crimes contra a pessoa_
#' - *homicídio*: podendo ser, _culposo, _simples ou _qualificado
#' - *aborto*
#' - *lesaocorporal*
#' - *violenciadomestica*
#' - *sequestrocarcereprivado* previsto no art. 148 do Código Penal
#' - *outros_contrapessoa* outros crimes contra a pessoa não listados acima
#'
#' _Crimes contra o patrimônio_
#' - *furto* : podendo ser _simples ou _qualificado
#' - *roubo* : podendo ser _simples ou _qualificado
#' - *latrocinio* : também conhecido como roubo seguido de morte
#' - *extorsao* : art. 158 do CP
#' _ *extorsaomedsequestro* : extorsão mediante sequestro (art. 159 do CP)
#' - *apropindebita* : apropriação indébita (art. 168)
#' - *apropindebita_previdenciaria* : apropriação indébita previdenciária (art. 168-A)
#' - *estelionato*
#' - *receptacao* receptação, podendo ser também _qualificada
#' - *outros_contrapatrimonio*
#'
#' _Contra a dignidade sexual_
#' - *estupro*
#' _ *estupro_vulneravel*
#' - *atentadoviolentopudor*
#' - *corrupcaomenores*
#' - *traficopessoasexploracaosexua* podendo ser _interno ou _internacional
#' - *outros_dignidadesexual*
#'
#' _Contra a fé pública e contra administração pública_
#'
#' _Drogas_
#'
#' _Armas_
#'
#' _Outros crimes de legislação específica_
#'
#'
#' }
#' }
#' @source https://www.gov.br/depen/pt-br/sisdepen/mais-informacoes/bases-de-dados
#' @encoding UTF-8
"base_perfilcriminal"

#' Variáveis relativas à população prisional
#'
#' @description
#' Seleção das principais variáveis relativas à população prisional contidas no
#' item 4 do formulário do SISDEPEN. Em geral, dizem respeito às caractarísticas
#' população custodiada na unidade.
#'
#' @format :
#' \describe{
#' \item{id_origem_sisdepen}{ID de qual edição do SISDEPEN a base
#'   corresponde}
#' \item{id_ano_sisdepen}{Ano em que as informações foram enviadas}
#' \item{id_mes_sisdepen}{Qual o período se refere, em geral sendo junho,
#'   dezembro ou "único", nos anos em que era enviado apenas uma vez}
#' \item{nome_estabelecimento, sigla_uf e cod_ibge}{Nome do estabelecimento prisional,
#' UF de onde está o estabelecimento e o código IBGE (7 dígitos) do município onde
#' está localizado}
#' \item{quantidade_(situação)_(regime)_(origem)_(gênero)}{Variáveis indicando a quantidade
#' de pessoas custodiadas no momento do envio das respostas ao SISDEPEN. Não se confunde
#' com a quantidade de "vagas", já que pode ser menor ou - infelizmente, na maior parte
#' dos casos - muito maior do que o esperado.
#'
#' Para fins do SISDEPEN a pessoa deixa de ser considerada provisória quando há sentença,
#' independente de ainda cabe recurso (ou seja, mesmo que não haja o trânsito em julgado).
#' Caso a pessoa esteja condenada mas também possua prisão provisória por outro processo ela
#' será considerada, para fins do SISDEPEN, condenada.
#'
#' Essas variáveis estão em uma estrutura divididos pela situação processual, regime,
#' origem da prisão (qual Justiça) e gênero:
#'

#' }
#' }
#' @source https://www.gov.br/depen/pt-br/sisdepen/mais-informacoes/bases-de-dados
#' @encoding UTF-8
"base_perfilpessoal"
