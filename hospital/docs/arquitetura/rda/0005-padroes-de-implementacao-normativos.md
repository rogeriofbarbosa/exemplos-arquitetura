---
status: proposta
date: 2026-11-18
decision-makers: arquitetura do hospital (alçada a confirmar), sobre proposta de Rogério Barbosa
consulted: engenharia e plataforma hospital+ (pendente)
informed: banca da solicitação de arquitetura
---
# RDA-0005: Tornar normativos os padrões de implementação que sustentam as garantias do desenho

**Finalidade:** definir quais padrões de projeto a construção é obrigada a seguir, quais ficam como recomendação e como a esteira verifica o cumprimento.

**Identificador:** RDA-0005
**Sistema / domínio:** Agente de Completude de Normativos e Cadeia de Valor
**Estado:** proposta
**Autores:** Rogério Barbosa (arquiteto, autor da proposta)
**Responsável pela decisão:** arquitetura do hospital (pendente)
**Data da proposta / da decisão:** 2026-11-18 / pendente
**DDA vinculado:** [`../dda/01-agente-de-completude.md`](../dda/01-agente-de-completude.md), §6 (DEC-13, §6.3), §8 (CMP-03 a CMP-05, CMP-08), §10 (DATA-01 a DATA-06), §15, versão 0.2
**Projetos afetados:** API de Completude, orquestrador durável, executores de completude e de consolidação, agente de contexto

## 0. Controle e governança do registro

| Campo | Valor |
|---|---|
| ID e título | RDA-0005: Tornar normativos os padrões de implementação que sustentam as garantias do desenho |
| Categoria | Engenharia / Evolutividade |
| Abrangência | código dos componentes novos (N) do DDA §8; não alcança os componentes da plataforma hospital+ |
| Estado e validade | proposta; 2026-11-18 |
| Decisor com alçada | arquitetura do hospital (pendente) |
| Autores / consultados / discordâncias | Rogério Barbosa / engenharia e plataforma hospital+ (pendente) / nenhuma registrada |
| DDA, especificação, requisito, incidentes associados | DDA §6.3 (PAD-I1 a PAD-I6), DEC-13; [especificação](../../especificacao/pendentes/agente-de-completude-2026-11.md) §3.8, §4.3 e §4.6; RNF-09, RNF-10 |
| Registros relacionados | sustenta as reversibilidades declaradas em [RDA-0001](0001-enumerar-requisitos-pela-base-do-hospital.md), [RDA-0002](0002-fila-na-entrada-e-orquestrador-duravel.md) e [RDA-0004](0004-memoria-do-agente-separada-do-registro.md) |
| Repositório e revisão | originado na revisão 0.2 do DDA (§6.3); não consta de `arquitetura_7.md` |
| Data de reavaliação ou gatilho | definição do runtime dos serviços (Pendente no DDA, CNT-01); resposta a INC-01; fim da Entrega 1 |

### 0.1 Histórico de estados

| Data | Estado anterior e novo | Quem autorizou | Justificativa / referência |
|---|---|---|---|
| 2026-11-18 | proposta registrada como RDA | autor | as diretrizes do DDA §6.3 passam a ter uma decisão própria |

## 1. Declaração objetiva da decisão

**Questão a decidir:** os padrões de implementação do DDA §6.3 devem ser regra verificada pela esteira ou orientação à equipe? Se forem regra, quais deles?

**Decisão proposta:** tornar obrigatórios quatro padrões, cada um verificado por teste automatizado na esteira: Ports and Adapters com Anti-Corruption Layer (PAD-I1), máquina de estados explícita (PAD-I2), tabela de decisão versionada (PAD-I3) e Repository com escrita idempotente (PAD-I5). Chain of Responsibility (PAD-I4) e Value Object (PAD-I6) permanecem como recomendação. A escolha acrescenta indireção ao código do piloto em troca de garantias que deixam de depender de convenção.

## 2. Contexto, problema e forças em conflito

**Situação atual (AS-IS):** N/A, sistema novo e sem código (RES-05). O DDA 0.2 lista seis diretrizes de implementação no §6.3, marcadas como propostas sem evidência.
**Problema ou risco que motiva a escolha:** três RDAs declaram reversibilidades que só valem se o código respeitar uma fronteira: trocar a fonte do universo (RDA-0001, §9), trocar o motor (RDA-0002, §4) e trocar a memória do agente (RDA-0004, §4 e §9). O desenho também promete que nenhuma análise fica presa, que a recomendação vem da regra e que uma activity repetida não duplica nada. Sem regra verificável, essas afirmações dependem de disciplina da equipe e deixam de ser auditáveis. Além disso, a interface da base do hospital é desconhecida (INC-01), e a construção precisa começar antes de conhecê-la.
**Por que decidir agora:** a fronteira entre domínio e infraestrutura é barata de impor no primeiro commit e cara de recuperar depois.
**Forças em conflito:** padrões obrigatórios dão garantias verificáveis, mas custam abstrações num piloto pequeno. Regras demais viram cerimônia e são contornadas. Uma porta desenhada antes de conhecer a dependência pode ter a forma errada.
**Linha de base:** nenhuma; não há código.
**Premissas declaradas:** o orquestrador usa o SDK Python do Durable Task (PRE-10). O runtime da API e dos executores está pendente (DDA, CNT-01), e a ferramenta de teste de arquitetura depende dele. Esta proposta não foi validada com a engenharia que construirá o sistema.
**Fora do escopo:** escolha de linguagem, framework e estrutura de repositórios; padrões internos dos componentes da plataforma hospital+.

## 3. Fatores de decisão, requisitos, restrições e critérios

### 3.1 Critérios verificáveis

| ID | Critério | Natureza | Regra ou métrica de aceite | Importância | Evidência / fonte |
|---|---|---|---|---|---|
| CR-01 | as reversibilidades declaradas nos RDAs são verificáveis por teste, não por convenção | eliminatório | existe teste que falha quando a fronteira é violada | obrigatório | RDA-0001 §9; RDA-0002 §4; RDA-0004 §9 |
| CR-02 | as garantias de estado, regra e idempotência têm teste determinístico, sem chamada de modelo | eliminatório | testes de transição, de tabela da regra e de repetição de activity na esteira | obrigatório | CEN-02; PRI-02; SEC-07 |
| CR-03 | nenhum componente de execução novo nem dependência nova de plataforma | eliminatório | inventário do DDA §8 e §12 inalterado | obrigatório | RES-01 |
| CR-04 | pouco custo de construção no piloto | preferência | número de regras obrigatórias e de abstrações exigidas | alta | julgamento arquitetural |
| CR-05 | a construção avança antes da resposta a INC-01 | preferência | cenários 2 a 4 executam com adaptador substituto da base | alta | INC-01; MIG-02 |
| CR-06 | toda regra obrigatória está ligada a uma garantia que só ela torna verificável | preferência | regra sem garantia associada não entra | média | DDA §6.3 |

**Restrições não negociáveis:** RES-01 (reaproveitar a plataforma); RES-03 (inferência pelo LLM Gateway); RES-05 (sem código nesta entrega).
**Requisitos afetados:** RNF-09, RNF-10; QS-01, QS-02.
**Condições de análise:** piloto com poucos serviços e equipe ainda não definida.

### 3.2 Regra de priorização

Aplicam-se primeiro os critérios eliminatórios. Entre as alternativas aprovadas, CR-04 e CR-06 desempatam.

## 4. Alternativas consideradas

| Alternativa | Descrição / mecanismo | Atende as restrições? | Benefícios | Limitações e riscos | Evidência disponível |
|---|---|---|---|---|---|
| ALT-A | quatro padrões obrigatórios (PAD-I1, I2, I3, I5), cada um com teste na esteira; PAD-I4 e PAD-I6 recomendados | sim | garantias verificáveis com o menor conjunto de regras | indireção no código; portas desenhadas antes de conhecer a base | DDA §6.3 |
| ALT-B | os seis padrões obrigatórios | sim | uniformidade | PAD-I4 e PAD-I6 não têm garantia que só eles tornem verificável; mais cerimônia | - |
| ALT-C | status quo: diretrizes no DDA §6.3, sem verificação | não (CR-01) | nenhum custo inicial | reversibilidades e garantias dependem de convenção | DDA 0.2 |
| ALT-D | Clean Architecture e DDD tático completos em todos os serviços (camadas, agregados, eventos de domínio) | sim | modelo de domínio rico | custo desproporcional ao piloto; a maior parte da lógica é sequência e regra, não modelo de domínio complexo | - |
| ALT-E | usar diretamente no domínio os tipos dos SDKs (Haystack, LangChain, cliente da base, Durable Task) | não (CR-01) | menos código | toda troca de fornecedor atravessa o domínio; a construção fica bloqueada por INC-01 | - |

**Descartadas antes da comparação:** ALT-C e ALT-E, por critério eliminatório.
**Incertezas não resolvidas:** runtime dos serviços; interface da base (INC-01); opinião da engenharia.
**Dependência de fornecedor e reversibilidade:** a decisão reduz a dependência de fornecedor no código. Retirar uma regra exige apenas remover o teste correspondente.

## 5. Comparação das alternativas

| Critério | ALT-A | ALT-B | ALT-D | Fundamentação e grau de confiança |
|---|---|---|---|---|
| CR-01 (eliminatório) | atende | atende | atende | teste de arquitetura sobre a fronteira; alto |
| CR-02 (eliminatório) | atende | atende | atende | testes determinísticos; alto |
| CR-03 (eliminatório) | atende | atende | atende | só estrutura de código; alto |
| CR-04 | melhor | similar | pior | número de regras e abstrações; médio |
| CR-05 | atende | atende | atende | adaptador substituto atrás da porta; alto |
| CR-06 | melhor | pior | pior | PAD-I4 e PAD-I6 não passam; julgamento arquitetural; médio |
| Reversibilidade | alta | alta | baixa | - |

**Análise crítica:** ALT-A e ALT-B diferem em dois padrões. A garantia por trás de PAD-I4 é que cada proibição seja um validador testável em separado, e isso pode ser atendido sem a forma de cadeia. PAD-I6 melhora a clareza do código, mas nenhuma garantia do desenho depende dele. Torná-los obrigatórios cria regra sem contrapartida verificável. ALT-D resolve um problema que o sistema não tem.
**Teste de sensibilidade:** se a equipe for grande ou distribuída entre fornecedores, a uniformidade de ALT-B ganha valor. Se o piloto for descartável e não evoluir para produção, ALT-C volta a ser defensável.
**Validade da comparação:** 2026-11-18, DDA 0.2.

## 6. Decisão e justificativa

**Opção selecionada:** ALT-A.
**Formulação normativa:**

1. **Fronteiras (PAD-I1).** O código de domínio da API e dos executores não deve importar SDK da base do hospital, do RAG, do gateway, da memória do agente, do Service Bus nem do motor. Cada dependência externa tem uma porta definida pela necessidade do domínio, um adaptador e um teste de contrato. O adaptador da base do hospital atua como Anti-Corruption Layer: traduz o modelo da base para a referência de requisito do domínio (identificador, versão, início de vigência), e CMP-04 e CMP-05 usam a mesma porta.
2. **Motor (PAD-I1, caso particular).** O código do orquestrador é o adaptador do motor e não fica atrás de uma porta. Ele deve conter apenas sequência, prazos, slots e fan-in. Nenhuma regra de domínio fica no orquestrador, e os executores não conhecem o motor.
3. **Estados (PAD-I2).** As transições de estado e de etapa da análise ficam em uma tabela única e versionada. `SetState` rejeita transição que não esteja na tabela, e estado final não tem saída.
4. **Regra de recomendação (PAD-I3).** A regra é uma tabela de decisão versionada. Cada linha tem um identificador, gravado no item. A tabela deve ser exaustiva e exclusiva: toda combinação de entradas corresponde a exatamente uma linha.
5. **Gravações (PAD-I5).** Toda gravação no PostgreSQL passa por um repositório cuja operação é idempotente pela chave única da especificação §4.3.
6. **Recomendações.** Validadores independentes, um por proibição (PAD-I4), e objetos de valor imutáveis para citação e versão de requisito (PAD-I6) são recomendados, sem verificação obrigatória.

**Justificativa principal:** é o menor conjunto de regras que atende CR-01 e CR-02 e em que toda regra tem uma garantia associada (CR-06).
**Alternativas descartadas:** ALT-B inclui regras sem garantia verificável. ALT-C e ALT-E falham em CR-01. ALT-D custa mais do que o piloto justifica.
**Condições de aceitação:** TST-01 a TST-05; parecer da engenharia.
**Data efetiva:** após o aceite, a partir do primeiro commit da Entrega 1.
**Limites:** não define linguagem, framework, estrutura de pastas nem a ferramenta de teste de arquitetura.

## 7. Como a decisão altera o desenho

| Aspecto | Mudança resultante | Artefato a alterar | Responsável |
|---|---|---|---|
| Componentes e fronteiras | nenhum contêiner novo; dentro de cada serviço, domínio separado dos adaptadores | DDA §6.3, §8.2 | arquiteto |
| Dados e consistência | sem mudança de modelo; a escrita passa por repositórios idempotentes | DDA §10 | arquiteto |
| Contratos e eventos | sem mudança; cada adaptador ganha um teste de contrato | DDA §11, §15 | arquiteto |
| Plataforma e operação | a esteira ganha testes de arquitetura, de transições, da tabela da regra e de repetição | DDA §15 | engenharia |
| Segurança e privacidade | sem mudança | - | - |

**Restrições de implementação:** as portas são definidas pelo que o domínio precisa (por exemplo, listar os requisitos de um referencial vigentes numa data e ler um requisito, conforme PRE-01), e não pela interface do fornecedor.

### 7.1 Padrões aplicados

| Padrão | Situação | Garantia do desenho que torna verificável |
|---|---|---|
| Ports and Adapters, com Anti-Corruption Layer na base do hospital (PAD-I1) | obrigatório | reversibilidades do RDA-0001 e do RDA-0004; construção independente de INC-01 |
| Orquestrador como adaptador do motor (PAD-I1, caso particular) | obrigatório | troca do motor preserva os executores (RDA-0002, ALT-F) |
| State, como máquina de estados explícita (PAD-I2) | obrigatório | nenhuma análise presa (CEN-02) |
| Tabela de decisão versionada, com Specification por linha (PAD-I3) | obrigatório | a recomendação vem da regra, e o item registra qual (PRI-02, DEC-07) |
| Repository com escrita idempotente (PAD-I5) | obrigatório | activity repetida não duplica item nem resultado (SEC-07) |
| Chain of Responsibility (PAD-I4) | recomendado | - |
| Value Object (PAD-I6) | recomendado | - |

Os identificadores PAD remetem ao catálogo do [DDA §6.1 a §6.3](../dda/01-agente-de-completude.md), que traz as fontes na §22.5.

## 8. Consequências

### 8.1 Benefícios esperados

- As reversibilidades declaradas nos RDAs 0001, 0002 e 0004 passam a ter um teste que as comprova.
- A construção dos cenários 2 a 4 pode começar com um adaptador substituto da base, antes da resposta a INC-01.
- Estado, regra de recomendação e idempotência são testados sem chamada de modelo.

### 8.2 Custos e consequências negativas assumidas

- Mais indireção e mais código no piloto: uma porta, um adaptador e um teste de contrato por dependência externa.
- A porta do RAG tende a vazar detalhes (filtros, busca híbrida, reranking). A abstração vale para trocar a implementação do mesmo serviço, não para trocar de produto sem esforço.
- O orquestrador continua acoplado ao SDK do motor. Trocar o motor exige reescrevê-lo; a regra só garante que essa reescrita não alcance os executores.
- Um adaptador substituto pode esconder defeitos de integração até a homologação.

### 8.3 Outras consequências e obrigações

- Os testes de contrato dos adaptadores devem rodar também contra a dependência real em homologação.
- A ferramenta de teste de arquitetura precisa ser escolhida com o runtime.

## 9. Riscos, controles, reversibilidade e exceções

| ID | Risco / modo de falha | Probabilidade / impacto | Mitigação e teste | Risco residual / quem aceita | Gatilho |
|---|---|---|---|---|---|
| AR-01 | porta da base desenhada com a forma errada, por INC-01 | média / médio | porta definida por PRE-01, não pela interface do fornecedor; revisão após VAL-02 | retrabalho no adaptador e na porta / arquiteto | resposta a INC-01 |
| AR-02 | regras contornadas sob pressão de prazo | média / médio | testes bloqueiam a esteira; exceção só registrada aqui | - | teste desativado |
| AR-03 | adaptador substituto diverge da dependência real | média / médio | teste de contrato único, executado contra o substituto e contra o real | defeito tardio / engenharia | falha em homologação |
| AR-04 | excesso de abstração atrasa o piloto | baixa / médio | só quatro regras obrigatórias; revisão no fim da Entrega 1 | - | atraso atribuído às regras |

**Raio de impacto:** o código dos componentes novos; nenhum efeito em execução.
**Reversibilidade:** alta. Cada regra pode ser rebaixada a recomendação com a retirada do teste.
**Condições de revogação:** parecer contrário da engenharia com alternativa que atenda CR-01 e CR-02.

## 10. Plano de validação e critérios de comprovação

| ID | Hipótese decisiva | Experimento / verificação | Critério de sucesso | Evidência | Estado / prazo |
|---|---|---|---|---|---|
| TST-01 | a fronteira é verificável | inserir no domínio um import de SDK de fornecedor | a esteira falha | execução da esteira | pendente / Entrega 1 |
| TST-02 | a troca de adaptador não alcança o domínio | executar os cenários 2 a 4 com adaptador substituto da base e depois com o real | nenhuma alteração no código de domínio entre as duas execuções | diff e resultados | pendente / Entrega 3 |
| TST-03 | nenhuma transição inválida | percorrer todos os pares de estados contra a tabela | só as transições da tabela são aceitas; estado final sem saída | relatório do teste | pendente / Entrega 3 |
| TST-04 | a tabela da regra é exaustiva e exclusiva | gerar todas as combinações de classificação e condição de datas | cada combinação casa com exatamente uma linha | relatório do teste | pendente / Entrega 3 |
| TST-05 | gravações idempotentes | repetir cada activity que grava | mesmo estado no banco após a repetição | banco; TST-04 do RDA-0002 | pendente / Entrega 3 |

**Confirmação contínua:** TST-01, TST-03, TST-04 e TST-05 rodam em toda mudança. O orquestrador é inspecionado para confirmar a ausência de regra de domínio, junto com a verificação de ausência de I/O já prevista no RDA-0002.

## 11. Migração, entrega, rollback e execução

**Impacto no legado e compatibilidade:** N/A, sistema novo.
**Critérios de go/no-go:** TST-01 aprovado antes do primeiro executor.
**Rollback ou correção para a frente:** rebaixar a regra a recomendação e registrar o motivo neste RDA.

| Etapa | Entrega | Dependência | Evidência de conclusão | Responsável / prazo |
|---|---|---|---|---|
| IMP-01 | esqueleto dos serviços com portas, adaptadores e teste de arquitetura | runtime definido | TST-01 | engenharia e arquiteto / Entrega 1 |
| IMP-02 | adaptador da base do hospital e seu teste de contrato | INC-01; RDA-0001 IMP-01 | TST-02 | hospital e arquiteto / Entrega 2 |
| IMP-03 | tabela de transições, tabela da regra e repositórios | IMP-01 | TST-03 a TST-05 | arquiteto / Entrega 3 |

## 12. Responsabilidades, consultas e decisão formal

| Participante | Papel no processo | Posição / parecer | Data / link |
|---|---|---|---|
| Rogério Barbosa | autor / recomendação | ALT-A | 2026-11-18 |
| engenharia | consultado | pendente | - |
| plataforma hospital+ | consultado | pendente | - |
| arquitetura do hospital | decisor com alçada | pendente | - |

**Dissenso registrado:** nenhum.
**Exceções concedidas:** nenhuma.

## 13. Dependências, rastreabilidade e revisão

**Depende de:** PRE-01, PRE-10; RDA-0001, RDA-0002 e RDA-0004 (reversibilidades que esta decisão sustenta).
**Contradiz ou substitui:** nenhum registro. Altera a situação das diretrizes do DDA §6.3, que deixam de ser apenas propostas.
**DDA afetado:** §6 (DEC-13, §6.3), §15, §20.1, versão 0.2.
**Requisitos e riscos afetados:** RNF-09, RNF-10; RIS-01 (o adaptador substituto reduz o bloqueio por INC-01, sem resolver o risco).
**Monitoramento da hipótese após a adoção:** testes desativados ou exceções concedidas; responsável: arquiteto.
**Revisão planejada:** fim da Entrega 1.
**Gatilhos para novo RDA:** troca de runtime; adoção de DDD tático completo; inclusão de PAD-I4 ou PAD-I6 entre as regras obrigatórias.

## 14. Checklist de qualidade

- [x] Uma única decisão significativa, expressa objetivamente.
- [x] Contexto, problema, urgência, alternativas e status quo descritos.
- [x] Critérios eliminatórios separados das preferências.
- [x] Métricas, premissas, trade-offs e fontes explícitos.
- [x] Benefícios e consequências negativas assumidos sem omissão relevante.
- [x] Comparação que não mascara incerteza com pontuação arbitrária.
- [ ] Responsáveis, alçada, estado e data de efetividade (decisor e parecer da engenharia pendentes).
- [x] Limites, riscos, migração, rollback e reversibilidade descritos.
- [x] Plano de verificação e links de evidência.
- [x] DDA e registros relacionados atualizados.
- [x] Política de reavaliação e de substituição histórica.

## 15. Referências

- DDA, §6.3 e §22.5: [`../dda/01-agente-de-completude.md`](../dda/01-agente-de-completude.md).
- Alistair Cockburn, Hexagonal Architecture (Ports and Adapters): https://alistair.cockburn.us/hexagonal-architecture/
- Microsoft, Anti-Corruption Layer pattern: https://learn.microsoft.com/en-us/azure/architecture/patterns/anti-corruption-layer
- Martin Fowler, Repository: https://martinfowler.com/eaaCatalog/repository.html
- Eric Evans, *Domain-Driven Design*, Addison-Wesley, 2003 (Anti-Corruption Layer, Repository, Specification, Value Object).
- Erich Gamma, Richard Helm, Ralph Johnson e John Vlissides (GoF), *Design Patterns*, Addison-Wesley, 1994 (State, Chain of Responsibility).
- Michael Nygard, "Documenting Architecture Decisions": https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions
- MADR 4.0.0: https://adr.github.io/madr/
