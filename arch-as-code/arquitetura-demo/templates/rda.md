---
status: proposta
date: AAAA-MM-DD
decision-makers: quem decide, com alçada
consulted: quem foi consultado antes da decisão
informed: quem precisa saber depois
---
# RDA-NNNN: título declarativo (verbo + escolha + contexto)

> **Modelo de Registro de Decisão de Arquitetura (RDA, o ADR em português), versão 2.0 (outubro de 2026).**
> Ampliado a partir de Nygard e MADR, com convenções próprias.
> Copie este arquivo para `../rda/NNNN-titulo-curto.md` (quatro dígitos, o próximo número
> livre) e apague este bloco de instruções.
>
> O bloco de metadados no topo é lido pelo Structurizr (importador `madr`) e alimenta o
> índice do `README.md`: `status` e `date` são obrigatórios. Estados: `proposta`,
> `em avaliação`, `aceita`, `rejeitada`, `descontinuada`, `substituída por RDA-NNNN`. Mudou o estado,
> edita o bloco e o histórico da §0.1 na MESMA mudança. Sem travessão à inglesa: vírgula,
> dois-pontos ou parênteses.

**Finalidade:** registrar uma decisão arquitetural significativa, seu contexto temporal, as alternativas, os critérios, as evidências, as consequências e a responsabilidade. O registro preserva a justificativa histórica; não é propaganda da opção escolhida.

**Identificador:** RDA-NNNN
**Sistema / domínio:** nome do sistema (ou o subsistema)
**Estado:** o mesmo do bloco de metadados
**Autores:** nomes e papéis
**Responsável pela decisão:** nome ou instância com alçada
**Data da proposta / da decisão:** AAAA-MM-DD / AAAA-MM-DD
**DDA vinculado:** `../dda/01-plataforma-exemplo.md`, seção e versão
**Projetos afetados:** os repositórios ou pastas que a decisão toca

## Guia rápido e convenções

- **Um RDA, uma decisão coesa.** Decisões independentes são registros distintos, com vínculos explícitos.
- **Registro aceito se preserva.** Se a decisão mudar materialmente, crie um RDA novo e marque o anterior como substituído; não reescreva a história.
- **Rejeitada** documenta uma proposta rejeitada; alternativa descartada durante a análise não precisa virar RDA próprio.
- Distinga decisão, hipótese ainda não comprovada, implementação já feita e condição de aprovação.
- **Evidência é verificável:** teste, medição, custo estimado, parecer, protótipo, contrato, arquivo e linha. Opinião se rotula como julgamento arquitetural.
- Não faça pontuação numérica parecer objetiva sem fonte, critério verificável e teste de sensibilidade. Restrição eliminatória prevalece sobre média ponderada.
- **Não inferir:** nada aqui se deduz; o que não foi verificado se declara como premissa não verificada.

## 0. Controle e governança do registro

| Campo | Valor |
|---|---|
| ID e título | RDA-NNNN: ... |
| Categoria | Dados / Integração / Segurança / Plataforma / IA / Observabilidade / Documentação / Outros |
| Abrangência | sistema, domínios, projetos e ambientes |
| Estado e validade | estado; data |
| Decisor com alçada | quem pode aprovar |
| Autores / consultados / discordâncias | pessoas e pareceres |
| DDA, especificação, requisito, incidentes associados | links e IDs |
| Registros relacionados | depende de / bloqueia / substitui / é substituído por |
| Repositório e revisão | branch, commit, data de revisão |
| Data de reavaliação ou gatilho | mudança de carga, fornecedor, orçamento, norma ou incidente |

### 0.1 Histórico de estados

| Data | Estado anterior e novo | Quem autorizou | Justificativa / referência |
|---|---|---|---|
| AAAA-MM-DD | rascunho para proposta | | commit, ata |
| AAAA-MM-DD | proposta para aceita | | evidência, condicionantes |

## 1. Declaração objetiva da decisão

**Questão a decidir:** em forma de pergunta, com as opções viáveis.
**Decisão em uma frase:** adotar X no contexto Y para atingir Z, aceitando o trade-off W.
**Estado da frase:** proposta enquanto não aprovada; decisão efetiva após o aceite.

O resumo deve ser inteligível sem conhecer fornecedores. Evite "usar a tecnologia X" sem contexto, objetivo e renúncia.

## 2. Contexto, problema e forças em conflito

**Situação atual (AS-IS):** componentes afetados, comportamentos, indicadores e falhas, com a prova (arquivo e linha, migration, log, medição).
**Problema ou risco que motiva a escolha:** efeito no usuário, custo, risco, prazo ou operação.
**Por que decidir agora:** marco, incidente, obrigação, escala, risco de postergar.
**Forças em conflito:** por exemplo consistência contra disponibilidade; custo contra reversibilidade; prazo contra autonomia.
**Linha de base:** métricas atuais, se existirem; não inventar números.
**Premissas declaradas:** o que se assume e ainda não se provou.
**Não-objetivos:** o que fica explicitamente fora da decisão.

## 3. Fatores de decisão, requisitos, restrições e critérios

### 3.1 Critérios verificáveis

| ID | Critério | Natureza | Regra ou métrica de aceite | Importância | Evidência / fonte |
|---|---|---|---|---|---|
| CR-01 | | eliminatório | | obrigatório | |
| CR-02 | | preferência | | alta | |

**Restrições não negociáveis:** norma, segurança, localidade de dados, contrato, interoperabilidade, licença, SLA.
**Requisitos afetados:** RF-xx, RNF-xx, SEC-xx, com link ao DDA.
**Condições de análise:** carga, perfil de tráfego, janela, premissas técnicas, ambientes.

### 3.2 Regra de priorização

Pesos só se fizerem sentido, com quem os aprovou e como foram calibrados. Critérios de veto ficam separados. Pesos não substituem experimento; registre a sensibilidade a mudanças de estimativa.

## 4. Alternativas consideradas, inclusive o status quo

| Alternativa | Descrição / mecanismo | Atende as restrições? | Benefícios | Limitações e riscos | Evidência disponível |
|---|---|---|---|---|---|
| ALT-A | opção escolhida | sim / não / pendente | | | |
| ALT-B | outra opção viável | | | | |
| ALT-C | manter como está ou adiar | | | | |

**Descartadas antes da comparação:** motivo objetivo; se violou critério obrigatório, qual.
**Incertezas não resolvidas:** o que exige prova de conceito e o efeito sobre a decisão.
**Dependência de fornecedor e reversibilidade:** esforço e custo estimado de migrar para outra opção.

## 5. Matriz comparativa e análise de trade-offs

| Critério | ALT-A | ALT-B | ALT-C | Fundamentação e grau de confiança |
|---|---|---|---|---|
| CR-01 (eliminatório) | atende / falha | | | teste ou contrato; alto / médio / baixo |
| CR-02 | melhor / similar / pior / incerto | | | |
| Reversibilidade | | | | complexidade de migração |

**Análise crítica:** dominância, compensações, custos ocultos, riscos de longo prazo e o desempate.
**Teste de sensibilidade:** o vencedor se mantém se carga, preço, prazo e maturidade mudarem?
**Validade da comparação:** data, versões e escopo.

## 6. Decisão e justificativa

**Opção selecionada:** ALT-X.
**Formulação normativa:** "Para [contexto], adotamos [decisão] em [fronteira], visando [qualidade], aceitando [consequência negativa]."
**Justificativa principal:** vinculada aos critérios CR-xx e às evidências.
**Por que não as alternativas:** motivo explícito e verificável por alternativa.
**Condições de aceitação:** prova de conceito, teste ou custo máximo antes de expandir.
**Data efetiva:** quando passa a orientar a arquitetura.
**Limites:** o que a decisão NÃO determina.

## 7. Como a decisão altera o desenho

| Aspecto | Mudança resultante | Artefato a alterar | Responsável |
|---|---|---|---|
| Componentes e fronteiras | | DDA §8, `workspace.dsl` | |
| Dados e consistência | | DDA §10, schema, migration | |
| Contratos e eventos | | DDA §11, OpenAPI | |
| Plataforma e operação | | DDA §12 a §14, infra, runbook | |
| Segurança e privacidade | | DDA §13 | |

**Diagrama antes e depois:** link, quando houver.
**Restrições de implementação:** padrão de API, schema, retenção, isolamento, timeout, fallback.

## 8. Consequências

### 8.1 Benefícios esperados

- Benefício, métrica associada e premissa explicitada.

### 8.2 Custos e consequências negativas assumidas

- Componente novo, equipe, latência, complexidade, dependência de fornecedor; quem carrega.

### 8.3 Consequências neutras, obrigações novas e efeitos de segunda ordem

- Documentação, governança, contratos, capacitação, decisões futuras.

## 9. Riscos, controles, reversibilidade e exceções

| ID | Risco / modo de falha | Probabilidade / impacto | Mitigação e teste | Risco residual / quem aceita | Gatilho |
|---|---|---|---|---|---|
| AR-01 | | | | | |

**Raio de impacto:** serviços, consumidores e dados afetados se a decisão falhar.
**Reversibilidade:** custo, prazo, pré-requisitos, compatibilidade de dados e ponto sem retorno.
**Condições de revogação:** violação de SLO, custo, vulnerabilidade, regra externa, capacidade de equipe.

## 10. Plano de validação e critérios de comprovação

| ID | Hipótese decisiva | Experimento / verificação | Critério de sucesso | Evidência | Estado / prazo |
|---|---|---|---|---|---|
| TST-01 | | | | | pendente |

**Confirmação contínua:** como provar, no código ou no banco, que a decisão continua valendo: comando, arquivo e linha, teste que falharia se alguém a desfizesse. É o que impede a decisão de envelhecer em silêncio.

Distinga prova de conceito (sustenta a escolha), verificação de implementação (confirma a construção) e validação operacional (comprova em produção). Decisão aprovada não é arquitetura validada em produção.

## 11. Migração, entrega, rollback e execução

**Impacto no legado e compatibilidade:** dependências e consumidores afetados.
**Passos de execução:** tarefas, responsáveis, datas, links.
**Entrega progressiva:** flags, canário, dupla escrita ou sombra; riscos específicos.
**Dados e reconciliação:** migração, backfill e verificação.
**Critérios de go/no-go:** condições observáveis e autoridade.
**Rollback ou correção para a frente:** o que é possível e o que impede; não prometer rollback impossível.
**Desativação do mecanismo antigo:** quando, como e com que evidência.

| Etapa | Entrega | Dependência | Evidência de conclusão | Responsável / prazo |
|---|---|---|---|---|
| IMP-01 | | | | |

## 12. Responsabilidades, consultas e decisão formal

| Participante | Papel no processo | Posição / parecer | Data / link |
|---|---|---|---|
| | autor / recomendação | | |
| | consultado | | |
| | decisor com alçada | aceita / rejeitada / condicionada | |

**Dissenso registrado:** ressalvas relevantes; não apague desacordo técnico.
**Exceções concedidas:** motivo, aprovador, controles compensatórios e validade.

## 13. Dependências, rastreabilidade e revisão

**Depende de:** RDA-NNNN, padrão, contrato.
**Contradiz ou substitui:** ID e motivo.
**DDA afetado:** seção e versão.
**Requisitos e riscos afetados:** RF, RNF, SEC, RIS.
**Código, commits, infra, API e painéis:** links.
**Monitoramento da hipótese após a adoção:** métricas e responsável.
**Revisão planejada:** data ou marco.
**Gatilhos para novo RDA:** escala, norma, custo, tecnologia, incidente recorrente.

## 14. Checklist de qualidade

- [ ] Uma única decisão significativa, expressa objetivamente.
- [ ] Contexto, problema, urgência, alternativas e status quo descritos.
- [ ] Critérios eliminatórios separados das preferências.
- [ ] Métricas, premissas, trade-offs e fontes explícitos.
- [ ] Benefícios e consequências negativas assumidos sem omissão relevante.
- [ ] Comparação que não mascara incerteza com pontuação arbitrária.
- [ ] Responsáveis, alçada, estado e data de efetividade.
- [ ] Limites, riscos, migração, rollback e reversibilidade descritos.
- [ ] Plano de verificação e links de evidência.
- [ ] DDA e registros relacionados atualizados ou com tarefa atribuída.
- [ ] Política de reavaliação e de substituição histórica.

## 15. Referências

- Michael Nygard, "Documenting Architecture Decisions" (2011): https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions
- Repositório de modelos de ADR, com o modelo de Nygard: https://github.com/architecture-decision-record/architecture-decision-record
- MADR 4.0.0, opções, resultado e confirmação: https://adr.github.io/madr/
- arc42, seção 9, decisões de arquitetura: https://arc42.org/overview/
- ISO/IEC/IEEE 42010:2022, descrição de arquitetura: https://www.iso.org/standard/74393.html
- Exemplo preenchido: `../rda/0001-documentacao-de-arquitetura-como-codigo.md`.

**Governança:** todo RDA é versionado neste repositório, revisado antes do merge, vinculado ao DDA e mantido como histórico. Aprovado significa decisão autorizada; implementado e validado são estados distintos, provados por evidência.
