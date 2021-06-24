
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Introdução

## O que é esse pacote

No contexto do curso de “Faxina de Dados” da Curso-R o trabalho final
consiste em realizar um projeto de faxina de dados em que possamos
aplicar os conceitos trabalhados no curso.

Escolhi, então, um tema de meu interesse (o sistema penitenciário) e no
presente projeto tento uma primeira versão de pacote que permita acessar
os dados do SISDEPEN de forma simples, facilitando análises futuras.

Esses dados são coletados pelo Departamento Penitenciário Nacional
(DEPEN) de todas as unidades prisionais do país desde 2014. Primeiro uma
vez ao ano e depois em duas rodadas semestrais. As informações são em um
formato de survey preenchidos pelas próprias unidades.

Também, como forma de tentar contribuir com a comunidade, após os
feedbacks do projeto, espero poder submeter os dados ao excelente
projeto Base dos Dados. Por isso, o projeto foi realizado tendo em mente
as orientações da equipe do Base dos Dados:
<https://basedosdados.github.io/mais/colab_data/>

## Pequena observação: aspecto humano

Há uma frase, costumeiramente atribuída a Ghandi ou a Nelso Mandela, que
diz que “É possível julgar o grau de civilização de uma sociedade
visitando suas prisões”. Independente da autoria, a provocação é bem
válida.

O sistema penitenciário é uma realidade desconhecida. Temos centenas de
milhares de pessoas, presas, invisibilizadas porém concretas. Por razões
raciais, sócio-econômicas e culturais, a situação é convenientemente
escondida de nós e a sociedade, em geral, não se preocupa em entender e
conhecer essa realidade tão dura.

Aproveitando o ensejo do trabalho, tentei dar um pouco de concretude a
esse aspecto e a contribuir para que seja mais simples daqui pra frente
analisar e estudar essa realidade. Fica, então, desde já o convite para
explorar esse universo e a contribuir para uma sociedade em que nossos
prisioneiros são tratados com a devida dignidade e, assim, fazendo-nos
mais civilizados.

# Por que limpar?

Conforme aprendido no curso, em geral o melhor formato para análises é o
tidy, segundo o qual em uma base de dados devemos ter cada
observação/indivíduo em uma linha e cada variável em uma coluna.
Devemos, também, ter uma base sem informações duplicadas e com as
classes corretas (datas estão na classe Date e não character, por
exemplo).

A importância de ter os dados limpos e organizados foi bem exemplificada
pelo Athos Damiani, que certa vez afirmou que “Por trás de um grande
gráfico há uma grande tabela”.

## O que é a base

Como dito acima, escolhi a base do SISDEPEN para analisarmos. Ela é
resultado de um longo survey com diversas questões e é preenchido por um
responsável de cada Estado (podendo até ter diversos respondentes dentro
da mesma UF). Há perguntas mais e menos abertas e os dados não passam,
até onde se sabe, por nenhuma validação.

Na página do DEPEN são disponibilizadas bases a partir de 2014, sendo a
última delas a de junho de 2020. Embora semestrais (e, portanto, a de
dezembro de 2020 já esteja respondida), há uma defasagem de quase um ano
entre as bases disponibilizadas.

Cada arquivo é disponibilizado em formato .xlsx

## Por que ela não é tidy?

Em um primeiro olhar poderíamos considerá-la uma base tidy uma vez que
cada linha corresponde a uma e somente uma unidade prisional do país.

Contudo, cada base possui cerca de 1.300 (sim, mil e trezentas) colunas,
sendo cada uma delas a resposta para uma pergunta do formulário.

Assim, há variáveis em mais de uma coluna, as classes não estão
corretamente configuradas e as respostas categóricas precisam ser
padronizadas. Além disso, há casos em que não se tem certeza se um valor
NA é por ausência de uma resposta ou porque a pergunta não se aplica
àquele caso.

Por fim, o largo nome das colunas e o fato de não serem identicas ao
longo dos anos torna muito difícil o manuseio e impossível o
empilhamento direto.

# Como foi feita a organização

Em primeiro lugar fiz diversas análises exploratórias para entender
melhor as bases e verificar a utilidade de um trabalho de limpeza. Nessa
etapa foi bastante importante explorar através do pacote janitor e
analisar a documentação existente no documento do DEPEN que explica com
mais detalhes o instrumento de coleta
(<https://www.gov.br/depen/pt-br/sisdepen/mais-informacoes/bases-de-dados/bases-de-dados-1/formulario-sobre-informacoes-prisionais.pdf>)

## Escolhas feitas

Logo de início percebi que o esforço para organizar indiscriminadamente
as milhares de colunas seria pouco proveitoso. O formulário, por ser
muito abrangente, englobava todos os aspectos das políticas
penitenciárias e, por isso, faria sentido priorizar aspectos que eu
entedi mais relevantes.

Sem prejuízo de pretender analisar com mais profundidade todas as
questões num futuro, optei por priorizar variáveis que dissessem
respeito a:

-   informações sobre os estabelecimentos prisionais (localização, tipo
    de gestão, etc)
-   capacidade de custódia de cada unidade
-   lotação de cada unidade
-   tipos de crimes pelos quais as pessoas estão presas
-   perfil da população prisional (gênero, raça, idade, etc)

Por isso, foram priorizados os blocos 1, 4 e 5 do formulário do
SISDEPEN. Dentro de cada bloco, foram selecionadas as variáveis que mais
faziam sentido para análises futuras. Assim, ao invés de selecionar
todas as possíveis, foram “pinçadas” as colunas mais relevantes.

Também, considerando que o objetivo era também poder empilhar as tabelas
das diversas edições do SISDEPEN, fez sentido dividir em 4 bases
menores:

-   base dos estabelecimento (com dados gerais sobre as unidades
    prisionais)
-   base sobre a população prisional em geral (em que podemos ter
    informações sobre ocupação do sistema nos diversos regimes de pena)
-   base sobre perfil pessoal da população prisional (dados sobre raça,
    idade, etc)
-   base sobre perfil criminal (quais as incidências penais dessa
    população)

## Padrão adotado

Foi seguido, ao máximo possível, o guia de estilo do Base dos Dados e,
por isso, os nomes das colunas são bastante extensos e sempre que
disserem respeito a variáveis comuns a outras bases (como código IBGE,
sigla de UF, etc) seguiram o padrão deles.

Mais informações:
<https://basedosdados.github.io/mais/style_data/#formatos-de-valores>

## Funções

Para ajudar (ou melhor, viabilizar) o trabalho, foram construídas
funções que ajudavam em todo o ciclo de baixar e limpar e também para
serem “atalhos” de tarefas repetitivas.

Na pasta /R/ existem os scripts:

-   0-funcoes\_auxiliares: contendo atalhos e funções para apoiar as
    etapas do processo
-   1-baixar\_planilhas\_xlsx\_do\_sisdepen: que faz o scrap dos
    arquivos disponíveis no SISDEPEN e salva na pasta padrão do projeto
-   2-carregar\_base\_sisdepen: que carrega cada um dos arquivos .xslx
    baixados, mantendo as colunas-chave no formato adequado e
    padronizado
-   3-dividir\_em\_blocos\_e\_renomear: com as funções que dão origem a
    cada um dos blocos utilizados e uma função geral para iterar em
    todos os arquivos

Além disso, há o script data.R no qual estão documentadas todas as bases
geradas, com a descrição de cada uma das variáveis.

## Fluxo da limpeza

Na pasta /data-raw/ estão os arquivos utilizados para efetivar o
processo de raspagem, limpeza e análise.

-   Há um script (1-raspar\_e\_baixar\_tabelas\_sisdepen) que realiza o
    processo de web scrap e obtém as tabelas do DEPEN, salvando na
    subpasta /sisdepen/

-   Os scripts limpa\_base\_X realizam o trabalho de carregar, dividir e
    montar cada uma das bases a ser exportada. Neles, também é realizado
    o processo de limpeza - em especial no script relativo à base
    estabelecimentos, uma vez que o maior número de variáveis
    categóricas (de texto) trouxe muito mais esforço na padronização.

-   Visando trazer mais utilidade, o script extra\_busca\_cep fornece
    uma base auxiliar contendo a latitude e longitude de cada um dos
    CEPs localizados das unidades. Esses dados foram incorporados na
    base dos estabelecimentos.

-   Por fim, há um script realizando as análises que serão incorporadas
    a esse README.

## Bases exportadas

Como resultado da análise, foram exportadas as 4 bases a seguir, salvas
na pasta /data/ e carregadas automaticamente com o pacote:

-   base\_estabelecimento
-   base\_populacao
-   base\_perfilpessoal
-   base\_perfilcriminal

Cada uma delas foi documentada, com explicações de cada uma de suas
variáveis.

# Que análises podem ser feitas

Eu quero:

-   distribuição no país de unidades prisionais (saber tipo)
-   comparar vagas x lotação no país
-   evolução da população prisional por ano (desagregar por raça, gênero
    e crime)
-   comparações por estado: taxas de encarceiramento
-   comparar taxas de encarceiramento com criminalidade
-   

separar: base informações das unidades base da capacidade (vagas) base
da lotação Transformar em base única, podendo comparar a mudança de
alguns aspectos ao longo do tempo.

Por exemplo: disponibilidade de vagas e lotação. Mudança de perfil na
população ao longo do tempo. Ver o impacto do HC coletivo das mães.

# Conceitos penitenciários

Capacidade - não existe um critério claro Regime de cumprimento de pena
Provisório/definitivo LEP

# TODO
