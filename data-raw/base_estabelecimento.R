library(penitenciaR)

# Carregar a base ---------------------------------------------------------
base_estabelecimento <- carrega_e_aplica(arruma_bloco_estabelecimento)


# Identificar problemas ---------------------------------------------------

# ver colunas que estão duplicadas
# endereço_estabelecimento1 - são IPs
# endereço_estabelecimento2 - emails

base_estabelecimento <- base_estabelecimento %>%
  dplyr::select(-endereco_estabelecimento1, -endereco_estabelecimento2)

# endereco_estabelecimento3 tem informação na maioria das vezes que
# a coluna endereco_estabelecimento não
# substituir por endereco_estabelecimento3 quando for NA

base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
    endereco_estabelecimento = dplyr::if_else(
      condition = is.na(endereco_estabelecimento),
      true = endereco_estabelecimento3,
      false = endereco_estabelecimento
    )
  ) %>%
  dplyr::select(-endereco_estabelecimento3)

## ver outras duplicadas
base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
    quantidade_celas_interditadas = dplyr::if_else(
      is.na(quantidade_celas_interditadas),
      true =  dplyr::case_when(
        quantidade_celas_interditadas2 != "0" ~ quantidade_celas_interditadas2,
        TRUE ~ quantidade_celas_interditadas1
      ),
      false = quantidade_celas_interditadas
    )
  ) %>%
  dplyr::select(-quantidade_celas_interditadas1,
                -quantidade_celas_interditadas2)

# sigla_uf ----------------------------------------------------------------

# sigla_uf: tirar união
base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
    sigla_uf = stringr::str_remove_all(sigla_uf, "União| \\- "),
    sigla_uf = dplyr::if_else(sigla_uf == "", NA_character_, sigla_uf)
  )


# tipo_gestao -------------------------------------------------------------

base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
    tipo_gestao = dplyr::case_when(
      checa(tipo_gestao, "^P.blica") ~ "Pública",
      checa(tipo_gestao, "Co-gest.*") ~ "Co-gestão",
      checa(tipo_gestao, "^Parceria P.*") ~ "PPP",
      checa(tipo_gestao, "Organiza.* sem fins") ~ "Organizações sem fins lucrativos"
    )
  )

# dest_original_ ----------------------------------------------------------


# dest_original_tipo
# não é muito bom pois embora a pergunta seja o destino ORIGNAL se responde
# muitas vezes qual é a utilização hoje

base_estabelecimento <- base_estabelecimento %>%
   dplyr::mutate(
     dest_original_tipo = dplyr::case_when(
    checa(dest_original_tipo, "recolhimento de pres.s provis.ri.s") ~ "Presos provisórios",
    checa(dest_original_tipo, "cumprimento de pena em regime fechado") ~ "Regime fechado",
    checa(dest_original_tipo, "cumprimento de pena em regime semi.*aberto") ~ "Regime semiaberto",
    checa(dest_original_tipo, "cumprimento de pena em regime aberto") ~ "Regime aberto",
    checa(dest_original_tipo, "medida de segurança de interna.*o") ~ "Medida de segurança",
    checa(dest_original_tipo, "diversos tipos de regime") ~ "Regimes diversos",
    checa(dest_original_tipo, "exames gerais e criminológico|triagem") ~ "Triagem",
    checa(dest_original_tipo, "patronato") ~ "Patronato",
    checa(dest_original_tipo, "monitora.* eletr.nic.|virtual|central de moni.*|monitora.* de") ~ "Monitoração eletrônica",
    checa(dest_original_tipo, "APAC") ~ "APAC",
    checa(dest_original_tipo, "RDD|regime disciplinar") ~ "Regime Disciplinar Diferenciado",
    checa(dest_original_tipo, "delegacia") ~ "Delegacia de polícia",
    checa(dest_original_tipo, "(todos|diversos).*regimes|misto") ~ "Diversos regimes",
    TRUE ~ "Outro"
    )
  )

# dest_original_genero
base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
    dest_original_genero = ToTitleCasePT(dest_original_genero),
    dest_original_genero = dplyr::case_when(
      dest_original_genero == "Masculino" ~ "Masculino",
      dest_original_genero == "Feminino" ~ "Feminino",
      dest_original_genero == "Masculino e Feminino" ~ "Misto",
      checa(dest_original_genero, "Misto") ~ "Misto",
      TRUE ~ NA_character_
    )
  )

# dest_original_original
# deveria ser apenas 'concebido' ou 'adaptado'
base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
    dest_original_original = dplyr::case_when(
      # há alguns casos em que ambas as opções foram marcadas ¯\_(ツ)_/¯
      # colocando-as em primeiro lugar e já transformando em NA pra não
      # poluir as demais
      checa(dest_original_original, "Concebido como estabelecimento penal \\| Adaptado para estabelecimento penal") ~ NA_character_,
      checa(dest_original_original, "Adaptado para estabelecimento penal \\| Concebido como estabelecimento penal") ~ NA_character_,
      checa(dest_original_original, "^Concebido") ~ "Concebido",
      checa(dest_original_original, "^Adaptado") ~ "Adaptado",
      TRUE ~ NA_character_
    )
  )

# regimento interno -------------------------------------------------------


# regimento_interno_possui
base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
    regimento_interno_possui = dplyr::case_when(
      checa(regimento_interno_possui, "Sim \\| Não") ~ NA_character_,
      checa(regimento_interno_possui, "Sim") ~ "Sim",
      checa(regimento_interno_possui, "N.o") ~ "Não",
      TRUE ~ NA_character_
    )
  )

# regimento_interno_exclusivo
base_estabelecimento <- base_estabelecimento  %>%
  dplyr::mutate(
    regimento_interno_exclusivo = dplyr::case_when(
      checa(regimento_interno_exclusivo, "Espec.fico para") ~ "Específico",
      checa(regimento_interno_exclusivo, "Aplica-se a todos os") ~ "Comum aos demais estabelecimentos",
      checa(regimento_interno_exclusivo, "Outr(a|o)") ~ "Outro",
      TRUE ~ NA_character_
    )
  )


# terceirização -----------------------------------------------------------

### tercerizações
base_estabelecimento %>%
  penitenciaR::conta_valores("terceiriza")

# terceiriza_nenhum
base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
    terceiriza_nenhum = dplyr::if_else(
      terceiriza_nenhum == "Nenhum", "Não", terceiriza_nenhum),
    terceiriza_nenhum = dplyr::if_else(
      checa(terceiriza_nenhum, "ç"), "Sim", terceiriza_nenhum),
    terceiriza_nenhum = numero_para_sim_nao(terceiriza_nenhum)
  )

# terceiriza_alimentacao
base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
    terceiriza_alimentacao = dplyr::if_else(
      terceiriza_alimentacao == "Alimentação", "Sim", terceiriza_alimentacao
    ),
    terceiriza_alimentacao = numero_para_sim_nao(terceiriza_alimentacao)
  )

# terceiriza_limpeza
base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
    terceiriza_limpeza = dplyr::if_else(
      terceiriza_limpeza == "Limpeza", "Sim", terceiriza_limpeza
    ),
    terceiriza_limpeza = numero_para_sim_nao(terceiriza_limpeza)
  )

# terceiriza_lavanderia
base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
    terceiriza_lavanderia = dplyr::if_else(
      terceiriza_lavanderia == "lavanderia", "Sim", terceiriza_lavanderia
    ),
    terceiriza_lavanderia = numero_para_sim_nao(terceiriza_lavanderia)
  )

# terceiriza_saude
base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
    terceiriza_saude = dplyr::if_else(
      checa(terceiriza_saude, "Sa.de"), "Sim", terceiriza_saude
    ),
    terceiriza_saude = numero_para_sim_nao(terceiriza_saude)
  )

# terceiriza_seguranca
base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
    terceiriza_seguranca = dplyr::if_else(
      checa(terceiriza_seguranca, "Seguran.a"), "Sim", terceiriza_seguranca
    ),
    terceiriza_seguranca = numero_para_sim_nao(terceiriza_seguranca)
  )

# terceiriza_educacao
base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
    terceiriza_educacao = dplyr::if_else(
      checa(terceiriza_educacao, "educa.*"), "Sim", terceiriza_educacao
    ),
    terceiriza_educacao = numero_para_sim_nao(terceiriza_educacao)
  )


# terceiriza_laboral
base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
    terceiriza_laboral = numero_para_sim_nao(terceiriza_laboral)
  )

# terceiriza_ass_social
base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
   terceiriza_ass_social = dplyr::if_else(
     checa(terceiriza_ass_social, "social"), "Sim", terceiriza_ass_social
   ),
   terceiriza_ass_social = numero_para_sim_nao(terceiriza_ass_social)
  )


# terceiriza_ass_juridica
base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
    terceiriza_ass_juridica = dplyr::if_else(
      checa(terceiriza_ass_juridica, "jur.dica"), "Sim", terceiriza_ass_juridica
    ),
   terceiriza_ass_juridica = numero_para_sim_nao(terceiriza_ass_juridica)
  )

# terceiriza_administrativo
base_estabelecimento <- base_estabelecimento %>%
  dplyr::mutate(
    terceiriza_administrativo = dplyr::if_else(
      checa(terceiriza_administrativo, "administ.*"), "Sim", terceiriza_administrativo
    ),
    terceiriza_administrativo = numero_para_sim_nao(terceiriza_administrativo)
  )


# data --------------------------------------------------------------------

