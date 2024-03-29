% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\encoding{UTF-8}
\name{base_estabelecimento}
\alias{base_estabelecimento}
\title{Variáveis relativas ao estabelecimento prisional}
\format{
Data frame:
\describe{
\item{id_origem_sisdepen}{ID de qual edição do SISDEPEN a base
corresponde}
\item{id_ano_sisdepen}{Ano em que as informações foram enviadas}
\item{id_mes_sisdepen}{Qual o período se refere, em geral sendo junho,
dezembro ou "único", nos anos em que era enviado apenas uma vez}
\item{nome_estabelecimento}{Nome do estabelecimento prisional}
\item{situacao_estabelecimento}{Se está ativo ou inativo}
\item{nome_estabelecimento_outro}{Outros nomes pelo qual o estabelecimento
é conhecido}
\item{ambito_federativo}{A qual esfera pertence: Estadual ou Federal}
\item{terceiriza_administrativo, terceiriza_ass_juridica, terceiriza_ass_social,
terceiriza_laboral, terceiriza_educacao, terceiriza_saude, terceiriza_lavanderia,
terceiriza_limpeza, terceiriza_seguranca, terceiriza_alimentacao, terceiriza_nenhum}{
Se há terceirização de alguma das modalidades de:
\enumerate{
\item Serviços administrativos,
\item Assistência jurídica,
\item Assistência social,
\item Assistência laboral (terapeuta ocupacional, instrutor,
coordenador de trabalho que acompanham as atividades oferecidas na
Unidade),
\item Assistência educacional,
\item Serviços de saúde,
\item Lavanderia,
\item Serviço de limpeza,
\item Segurança,
\item Alimentação.
}

Há também a variável "nenhum", que não há nenhum serviço terceirizado.
Teoricamente se essa resposta for positiva todas as modalidades de terceirização
seriam negativas.

\emph{Nota} Por terceirização se entende: "Contratação de entidade privada
para descentralização de serviços, mediante contrato oneroso
(remunerado), em que a empresa contratada oferece a mão-de-obra do
contrato pactuado entre as partes.
}
\item{quantidade_celas_interditadas, apacidade_interditada_fem e capacidade_interditada_mas}{Quantidade de celas e quantidade de vagas femininas e masculinas (respectivamente)
que foram interditadas ou consideradas não aptas.
Esse quantitativo teoricamente não foi sido considerado no total de vagas
do estabelecimento.}
\item{capacidade_provisorio_mas, capacidade_provisorio_fem, capacidade_rfechado_mas,
capacidade_rfechado_fem, capacidade_semiaberto_mas, capacidade_semiaberto_fem,
capacidade_rdd_mas, capacidade_rdd_fem, capacidade_mseg_mas, capacidade_mseg_fem,
capacidade_aberto_mas, capacidade_aberto_fem, capacidade_outro_mas,
capacidade_outro_fem}{Informação sobre a capacidade (ou seja, número de pessoas) que para cada
regime e cada sexo, conforme tabela abaixo. O número \emph{não} se confunde com a quantidade
de pessoas efetivamente existente. Será preenchido de acordo com a realidade
na data do envio do formulário ao DEPEN e não deve considerar as vagas de celas
interditadas, desativadas ou não aptas.

Veja que não há uma definição clara de qual critério deve ser utilizado pela
unidade para definir sua capacidade, de modo que o dado deve ser visto com muito
cuidado já que é bastante arbitrário. Há estados que consideram a metragem
da cela, a quantidade de "camas", etc.

\emph{provisório} - presos provisórios, sem condenação definitiva

\emph{rfechado} - presos já condenados em regime fechado

\emph{semiaberto} - presos já condenados em regime semiaberto

\emph{aberto} - presos já condenados em regime aberto

\emph{rdd} - regime disciplinar diferenciado

\emph{mseg} - medida de segurança de internação/presos inimputáveis

\emph{outro} - outros tipos de vaga}
\item{regimento_interno_possui e regimento_interno_exclusivo}{Se a unidade
possui regimento disciplinar interno (podendo ser sim ou não) e se o
regimento da unidade é exclusivo daquela unidade ou comum a todo o sistema.}
\item{tipo_gestao}{O modelo de gestão a que o estabelecimento prisional está
submetido. Pode ser:
\itemize{
\item \emph{Pública}: Ente público responsável pela gestão integral do estabelecimento,
mesmo que determinados serviços sejam terceirizados.
\item \emph{Parceria Público-Privada (PPP)}: Entende-se, a realização de contrato e
outorga para entidade privada realizar construção e gestão integral do
estabelecimento, cabendo ao ente público a fiscalização da atividade do
parceiro privado.
\item \emph{Co-gestão}: Modelo que envolve a Administração Pública e a iniciativa
privada, em que o administrador privado é responsável pela gestão de
determinados serviços da unidade, como segurança interna, alimentação,
estimenta, higiene, lazer, saúde, assistência social, psicológica, etc.,
cabendo ao Estado e ao ente privado o gerenciamento e administração
conjunta do estabelecimento.
\item \emph{Organização sem fins lucrativos}: A gestão do estabelecimento é
compartilhada entre o Estado e entidades ou organizações sem fins
lucrativos. Em geral, vai dizer respeito a modelos como da APAC.
}

}
\item{dest_original_original e dest_original_genero}{Indicam respectivamente:
\enumerate{
\item A unidade foi originalmente concebida como estabelecimento penal ou foi
adaptada para esse fim; e
\item A que gênero originalmente se destinava (masculino, feminino, misto)
}

}
\item{dest_original_tipo}{Tipo de estabelecimento por sua destinação prevista
no momento de sua construção, independente de criação posterior de alas e
anexos destinados a outros regimes, ou de alocação circunstancial de pessoas
privadas de liberdade que não se enquadravam na destinação original do
estabelecimento.

Por exemplo: para os estabelecimentos que foram concebidos como Cadeias
Públicas mas possuem sentenciados (em ala separada ou não), deve ser
assinalado "Estabelecimento destinado ao recolhimento de presos provisórios";
para as Penitenciárias que foram adaptadas, com a construção de alas/anexos
de detenção provisória ou de progressão de regime, ou que passaram a acomodar
presos provisórios ou já promovidos ao regime semiaberto, deve ser assinalada
a opção "Estabelecimento destinado ao cumprimento de pena em regime fechado";
por outro lado, para estabelecimentos que foram concebidos para diversos tipos
de regime, como Centros de Ressocialização, deve ser assinalada a opção
"Estabelecimento destinado a diversos tipos de regime".

As opções podem ser:
\itemize{
\item Presos provisórios
\item Regime fechado
\item Regime semiaberto
\item Regime aberto: incluindo limitação de final de semana
\item Medida de segurança: internação ou tratamento ambulatorial
\item Regimes diversos
\item Triagem: unidades voltadas a exame criminológico
\item Patronato: assistência a albergado e egressos
\item APAC: unidade que segue a metodologia da FBAC
\item RDD: regime discplinar diferenciado
\item Delegacia de polícia: unidade que é/era carceragem de delegacia
}

}
\item{data_inauguracao}{Data de inauguração do estabelecimento}
\item{endereco_estabelecimento, cep_estabelecimento, bairro_estabelecimento,
nome_municipio, sigla_uf}{Variáveis que identificam endereço, CEP, bairro e
UF de onde está o estabelecimento.}
\item{cod_ibge}{Código IBGE (7 dígitos) do município onde o estabelecimento
está localizado}
\item{lat e long}{Coordenadas geográficas obtidas para o CEP da unidade (
e não da unidade em si). Serve para ter noção aproximada de sua localização,
com baixa precisão.}
}
}
\source{
https://www.gov.br/depen/pt-br/sisdepen/mais-informacoes/bases-de-dados
}
\usage{
base_estabelecimento
}
\description{
Seleção das principais variáveis relativas ao estabelecimento prisional
contidas no item 1 do formulário do SISDEPEN. Em geral, dizem respeito
às caractarísticas da unidade e seu perfil administrativo.
}
\keyword{datasets}
