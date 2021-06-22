#' Renomeia colunas
#'
#' @description
#'
#' Aplica a função dplyr::rename() à uma base, mudando o nome da coluna indicada.
#' Será aplicada a função dplyr::matches() para identificar a coluna.
#'
#'Ao final, a coluna nova será
#' @param base Tibble da base
#' @param nome Nome que será recebido
#' @param coluna Expressão que identificará a coluna
#' @param fixa Por padrão, "sigla_uf". Identifica após qual coluna a nova será
#' recolocada.
#'
#' @return Tibble renomeada
#' @encoding UTF-8
#' @export
#'

renomeia_coluna <- function (base, nome, coluna, fixa = "sigla_uf") {

  base_resposta <- base %>%
    dplyr::rename({{nome}} := dplyr::matches(match = coluna,
                                             ignore.case = TRUE))

  if(fixa != FALSE) {

    base_resposta <- base_resposta %>%
       dplyr::relocate({{nome}}, .after = {{fixa}})
  }

  return(base_resposta)

}


# checa_consistência ------------------------------------------------------


#' Chaca consistência
#'
#' @description
#'
#' Testa a consistência das colunas: vai pegar as que não tem total, somar
#' e comparar com a que tem.
#'
#' @param base Qual a base
#' @param nome_coluna Nome da coluna "
#'
#' @return
#' @export
#'
#'

checa_consistencia_numero <- function(base, nome_coluna) {

  base %>%
    dplyr::select(
      dplyr::contains(nome_coluna)) %>%
    dplyr::mutate(
      sem_total = rowSums(
        dplyr::across(
          dplyr::matches(match = "[^(Total)]")
        ), na.rm = TRUE),
      total = rowSums(dplyr::across(dplyr::contains("Total")), na.rm = TRUE),
      consistente = sem_total == total
    )
}

# ler_colunas -------------------------------------------------------------

#' Ler os nomes das colunas e colocar na área de transferência
#'
#' @description Em caso de necessitar manipular bases com muitas colunas,
#' a função irá carregar e imprimir em formato amigável e colocar na
#' área de transferência para que seja colada com CNTR+V.
#'
#' Útil para colocar as colunas no regex101.cim
#'
#' @param base
#'
#' @return Vetor de character contendo as colunas da base.
#' @export
#' @encoding UTF-8

ler_colunas <- function(base) {

  nomes_colunas <- base %>%
    names() %>%
    paste0(collapse = "\n")

  #copia para área de transferência
  clipr::write_clip(nomes_colunas)

  #imprime bonito na tela
  cat(nomes_colunas)

  # retorna o valor de forma invisível
  invisible(nomes_colunas)

}


# totitlecasePT -----------------------------------------------------------

#' Convertion to title case with lower case for some classes of words.
#'
#' By José Jesus Filho
#'
#' In written Portuguese, when converting to title case, it is not usual
#' to keep in title case some words, like prepositions, conjunctions,
#' articles and some kinds of pronouns.  This functions locates those
#' cases and converts them to lower case.
#'
#' @param string vector of characters to be converted to title case
#'     but with connector words (one-word prepositions and conjunctions)
#'     and articles (both definite and indefinite) and some pronouns
#'     in lower case.
#'
#' @details
#' The current list of words converted to lower case is:
#' - articles
#'   - o(s), a(s), um, uma(s), uns
#' - pronouns
#'   - me, mim, meu(s), minha(s)
#'   - te, ti, teu(s), tua(s)
#'   - lhe(s), seu(s), sua(s)
#'   - nos, nosso(a)(s)
#'   - vos, vosso(a)(s)
#' - prepositions, their contractions and combinations
#'   - prepositions
#'     - a, ante, até, após, com, contra, de, desde, em, entre, para,
#'       perante, por, sem, sob, sobre, trás
#'   - contractions
#'     - à(s), do(a)(s), no(a)(s), pelo(a)(s), pro(a)(s) (informal language)
#'   - combinations
#'     - ao(s)
#' - conjunctions
#'   - conforme, conquanto, contudo, durante, embora, enquanto, então,
#'     entretanto, exceto, logo, mas, nem, ou, ora, pois, porém, porque,
#'     porquanto, portanto, quando, quanto, que, se, senão, todavia
#'
#' The above list is far from complete or exaustive, mainly due to the absence
#' of the accidental prepositions and conjuntions, which are words that are not
#' originally prepositions or conjunctions, but can play those roles in some contexts,
#' like, for instance _segundo_, which can mean either the numeral _second_ or
#' the prepositional expression _acording to_.
#'
#' @return vector of characters with the same dimension of `string`
#' @export
#'

ToTitleCasePT <- function(string) {

  string %>%
    stringr::str_to_title() %>%
    stringr::str_replace_all( # using `c("regex" = "replacement")` syntax
      c(
        # articles
        "(.)\\bA(s)?\\b" = "\\1a\\2",
        "(.)\\bO(s)?\\b" = "\\1o\\2",
        "(.)\\bU((m(a(s)?)?)|ns)\\b" = "\\1u\\2",
        # oblique pronouns
        "(.)\\bL(he(s)?)\\b" = "\\1l\\2",
        "(.)\\bM((e(u(s)?)?)|(i(m|(nha(s)?))))\\b" = "\\1m\\2",
        "(.)\\bN(os(s[ao](s)?)?)\\b" = "\\1n\\2",
        "(.)\\bS((e(u(s)?)?)|(ua(s)?))\\b" = "\\1s\\2",
        "(.)\\bT((e(u(s)?)?)|i|(ua(s)?))\\b" = "\\1t\\2",
        "(.)\\bV(os(s[ao](s)?)?)\\b" = "\\1v\\2",
        # prepositions
        "(.)\\bA((o)(s)?|nte|té|pós)\\b" = "\\1a\\2",
        "(.)\\bÀ(s)?\\b" = "\\1à\\2",
        "(.)\\bC(om|ontra)\\b" = "\\1c\\2",
        "(.)\\bD(((a|o)(s)?)|(e(sde)?))\\b" = "\\1d\\2",
        "(.)\\bE(m|ntre)\\b" =  "\\1e\\2",
        "(.)\\bN((a|o)(s)?)\\b" = "\\1n\\2",
        "(.)\\bP(ara|(e((l(a|o)(s)?)|rante))|or)\\b" = "\\1p\\2",
        "(.)\\bS(em|(ob(re)?))\\b" = "\\1s\\2",
        "(.)\\bT(rás)\\b" = "\\1t\\2",
        # conjunctions
        "(.)\\bC(on(forme|quanto|tudo))\\b" = "\\1c\\2",
        "(.)\\bD(urante)\\b" = "\\1D\\2",
        "(.)\\bE((mbora|n(quanto|t(ão|retanto))|xceto)?)\\b" = "\\1e\\2",
        "(.)\\bL(ogo)\\b" = "\\1l\\2",
        "(.)\\bM(as)\\b" = "\\1m\\2",
        "(.)\\bN(em)\\b" = "\\1n\\2",
        "(.)\\bO(u|ra)\\b" = "\\1o\\2",
        "(.)\\bP(o(is|r(ém|qu(e|anto)|tanto)))\\b" = "\\1p\\2",
        "(.)\\bQ(u(an[dt]o|e))\\b" = "\\1q\\2",
        "(.)\\bS(e(não)?)\\b" = "\\1s\\2",
        "(.)\\bT(odavia)\\b" = "\\1t\\2"
      )
    )
}
