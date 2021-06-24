
<!-- README.md is generated from README.Rmd. Please edit that file -->

Leitura, limpeza e primeiras análises das bases de dados do SISDEPEN
para fins de conclusão do curso de Faxina de Dados da Curso-R.

Também, espera-se poder disponibilizar esses dados na Base dos Dados.
Para isso, seguiremos as orientações:

## <https://basedosdados.github.io/mais/colab_data/>

limpar o que é NA e o que é não se aplica

Eu quero:

-   distribuição no país de unidades prisionais (saber tipo)
-   comparar vagas x lotação no país
-   evolução da população prisional por ano (desagregar por raça, gênero
    e crime)
-   comparações por estado: taxas de encarceiramento
-   comparar taxas de encarceiramento com criminalidade

------------------------------------------------------------------------

separar: base informações das unidades base da capacidade (vagas) base
da lotação

A criação deste pacote seguiu o passo a passo disponível em

<https://curso-r.github.io/zen-do-r/pacotes.html>

Os passos são:

1.  usethis::create\_package(“exemplo.pacote”)

2.  usethis::use\_mit\_license(“Seu Nome”)

3.  usethis::use\_data\_raw()

4.  Cópia do arquivo “DadosBO\_2021\_3(ROUBO DE
    VEÍCULOS))\_completa.xls” para a pasta data-raw

5.  Adaptação e salvamento em data-raw/DATASET.r do script que
    transforma o dado bruto em dado tidY

6.  Inclusão dos pacotes utilizados no data-raw nos Suggests deste
    pacote: usethis::use\_package(“tidyverse”, type = “Suggests”)
    usethis::use\_package(“readxl”, type = “Suggests”)

7.  usethis::use\_data(dados\_roubo\_veiculos\_ssp\_2020\_2021,
    overwrite = TRUE)

8.  Documentação dos dados em
    “R/dados\_roubo\_veiculos\_ssp\_2020\_2021.R”

9.  devtools::document() \#\# O que é a base

Survey Sisdepen Nesse formato desde 2014 Periodicidade: primeiro era 1
ano, depois seis meses.

São mil e tantas colunas

## Por que foi escolhida?

Parece tidy mas não é. Não era possível simplesmente empilhá-las pois as
colunas são diferentes. Difícil de manusear.

## Objetivo

Transformar em base única, podendo comparar a mudança de alguns aspectos
ao longo do tempo.

Por exemplo: disponibilidade de vagas e lotação. Mudança de perfil na
população ao longo do tempo. Ver o impacto do HC coletivo das mães.

<https://basedosdados.github.io/mais/style_data/#formatos-de-valores>

## Estratégia

## Funções

-   para baixar
-   para ler
-   para renomear as colunas - estratégia escolhida foi renomear as
    colunas que eu queria e ignorar as demais

## Conceitos penitenciários

Capacidade - não existe um critério claro Regime de cumprimento de pena
Provisório/definitivo LEP

| nome       | regime correspondente                                   |
|------------|---------------------------------------------------------|
| provisório | presos provisórios, sem condenação definitiva           |
| rfechado   | presos já condenados em regime fechado                  |
| semiaberto | presos já condenados em regime semiaberto               |
| aberto     | presos já condenados em regime aberto                   |
| rdd        | regime disciplinar diferenciado                         |
| mseg       | medida de segurança de internação (presos inimputáveis) |
| outro      | outros tipos de vaga                                    |

## Aspecto humano

O sistema penitenciário é uma realidade desconhecida. Temos centenas de
milhares de pessoas, presas, invisibilizadas porém concretas. Por razões
raciais, sócio-econômicas e culturais, a situação é convenientemente
escondida de nós.

Aproveitando o ensejo do trabalho, tentei dar um pouco de concretude a
essa realidade. Aparentemente, por meio das ciências exatas fica mais
fácil lembrar às ciências humanas sua própria humanidade.
