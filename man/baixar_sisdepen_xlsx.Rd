% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/baixar_planilhas_xlsx.R
\encoding{UTF-8}
\name{baixar_sisdepen_xlsx}
\alias{baixar_sisdepen_xlsx}
\title{Baixar planilhas disponíveis no SISDEPEN}
\usage{
baixar_sisdepen_xlsx(url_planilha, force = FALSE)
}
\arguments{
\item{url_planilha}{Endereço da planilha raspada do site do DEPEN}

\item{force}{Caso o arquivo já exista na sua pasta ele deve ser subscrito? Por padrão é FALSE.}
}
\value{
O endereço para o arquivo baixado
}
\description{
Faz scrap da página do DEPEN ("https://www.gov.br/depen/pt-br/sisdepen") e baixa
a planilha {.xlsx} informada, salvando na pasta /data-raw/sisdepen
}
