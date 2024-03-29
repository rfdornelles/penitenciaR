
# Pacotes -----------------------------------------------------------------

library(magrittr)
library(penitenciaR)


# Carregar base  ----------------------------------------------------------

base_path <- "data-raw/sisdepen/InfopenJunhode2020.xlsx"

base_2020 <- penitenciaR::carregar_base_sisdepen(base_path)


# Bloco 1 - estabelecimento -----------------------------------------------

base_2020 <- base_2020 %>%
  renomeia_coluna("nome_estabelecimento_outro", "outras denomina..es") %>%
  renomeia_coluna("endereco_estabelecimento", "endere.o") %>%
  renomeia_coluna("nome_municipio", "^município") %>%
  renomeia_coluna("ambito_federativo", ".mbito") %>%
  renomeia_coluna("bairro_estabelecimento", "bairro") %>%
  renomeia_coluna("cep_estabelecimento", "^cep") %>%
  renomeia_coluna("situacao_estabelecimento", "situa..o do estabelecimento") %>%
  renomeia_coluna("data_inauguracao", "1.6 Data de inauguração") %>%
  renomeia_coluna("dest_original_genero", "1.1 Estabelecimento originalmente") %>%
  renomeia_coluna("dest_original_tipo", "1.2 Tipo de estabelecimento") %>%
  renomeia_coluna("dest_original_original", "1.7 O estabelecimento") %>%
  renomeia_coluna("tipo_gestao", "1.4 Gestão do estabelecimento") %>%
  renomeia_coluna("regimento_interno_possui", "1.8 Possui regimento") %>%
  renomeia_coluna("regimento_interno_exclusivo", "1.9 O regimento interno") %>%
  renomeia_coluna("capacidade_provisorio_mas", "1.3 .* provisórios \\| Masculino") %>%
  renomeia_coluna("capacidade_provisorio_fem", "1.3 .* provisórios \\| Feminino") %>%
  renomeia_coluna("capacidade_rfechado_mas", "1.3 .* fechado \\| Masculino") %>%
  renomeia_coluna("capacidade_rfechado_fem", "1.3 .* fechado \\| Feminino") %>%
  renomeia_coluna("capacidade_semiaberto_mas", "1.3 .* semiaberto \\| Masculino") %>%
  renomeia_coluna("capacidade_semiaberto_fem", "1.3 .* semiaberto \\| Feminino") %>%
  renomeia_coluna("capacidade_rdd_mas", "1.3 .* disciplinar .* \\| Masculino") %>%
  renomeia_coluna("capacidade_rdd_fem", "1.3 .* disciplinar .* \\| Feminino") %>%
  renomeia_coluna("capacidade_mseg_mas", "1.3 .* medidas de seg.* \\| Masculino") %>%
  renomeia_coluna("capacidade_mseg_fem", "1.3 .* medidas de seg.* \\| Feminino") %>%
  renomeia_coluna("capacidade_aberto_mas", "1.3 .* Regime aberto.* \\| Masculino") %>%
  renomeia_coluna("capacidade_aberto_fem", "1.3 .* Regime aberto.* \\| Feminino") %>%
  renomeia_coluna("tipo_capacidade_outros", "1.3 Capacidade .* (Qual\\(is\\)\\?)$") %>%
  renomeia_coluna("capacidade_outro_mas", "1.3 Capacidade .* Outro.* \\| Masculino") %>%
  renomeia_coluna("capacidade_outro_fem", "1.3 Capacidade .* Outro.* \\| Feminino") %>%
  renomeia_coluna("quantidade_celas_interdidatas", "1.3 .* \\| Celas não aptas") %>%
  renomeia_coluna("capacidade_interditada_mas", "1.3 .* desativadas .* Masculino") %>%
  renomeia_coluna("capacidade_interditada_fem", "1.3 .* desativadas .* Feminino") %>%
  # ver com cuidado essa: terceiriza_nenhum deveria ser não para todos os demais
  renomeia_coluna("terceiriza_nenhum", "1.5 .* Nenhum") %>%
  renomeia_coluna("terceiriza_alimentacao", "1.5 .* Alimenta..o") %>%
  renomeia_coluna("terceiriza_seguranca", "1.5 .* Seguran.a") %>%
  renomeia_coluna("terceiriza_limpeza", "1.5 .* Limpeza") %>%
  renomeia_coluna("terceiriza_lavanderia", "1.5 .* Lavanderia") %>%
  renomeia_coluna("terceiriza_saude", "1.5 .* Sa.de")  %>%
  renomeia_coluna("terceiriza_educacao", "1.5 .* educacional")  %>%
  renomeia_coluna("terceiriza_laboral", "1.5 .* laboral")  %>%
  renomeia_coluna("terceiriza_ass_social", "1.5 .* Assist.ncia social")  %>%
  renomeia_coluna("terceiriza_ass_juridica", "1.5 .* Assist.ncia jurídica") %>%
  renomeia_coluna("terceiriza_administrativo", "1.5 .* administrativos")  %>%
  renomeia_coluna("terceiriza_quais_outros", "1.5 .* Outro") %>%
  renomeia_coluna("total_capacidade_provisorios", "1.3 .*presos provis.rios.*Total$") %>%
  renomeia_coluna("total_capacidade_regimefechado", "1.3 .*regime fechado.*Total$") %>%
  renomeia_coluna("total_capacidade_regimeaberto", "1.3 .*regime aberto.*Total$") %>%
  renomeia_coluna("total_capacidade_regimesemiaberto", "1.3 .*regime semi?aberto.*Total$") %>%
  renomeia_coluna("total_capacidade_regimedisciplinardiferenciado", "1.3 .*regime disciplinar.*Total$") %>%
  renomeia_coluna("total_capacidade_medidasegurancainternacao", "1.3 .* medidas de seguran.a .*Total$") %>%
  renomeia_coluna("total_capacidade_outrasvagas", "1.3 .*outro.*Total$") %>%
  renomeia_coluna("total_capacidade_masculino", "1.3 .*capacidade do estabelecimento.*Masculino.*Total$") %>%
  renomeia_coluna("total_capacidade_feminino", "1.3 .*capacidade do estabelecimento.*feminino.*Total$") %>%
  renomeia_coluna("total_capacidade_vagasdesativadas", "1.3.*capacidade.*total.*vagas.*desativadas")


# Bloco 4 - população geral -----------------------------------------------

base_2020 <- base_2020 %>%
  # provisórios
  renomeia_coluna("quantidade_presoprovisorio_jusestadual_mas", "4.1 .*provisórios.*Estadual Masc") %>%
  renomeia_coluna("quantidade_presoprovisorio_jusestadual_fem", "4.1 .*provisórios.*Estadual Femin") %>%
  renomeia_coluna("quantidade_presoprovisorio_jusfederal_mas", "4.1 .*provisórios.*Federal Masc") %>%
  renomeia_coluna("quantidade_presoprovisorio_jusfederal_fem", "4.1 .*provisórios.*Federal Femin") %>%
  renomeia_coluna("quantidade_presoprovisorio_outrajus_mas", "4.1 .*provisórios.*Outros.* Masc") %>%
  renomeia_coluna("quantidade_presoprovisorio_outrajus_fem", "4.1 .*provisórios.*Outros.* Femin") %>%
  # presos sentenciados - regime fechado
  renomeia_coluna("quantidade_sentenca_rf_jusestadual_mas", "4.1 .*sentenciados.*fechado.*Estadual Masc") %>%
  renomeia_coluna("quantidade_sentenca_rf_jusestadual_fem", "4.1 .*sentenciados.*fechado.*Estadual Femin") %>%
  renomeia_coluna("quantidade_sentenca_rf_jusfederal_mas", "4.1 .*sentenciados.*fechado.*Federal Masc") %>%
  renomeia_coluna("quantidade_sentenca_rf_jusfederal_fem", "4.1 .*sentenciados.*fechado.*Federal Femin") %>%
  renomeia_coluna("quantidade_sentenca_rf_outrajus_mas", "4.1 .*sentenciados.*fechado.*Outros.* Masc") %>%
  renomeia_coluna("quantidade_sentenca_rf_outrajus_fem", "4.1 .*sentenciados.*fechado.*Outros.* Femin") %>%
  # presos sentenciados - regime semi aberto
  renomeia_coluna("quantidade_sentenca_rsa_jusestadual_mas", "4.1 .*sentenciados.*semiaberto.*Estadual Masc") %>%
  renomeia_coluna("quantidade_sentenca_rsa_jusestadual_fem", "4.1 .*sentenciados.*semiaberto.*Estadual Femin") %>%
  renomeia_coluna("quantidade_sentenca_rsa_jusfederal_mas", "4.1 .*sentenciados.*semiaberto.*Federal Masc") %>%
  renomeia_coluna("quantidade_sentenca_rsa_jusfederal_fem", "4.1 .*sentenciados.*semiaberto.*Federal Femin") %>%
  renomeia_coluna("quantidade_sentenca_rsa_outrajus_mas", "4.1 .*sentenciados.*semiaberto.*Outros.* Masc") %>%
  renomeia_coluna("quantidade_sentenca_rsa_outrajus_fem", "4.1 .*sentenciados.*semiaberto.*Outros.* Femin") %>%
  # presos sentenciados - regime aberto
  renomeia_coluna("quantidade_sentenca_ra_jusestadual_mas", "4.1 .*sentenciados.* aberto.*Estadual Masc") %>%
  renomeia_coluna("quantidade_sentenca_ra_jusestadual_fem", "4.1 .*sentenciados.* aberto.*Estadual Femin") %>%
  renomeia_coluna("quantidade_sentenca_ra_jusfederal_mas", "4.1 .*sentenciados.* aberto.*Federal Masc") %>%
  renomeia_coluna("quantidade_sentenca_ra_jusfederal_fem", "4.1 .*sentenciados.* aberto.*Federal Femin") %>%
  renomeia_coluna("quantidade_sentenca_ra_outrajus_mas", "4.1 .*sentenciados.* aberto.*Outros.* Masc") %>%
  renomeia_coluna("quantidade_sentenca_ra_outrajus_fem", "4.1 .*sentenciados.* aberto.*Outros.* Femin") %>%
  # presos em medida de segurança - internação
  renomeia_coluna("quantidade_medseg_internacao_jusestadual_mas", "4.1 .*de segurança.* interna.*Estadual Masc") %>%
  renomeia_coluna("quantidade_medseg_internacao_jusestadual_fem", "4.1 .*de segurança.* interna.*Estadual Femin") %>%
  renomeia_coluna("quantidade_medseg_internacao_jusfederal_mas", "4.1 .*de segurança.* interna.*Federal Masc") %>%
  renomeia_coluna("quantidade_medseg_internacao_jusfederal_fem", "4.1 .*de segurança.* interna.*Federal Femin") %>%
  renomeia_coluna("quantidade_medseg_internacao_outrajus_mas", "4.1 .*de segurança.* interna.*Outros.* Masc") %>%
  renomeia_coluna("quantidade_medseg_internacao_outrajus_fem", "4.1 .*de segurança.* interna.*Outros.* Femin") %>%
  # presos em medida de segurança - tratamento ambulatorial
  renomeia_coluna("quantidade_medseg_ambulatorial_jusestadual_mas", "4.1 .*de segurança.* ambulatorial.*Estadual Masc") %>%
  renomeia_coluna("quantidade_medseg_ambulatorial_jusestadual_fem", "4.1 .*de segurança.* ambulatorial.*Estadual Femin") %>%
  renomeia_coluna("quantidade_medseg_ambulatorial_jusfederal_mas", "4.1 .*de segurança.* ambulatorial.*Federal Masc") %>%
  renomeia_coluna("quantidade_medseg_ambulatorial_jusfederal_fem", "4.1 .*de segurança.* ambulatorial.*Federal Femin") %>%
  renomeia_coluna("quantidade_medseg_ambulatorial_outrajus_mas", "4.1 .*de segurança.* ambulatorial.*Outros.* Masc") %>%
  renomeia_coluna("quantidade_medseg_ambulatorial_outrajus_fem", "4.1 .*de segurança.* ambulatorial.*Outros.* Femin")


# Bloco 5 - perfil pessoal ------------------------------------------------

base_2020 <- base_2020 %>%
  renomeia_coluna("possui_registro_idade", "5.1 .* tem condi..es de obter") %>%
  renomeia_coluna("possui_registro_raca", "5.2 .* tem condi..es de obter") %>%
  renomeia_coluna("possui_registro_procedencia", "5.3 .* tem condi..es de obter") %>%
  renomeia_coluna("possui_registro_estadocivil", "5.4 .* tem condi..es de obter") %>%
  renomeia_coluna("possui_registro_pcd", "5.5 .* tem condi..es de obter") %>%
  # quanidade por idade
  # 18 a 24
  renomeia_coluna("quantidade_idade_18a24_fem", "5.1 .* faixa etária .* 18 a 24.* Femi") %>%
  renomeia_coluna("quantidade_idade_18a24_mas", "5.1 .* faixa etária .* 18 a 24.* Masc") %>%
  # 25 a 29
  renomeia_coluna("quantidade_idade_25a29_fem", "5.1 .* faixa etária .* 25 a 29.* Femi") %>%
  renomeia_coluna("quantidade_idade_25a29_mas", "5.1 .* faixa etária .* 25 a 29.* Masc") %>%
  # 30 a 34
  renomeia_coluna("quantidade_idade_30a34_fem", "5.1 .* faixa etária .* 30 a 34.* Femi") %>%
  renomeia_coluna("quantidade_idade_30a34_mas", "5.1 .* faixa etária .* 30 a 34.* Masc") %>%
  # 35 a 45
  renomeia_coluna("quantidade_idade_35a45_fem", "5.1 .* faixa etária .* 35 a 45.* Femi") %>%
  renomeia_coluna("quantidade_idade_35a45_mas", "5.1 .* faixa etária .* 35 a 45.* Masc") %>%
  # 46 a 60
  renomeia_coluna("quantidade_idade_46a60_fem", "5.1 .* faixa etária .* 46 a 60.* Femi") %>%
  renomeia_coluna("quantidade_idade_46a60_mas", "5.1 .* faixa etária .* 46 a 60.* Masc") %>%
  # 61 a 70
  renomeia_coluna("quantidade_idade_61a70_fem", "5.1 .* faixa etária .* 61 a 70.* Femi") %>%
  renomeia_coluna("quantidade_idade_61a70_mas", "5.1 .* faixa etária .* 61 a 70.* Masc") %>%
  # mais 70
  renomeia_coluna("quantidade_idade_mais70_fem", "5.1 .* faixa etária .* mais de 70.* Femi") %>%
  renomeia_coluna("quantidade_idade_mais70_mas", "5.1 .* faixa etária .* mais de 70.* Masc") %>%
  # não informada
  renomeia_coluna("quantidade_idade_naoinformada_fem", "5.1 .* faixa etária .*Não informado .* Femi") %>%
  renomeia_coluna("quantidade_idade_naoinformada_mas", "5.1 .* faixa etária .*Não informado .* Masc") %>%
  ### raça
  # branca
  renomeia_coluna("quantidade_raca_branca_fem", "5.2 .*raça.* Branca .* Femi") %>%
  renomeia_coluna("quantidade_raca_branca_mas", "5.2 .*raça.* Branca .* Masc") %>%
  # preta
  renomeia_coluna("quantidade_raca_preta_fem", "5.2 .*raça.* Preta .* Femi") %>%
  renomeia_coluna("quantidade_raca_preta_mas", "5.2 .*raça.* Preta .* Masc") %>%
  # parda
  renomeia_coluna("quantidade_raca_parda_fem", "5.2 .*raça.* Parda .* Femi") %>%
  renomeia_coluna("quantidade_raca_parda_mas", "5.2 .*raça.* Parda .* Masc") %>%
  # indígena
  renomeia_coluna("quantidade_raca_amarela_fem", "5.2 .*raça.* Amarela .* Femi") %>%
  renomeia_coluna("quantidade_raca_amarela_mas", "5.2 .*raça.* Amarela .* Masc") %>%
  # amarela
  renomeia_coluna("quantidade_raca_indigena_fem", "5.2 .*raça.* Indígena .* Femi") %>%
  renomeia_coluna("quantidade_raca_indigena_mas", "5.2 .*raça.* Indígena .* Masc") %>%
  # não informada
  renomeia_coluna("quantidade_raca_naoinformada_fem", "5.2 .*raça.* Não informado .* Femi") %>%
  renomeia_coluna("quantidade_raca_naoinformada_mas", "5.2 .*raça.* Não informado .* Masc") %>%
  ## procedência
  # urbana - interior
  renomeia_coluna("quantidade_procedencia_interior_mas", "5.3 .*proced.ncia.* Interior .* Masc") %>%
  renomeia_coluna("quantidade_procedencia_interior_fem", "5.3 .*proced.ncia.* Interior .* Femi") %>%
  # urbana - RM
  renomeia_coluna("quantidade_procedencia_rmetropolitana_mas", "5.3 .*proced.ncia.* Metropolitanas .* Masc") %>%
  renomeia_coluna("quantidade_procedencia_rmetropolitana_fem", "5.3 .*proced.ncia.* Metropolitanas .* Femi") %>%
  # zona rural
  renomeia_coluna("quantidade_procedencia_rural_mas", "5.3 .*proced.ncia.* rural .* Masc") %>%
  renomeia_coluna("quantidade_procedencia_rural_fem", "5.3 .*proced.ncia.* rural .* Femi") %>%
  ## estado civil
  # solteiro/a
  renomeia_coluna("quantidade_estadocivil_solteiro", "5.4 .* solteiro.*Total") %>%
  # casado/a
  renomeia_coluna("quantidade_estadocivil_casado", "5.4 .* casado.*Total") %>%
  # união estável
  renomeia_coluna("quantidade_estadocivil_unestavel", "5.4 .* uni.o est.vel.*Total") %>%
  # separado/a
  renomeia_coluna("quantidade_estadocivil_separado", "5.4 .* separado.*Total") %>%
  # divorciado/a
  renomeia_coluna("quantidade_estadocivil_divorciado", "5.4 .* divorciado.*Total") %>%
  # viuvo/a
  renomeia_coluna("quantidade_estadocivil_viuvo", "5.4 .* vi.vo.*Total") %>%
  # não informado
  renomeia_coluna("quantidade_estadocivil_naoinformado", "5.4 .* n.o informado.*Total") %>%
  ## pessoas com deficiência
  renomeia_coluna("quantidade_pcd_total", "5.5 .* Total de .* Total") %>%
  renomeia_coluna("quantidade_pcd_total_mas", "5.5 .* Total de .* Masc") %>%
  renomeia_coluna("quantidade_pcd_total_fem", "5.5 .* Total de .* Fem")


# Bloco 5 - perfil criminal -----------------------------------------------

base_2020 <- base_2020 %>%
  renomeia_coluna("existe_registro_incidenciapenal", "5.14 .* registro que permite a obten..o") %>%
  renomeia_coluna("metodologia_registro_incidenciapenal", "5.14 .*como . registrada") %>%
  renomeia_coluna("quantidade_com_informacao_incidencia", "5.* com informa..o sobre tipific.*Total$") %>%
  renomeia_coluna("quantidade_sem_informacao_incidencia", "5.* sem informa..o sobre tipific.*Total$") %>%
  ### código penal
  ## contra a pessoa
  renomeia_coluna("quantidade_incidencia_homicidio_simples", "homic.dio simples .*Total") %>%
  renomeia_coluna("quantidade_incidencia_homicidio_culposo", "homic.*io culposo.*.121.*Total") %>%
  renomeia_coluna("quantidade_incidencia_homicidio_qualificado", "homic.dio qualificado .*Total") %>%
  renomeia_coluna("quantidade_incidencia_homicidio_simples", "homic.dio simples .*Total") %>%
  renomeia_coluna("quantidade_incidencia_aborto", "aborto .*Total") %>%
  renomeia_coluna("quantidade_incidencia_lesaocorporal", "les.o corporal .*Total") %>%
  renomeia_coluna("quantidade_incidencia_violenciadomestica", "viol.ncia dom.stica .*Total") %>%
  renomeia_coluna("quantidade_incidencia_sequestrocarcereprivado", "seq..stro e c.rcere .*Total") %>%
  renomeia_coluna("quantidade_incidencia_outros_contrapessoa", "outros .* artigos 122 .*Total") %>%
  # contra o patrimônio
  renomeia_coluna("quantidade_incidencia_furto_simples", "furto simples .*Total") %>%
  renomeia_coluna("quantidade_incidencia_furto_qualificado", "furto qualificado .*Total") %>%
  renomeia_coluna("quantidade_incidencia_roubo_simples", "roubo simples .*Total") %>%
  renomeia_coluna("quantidade_incidencia_roubo_qualificado", "roubo qualificado .*Total") %>%
  renomeia_coluna("quantidade_incidencia_furto_qualificado", "furto qualificado .*Total") %>%
  renomeia_coluna("quantidade_incidencia_latrocinio", "latroc.nio .*Total") %>%
  renomeia_coluna("quantidade_incidencia_extorsaomedsequestro", "extors.o mediante seq.*Total") %>%
  renomeia_coluna("quantidade_incidencia_extorsao", "extors.o .*Total") %>%
  renomeia_coluna("quantidade_incidencia_apropindebita_previdenciaria", "apropria..o ind.bita previdenci.ria .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_apropindebita", "apropria..o ind.bita .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_estelionato", "estelionato .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_receptacao_qualificada", "recepta..o qualificada .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_receptacao", "recepta..o .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_outros_contrapatrimonio", "outros .* artigos 156 .*Total$") %>%
  # dignidade sexual
  renomeia_coluna("quantidade_incidencia_estupro_vulneravel", "estupro de vulner.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_estupro", "estupro .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_atentadoviolentopudor", "violento ao pudor .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_corrupcaomenores", "corrup..o de menores.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_traficopessoasexploracaosexual_internacional", "tr.fico internacional.*pessoa .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_traficopessoasexploracaosexual_interno", "tr.fico interno.*pessoa .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_outros_dignidadesexual", "outros .artigos 215.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_quadrilha", "quadrilha.*288.*Total$") %>%
  # outros crimes do CP
  renomeia_coluna("quantidade_incidencia_moedafalsa", "moeda falsa.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_falsificacaodocpublicos", "falsifica..o.*p.blicos.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_falisadeideologica", "falsidade ideol.gica.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_usodocfalso", "uso de documento falso.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_peculato", "peculato.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_concussao", "concuss.o e excesso de.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_corrupcao_passiva", "corrup..o passiva.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_corrpcao_ativa", "corrup..o ativa.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_contrabando", "contrabando ou descaminho.*Total$") %>%
  ### leis especiais
  # drogas
  renomeia_coluna("quantidade_incidencia_drogas_trafico_internacional", "tr.fico internacional de drogas .*Total$") %>%
  renomeia_coluna("quantidade_incidencia_drogas_trafico", "tr.fico de drogas \\(art. 12.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_drogas_associacao", "associa..o .*o tr.fico.*Total$") %>%
  # armas
  renomeia_coluna("quantidade_incidencia_armas_usopermitido", "porte.*uso permitido.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_armas_disparo", "disparo de arma.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_armas_usorestrito", "porte.*uso restrito.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_armas_comercioilegal", "com.rcio ilegal.*arma.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_armas_traficointernacional", "tr.fico internacional de arma.*Total$") %>%
  # trânsito
  renomeia_coluna("quantidade_incidencia_transito_homicidioculposo", "homic.dio.*ve.culo.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_transito_outros", "outros.*303.*Total$") %>%
  # legislação específica
  renomeia_coluna("quantidade_incidencia_estatutocriancaadolescente", "estatuto da crian.a.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_contrameioambiente", "contra o meio ambiente.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_genocidio", "genoc.dio.*Total$") %>%
  renomeia_coluna("quantidade_incidencia_tortura", "tortura .*Total$")

