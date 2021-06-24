# Pacotes -----------------------------------------------------------------

library(penitenciaR)
library(ggplot2)

# quantidade de unidades prisionais - evolucao
base_estabelecimento %>% View()
  dplyr::filter(situacao_estabelecimento == "Ativo") %>%
  dplyr::select(id_ano_sisdepen:nome_estabelecimento,
                ambito_federativo,
                sigla_uf) %>%
  dplyr::count(id_ano_sisdepen, id_mes_sisdepen) %>%
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
  geom_col()

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


