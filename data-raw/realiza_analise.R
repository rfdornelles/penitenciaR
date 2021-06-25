# Pacotes -----------------------------------------------------------------

library(penitenciaR)
library(ggplot2)

# quantidade de unidades prisionais - evolucao
base_estabelecimento %>%
  dplyr::filter(situacao_estabelecimento == "Ativo") %>%
  dplyr::select(id_ano_sisdepen:nome_estabelecimento,
                ambito_federativo,
                sigla_uf) %>%
  dplyr::count(id_ano_sisdepen, id_mes_sisdepen) %>%
  knitr::kable()

# em 2020, quantidade por estado
base_estabelecimento %>%
  dplyr::filter(id_ano_sisdepen %in% c(2014, 2020)) %>%
  dplyr::group_by(id_ano_sisdepen, sigla_uf) %>%
  dplyr::count() %>%
  tidyr::pivot_wider(names_from = id_ano_sisdepen, values_from = n) %>%
  knitr::kable()

# tipo de gestão

base_estabelecimento %>%
  dplyr::filter(situacao_estabelecimento == "Ativo") %>%
  dplyr::select(id_ano_sisdepen:nome_estabelecimento,
                ambito_federativo, sigla_uf, tipo_gestao) %>%
  dplyr::count(id_ano_sisdepen, id_mes_sisdepen, tipo_gestao) %>%
  dplyr::mutate(
    data_sisdepen = paste0(id_ano_sisdepen, "-", id_mes_sisdepen, "-01"),
    data_sisdepen = lubridate::ymd(data_sisdepen)
    ) %>%
  ggplot(aes(x = data_sisdepen, y = n, fill = tipo_gestao)) +
  geom_col() +
  theme_classic() +
  scale_fill_brewer(palette = "Accent", direction = -1) +
  labs(fill = "Tipo de gestão",
       y = "Estabelecimentos",
       x = "Ano",
       title = "Tipo de gestão das unidades prisionais")

# base_estabelecimento %>%
#   dplyr::mutate(
#     data_sisdepen = paste0(id_ano_sisdepen, "-", id_mes_sisdepen, "-01"),
#     data_sisdepen = lubridate::ymd(data_sisdepen)
#   )


# quantidade de presos por estado

base_quantidade_presos <- base_populacao %>%
 # dplyr::filter(id_ano_sisdepen == "2020") %>%
  dplyr::rowwise() %>%
  dplyr::mutate(
    total_provisorios =
      sum(dplyr::across(
        dplyr::matches("provisorio")), na.rm = TRUE),
    total_rf =
      sum(dplyr::across(
        dplyr::matches("sentenca_rf")), na.rm = TRUE),
    total_rsa =
      sum(dplyr::across(
        dplyr::matches("sentenca_rsa")), na.rm = TRUE),
    total_ra =
      sum(dplyr::across(
        dplyr::matches("sentenca_ra")), na.rm = TRUE),
    total_mseg =
      sum(dplyr::across(
        dplyr::matches("sentenca_medseg")), na.rm = TRUE),
    total_populacao =
      sum(dplyr::across(
        dplyr::matches("quantidade_")), na.rm = TRUE),
    total_condenados =
      sum(dplyr::across(
        dplyr::matches("sentenca|medseg")), na.rm = TRUE),
    total_masc =
      sum(dplyr::across(
        dplyr::matches("_mas$")), na.rm = TRUE),
    total_fem =
      sum(dplyr::across(
        dplyr::matches("_fem$")), na.rm = TRUE),
    ) %>%
  dplyr::select(-dplyr::contains("quantidade"))

tabela_quantidade_presos_uf <- base_quantidade_presos %>%
  dplyr::filter(id_ano_sisdepen == 2020) %>%
  dplyr::group_by(sigla_uf) %>%
  dplyr::summarise(
    sum_total_condenados = sum(total_condenados),
    sum_total_provisorios = sum(total_provisorios),
    sum_total_pop = sum(total_populacao),
    sum_total_masc = sum(total_masc),
    sum_total_fem = sum(total_fem),
    pct_provisorios = sum_total_provisorios/sum_total_pop,
    pct_condenados = sum_total_condenados/sum_total_pop,
    pct_masc = sum_total_masc/sum_total_pop,
    pct_fem = sum_total_fem/sum_total_pop
  )

tabela_quantidade_presos_uf %>%
  dplyr::select(sigla_uf, pct_provisorios) %>%
  # tidyr::pivot_longer(names_to = "tipo_prisao",
  #                     cols = pct_provisorios:pct_condenados) %>%
  dplyr::mutate(sigla_uf = forcats::fct_reorder(
    .desc = TRUE,
    sigla_uf,
    pct_provisorios)) %>%
  ggplot(aes(x = sigla_uf, y = pct_provisorios)) +
  geom_col()


## quantidade genero - 2020
mapa_br <- geobr::read_state()

tema_mapa <- function() {

    theme(
      panel.background = element_rect(fill='transparent',
                                      colour='transparent'),
      panel.grid.major = element_blank(),
      panel.grid.minor = element_blank(),
      axis.line=element_blank(),
      axis.text.x=element_blank(),
      axis.text.y=element_blank(),
      axis.ticks=element_blank(),
      axis.title.x=element_blank(),
      axis.title.y=element_blank()
    )
  }

mapa_mulheres <- mapa_br %>%
  dplyr::left_join(
  y = tabela_quantidade_presos_uf %>%
  dplyr::select(sigla_uf, pct_fem),
  by = c("abbrev_state" = "sigla_uf")
  ) %>%
  ggplot() +
  geom_sf(aes(fill = pct_fem), show.legend = F) +
  geom_sf_text(mapping = aes(label = abbrev_state), size = 2,
               color = "grey") +
  scale_fill_gradient(low = "#a88bc4", high = "#1d0338") +
  tema_mapa() +
  labs(title = "Proporção de mulheres presas")


mapa_homens <- mapa_br %>%
  dplyr::left_join(
    y = tabela_quantidade_presos_uf %>%
      dplyr::select(sigla_uf, pct_masc),
    by = c("abbrev_state" = "sigla_uf")
  ) %>%
  ggplot() +
  geom_sf(aes(fill = pct_masc), show.legend = F) +
  geom_sf_text(mapping = aes(label = abbrev_state), size = 2,
               color = "black") +
  scale_fill_gradient(low = "#ffd8a8", high = "#b06100") +
  tema_mapa() +
  labs(title = "Proporção de homens presos")

mapa_homens + mapa_mulheres

base_quantidade_presos %>%
  dplyr::select(-id_ano_sisdepen) %>%
  dplyr::group_by(id_origem_sisdepen, sigla_uf) %>%
  dplyr::summarise_if(.predicate = is.numeric, .funs = sum) %>%
  tidyr::pivot_longer(cols = dplyr::starts_with("total_"),
                      names_to = "tipo_prisao") %>%
  ggplot(aes(x = id_origem_sisdepen, y = value, fill = tipo_prisao)) +
  geom_col(position = "dodge")

base_populacao %>%
  dplyr::filter(situacao_estabelecimento == "Ativo") %>%
  dplyr::select(id_ano_sisdepen:nome_estabelecimento,
                ambito_federativo, sigla_uf, tipo_gestao) %>%
  dplyr::count(id_ano_sisdepen, id_mes_sisdepen, tipo_gestao) %>%
  dplyr::mutate(
    data_sisdepen = paste0(id_ano_sisdepen, "-", id_mes_sisdepen, "-01"),
    data_sisdepen = lubridate::ymd(data_sisdepen)
  ) %>%
  ggplot(aes(x = data_sisdepen, y = n, fill = tipo_gestao)) +
  geom_col()



# quantidade de vagas por estado
base_capacidade <- base_estabelecimento %>%
  dplyr::rowwise() %>%
  dplyr::mutate(
    total_capacidade_provisorio = sum(dplyr::across(
      dplyr::matches("capacidade_provisorio")), na.rm = TRUE),
    total_capacidade_rf = sum(dplyr::across(
      dplyr::matches("capacidade_rfechado")), na.rm = TRUE),
    total_capacidade_ra = sum(dplyr::across(
      dplyr::matches("capacidade_aberto")), na.rm = TRUE),
    total_capacidade_rsa =  sum(dplyr::across(
      dplyr::matches("capacidade_semiaberto")), na.rm = TRUE),
    total_capacidade_outro =  sum(dplyr::across(
      dplyr::matches("outro_|rdd|mseg")), na.rm = TRUE),
    total_capacidade_masc =  sum(dplyr::across(
      dplyr::matches("_mas$")), na.rm = TRUE),
    total_capacidade_fem =  sum(dplyr::across(
      dplyr::matches("_fem$")), na.rm = TRUE),
    total_capacidade_geral =  sum(dplyr::across(
      dplyr::matches("capacidade_")), na.rm = TRUE)
  )

base_capacidade <- base_capacidade %>%
  dplyr::select(id_origem_sisdepen, sigla_uf,
                dplyr::starts_with("total_")) %>%
  dplyr::group_by(id_origem_sisdepen, sigla_uf) %>%
  dplyr::summarise(.groups = "drop",
    sum_total_provisorio = sum(total_capacidade_provisorio),
    sum_total_capacidade_rf = sum(total_capacidade_rf),
    sum_total_capacidade_ra = sum(total_capacidade_ra),
    sum_total_capacidade_rsa = sum(total_capacidade_rsa),
    sum_total_capacidade_outro = sum(total_capacidade_outro),
    sum_total_capacidade_condenado = sum(total_capacidade_rf, total_capacidade_ra,
                                         total_capacidade_rsa, total_capacidade_outro),
    sum_total_capacidade_masc = sum(total_capacidade_masc),
    sum_total_capacidade_fem = sum(total_capacidade_fem),
    sum_total_capacidade_geral = sum(total_capacidade_geral)
  )

base_capacidade %>% View()
  dplyr::filter(id_origem_sisdepen == "2020-junho") %>%
  dplyr::select(sigla_uf, sum_total_capacidade_geral) %>%
  dplyr::arrange(-sum_total_capacidade_geral) %>%
  knitr::kable()

tabela_capacidade <- base_capacidade %>%
  dplyr::group_by(id_origem_sisdepen) %>%
  dplyr::summarise(total_capacidade = sum(sum_total_capacidade_geral))

tabela_ocupacao <- base_quantidade_presos %>%
  dplyr::group_by(id_origem_sisdepen) %>%
  dplyr::summarise(total_ocupacao = sum(total_populacao))

tabela_capacidade %>%
  ggplot(aes(x = id_origem_sisdepen, y = total_capacidade)) +
  geom_col()

tabela_ocupacao %>%
  dplyr::left_join(tabela_capacidade) %>%
  dplyr::mutate(
    lotacao = total_capacidade - total_ocupacao
  ) %>%
  tidyr::pivot_longer(
    cols = total_ocupacao:total_capacidade
  ) %>%
  ggplot(aes(x = id_origem_sisdepen, y = value, fill = name)) +
  geom_col(position = "dodge")

# superlotação por estado

# proporção de crimes

# quantidade de homens e mulheres

# quantidade de pessoas presas por raça

tabela_raca <- base_perfilpessoal %>%
  dplyr::filter(id_ano_sisdepen == 2020) %>%
  dplyr::rowwise() %>%
  dplyr::mutate(
    pop_brancos = sum(dplyr::across(
      dplyr::matches("raca_branca")), na.rm = TRUE),
    pop_negros = sum(dplyr::across(
      dplyr::matches("raca_preta|raca_parda")), na.rm = TRUE),
    pop_amarela = sum(dplyr::across(
      dplyr::matches("raca_amarela")), na.rm = TRUE),
    pop_indigena = sum(dplyr::across(
      dplyr::matches("raca_branca")), na.rm = TRUE),
    pop_naoinformada = sum(dplyr::across(
      dplyr::matches("raca_naoinformada")), na.rm = TRUE)
  ) %>%
  dplyr::select(sigla_uf, dplyr::starts_with("pop_"))

tabela_raca %>%
  dplyr::group_by(sigla_uf) %>%
  dplyr::summarise_if(.predicate = is.numeric, sum) %>%
  janitor::adorn_percentages(denominator = "row") %>%
  #janitor::adorn_pct_formatting() %>%
  tidyr::pivot_longer(cols = -sigla_uf) %>%
  dplyr::mutate(
    name = stringr::str_remove(name, "pop_"),
    sigla_uf = forcats::fct_reorder(sigla_uf, value)
  ) %>%
  ggplot(aes(x = sigla_uf, y = value, fill = name)) +
  geom_col() +
  scale_fill_brewer(palette = "Dark2", direction = -1)

tabela_raca %>%
  dplyr::ungroup() %>%
  dplyr::summarise(brancos = sum(pop_brancos),
                   negros = sum(pop_negros),
                   amarela = sum(pop_amarela),
                   indigena = sum(pop_indigena),
                   na = sum(pop_naoinformada)) %>%
  tidyr::pivot_longer(cols = dplyr::everything()) %>%
  ggplot(aes(x = forcats::fct_reorder(name, value, .desc = T),
             y = value, fill = name)) +
  geom_col(show.legend = F) +
  theme_classic() +
  scale_y_continuous(labels = scales::number_format(
    big.mark = ".", decimal.mark = ",")) +
  scale_fill_brewer(palette = "PuOr", direction = -1) +
  labs(
    x = "Raça", y = "Quantidade de pessoas",
    title = "Distribuição racial nas unidades prisionais",
    subtitle = "em junho de 2020"
  )

### idade

tabela_idade <- base_perfilpessoal %>%
  dplyr::filter(id_ano_sisdepen == 2020) %>%
  dplyr::rowwise() %>%
  dplyr::mutate(
    pop_18a24 = sum(dplyr::across(
      dplyr::matches("18a24")), na.rm = TRUE),
    pop_25a29 = sum(dplyr::across(
      dplyr::matches("25a29")), na.rm = TRUE),
    pop_30a34 = sum(dplyr::across(
      dplyr::matches("30a34")), na.rm = TRUE),
    pop_35a45 = sum(dplyr::across(
      dplyr::matches("35a45")), na.rm = TRUE),
    pop_46a60 = sum(dplyr::across(
      dplyr::matches("46a60")), na.rm = TRUE),
    pop_61a70 = sum(dplyr::across(
      dplyr::matches("61a70")), na.rm = TRUE),
    pop_mais70 = sum(dplyr::across(
      dplyr::matches("mais70")), na.rm = TRUE),
    pop_na = sum(dplyr::across(
      dplyr::matches("idade_naoinformada")), na.rm = TRUE)
    ) %>%
  dplyr::select(sigla_uf, dplyr::starts_with("pop_"))

tabela_idade %>%
  dplyr::ungroup() %>%
  dplyr::summarise_if(is.numeric, sum) %>%
  tidyr::pivot_longer(cols = dplyr::everything()) %>%
  dplyr::mutate(
    name = stringr::str_remove(name, "pop_")
  ) %>%
  ggplot(aes(x = name,
             y = value, fill = name)) +
  geom_col(show.legend = F) +
  theme_classic() +
  scale_y_continuous(labels = scales::number_format(
    big.mark = ".", decimal.mark = ",")) +
  labs(title = "Distribuição em faixas etárias",
       subtitle = "em junho/2020",
       x = "Faixa etária",
       y = "Quantidade de pessoas") +
  scale_fill_brewer(palette = "Set1")
