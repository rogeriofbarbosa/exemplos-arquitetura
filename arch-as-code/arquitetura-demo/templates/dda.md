# DDA: Documento de Descrição da Arquitetura de NOME DO SISTEMA

> **Estado:** 🔴 **RASCUNHO** | 🟡 **PARCIAL** | 🟢 **VIGENTE**. A pasta classifica o CÓDIGO, não a produção.
>
> **Evidência:** quando foi escrito, lendo o quê (branch e commit de cada projeto). **Produção não foi lida**, salvo se dito aqui com a consulta que o leu.
>
> **Falta:** o que ainda não está descrito, por seção, com responsável e prazo.
>
> Índice da coleção: `../README.md` (link relativo quando copiar).

**Data:** AAAA-MM-DD · **Responsável:** nome (redação assistida por quem)
**Projetos afetados:** os que o documento descreve.

> **Modelo de DDA, versão 2.0 (outubro de 2026).** Adaptação prática da ISO/IEC/IEEE 42010:2022, do arc42 e do C4, com convenções próprias. Não é declaração de conformidade normativa. Este arquivo vive em `dda/` e é importado pelo Structurizr: só Markdown nesta pasta, sem README. Diagramas entram como imagem SVG gerada, por caminho relativo dentro de `dda/`; a sintaxe `embed:` do Structurizr não se usa, porque fora dele vira imagem quebrada. Sem travessão à inglesa: vírgula, dois-pontos ou parênteses.
>
> **Como usar:** substitua os campos por dados objetivos. Não apague seção crítica por estar incompleta: registre **Pendente**, responsável e prazo. Use **N/A com justificativa** quando não se aplicar. Diagrama sem legenda, escopo, versão, autor e identificador não é evidência. Diferencie AS-IS, TO-BE e transição. Vincule cada afirmação decisiva a requisito, evidência, contrato, teste, código, painel ou RDA. Segredo nunca entra aqui. Valor exemplificativo não é requisito.

## Como ler este documento

| Parte | Para quem | Conteúdo |
|---|---|---|
| 0 a 2 | quem decide | controle, resumo, escopo, partes interessadas |
| 3 a 6 | quem especifica | requisitos, atributos de qualidade, restrições, estratégia |
| 7 a 12 | quem constrói e opera | visões de contexto, estrutura, execução, dados, integrações, implantação |
| 13 a 19 | quem opera, protege e audita | segurança, resiliência, entrega, validação, custos, riscos, migração |
| 20 a 22 | quem revisa | viewpoints, rastreabilidade, glossário e anexos |

## 0. Controle documental e governança

### 0.1 Identificação e ciclo de vida

| Campo | Preenchimento |
|---|---|
| ID do DDA / sistema / domínio | |
| Sistema de interesse | nome, finalidade e limites |
| Etapa | descoberta / desenho / construção / operação / desativação |
| Linha de base descrita | AS-IS v... / TO-BE v... / data de corte |
| Dono do produto e arquiteto responsável | |
| Operação, segurança, privacidade | |
| Versão e estado do documento | |
| Repositórios e artefatos oficiais | fonte, diagramas, APIs, infra, RDAs, runbooks |
| Próxima revisão e gatilhos | data / incidente / mudança estrutural / integração nova |
| Classificação e controle de acesso | nível, grupos, retenção |

### 0.2 Histórico de versões

| Versão | Data | Autor | Alterações | Revisão / aprovação |
|---|---|---|---|---|
| 0.1 | | | estrutura inicial | pendente |

### 0.3 Revisores e aprovações

| Papel | Pessoa / grupo | Responsabilidade | Parecer / data |
|---|---|---|---|
| Arquiteto responsável | | consistência técnica e decisões | |
| Engenharia / plataforma | | viabilidade de entrega e operação | |
| Segurança e privacidade | | controles e riscos | |
| Dono do produto | | escopo, resultados e trade-offs | |
| Operação | | observabilidade, suporte e continuidade | |

**Critério de aprovação:** política, quórum, instância, condições e exceções. Assinatura não substitui teste nem análise de risco.

## 1. Resumo executivo e objetivos

### 1.1 Problema de negócio e resultado esperado

**Problema:** necessidade, impacto, pessoas afetadas, por que mudar.
**Resultado esperado:** indicadores de resultado, não só a entrega.
**Hipótese de valor:** o que muda se a arquitetura funcionar.
**Principais restrições:** prazo, orçamento, norma, legado, competências, fornecedor.

### 1.2 Síntese da solução

Um ou dois parágrafos: estilo predominante, limites de domínio, capacidades, armazenamento, integrações, operação e perfil de risco. AS-IS ou TO-BE.

### 1.3 Resumo de decisões e pontos de atenção

| Item | Síntese | Rastreabilidade |
|---|---|---|
| Decisão estrutural central | | RDA-NNNN |
| Trade-off de maior impacto | | RDA-NNNN |
| Risco não resolvido | | RIS-NN |
| Condição para produção | | VAL-NN |

## 2. Sistema de interesse, escopo e contexto organizacional

### 2.1 Fronteira de escopo

**Incluído:** · **Excluído:** · **Fronteiras de responsabilidade:** o que a equipe opera e o que é serviço gerenciado. · **AS-IS para TO-BE:** mudanças e motivação.

### 2.2 Premissas, dependências e incógnitas

| ID | Tipo | Descrição | Evidência / hipótese | Impacto se falsa | Responsável e validação |
|---|---|---|---|---|---|
| PRE-01 | premissa | | | | |
| DEP-01 | dependência | | | | |
| INC-01 | incógnita | | | | |

### 2.3 Partes interessadas e preocupações

| Parte interessada | Preocupação / pergunta decisiva | Visão que responde | Critério de satisfação |
|---|---|---|---|
| | | | |

### 2.4 Vocabulário e domínios

Termos essenciais, contextos delimitados, capacidades, sistemas de registro e palavras ambíguas; glossário na §22.

## 3. Requisitos arquiteturalmente significativos

### 3.1 Capacidades e requisitos funcionais críticos

| ID | Capacidade / caso de uso | Prioridade | Origem | Componentes | Evidência de aceite |
|---|---|---|---|---|---|
| RF-01 | | | | CNT-NN | |

Referencie o backlog em vez de transcrevê-lo; aqui só o que dirige decisão arquitetural.

### 3.2 Jornadas e cenários críticos

| ID | Gatilho | Pré-condição | Passos essenciais | Resultado / falha esperada | Rastreio |
|---|---|---|---|---|---|
| CEN-01 | | | | | RF-NN / DIN-NN |

## 4. Atributos de qualidade e requisitos não funcionais

### 4.1 Catálogo de metas mensuráveis

| ID | Atributo | Meta verificável | Escopo / condições | Método e evidência | Responsável |
|---|---|---|---|---|---|
| RNF-01 | latência | | | | |
| RNF-02 | disponibilidade | | | | |
| RNF-03 | recuperação (RTO, RPO) | | | | |
| RNF-04 | segurança | | | | |
| RNF-05 | privacidade | | | | |
| RNF-06 | escalabilidade | | | | |
| RNF-07 | observabilidade | | | | |
| RNF-08 | custo | | | | |
| RNF-09 | evolutividade | | | | |

Metas derivam de criticidade, contrato e impacto real; número ilustrativo não vira SLA. Referência taxonômica: ISO/IEC 25010:2023.

### 4.2 Cenários de qualidade

| Elemento | Preencher por cenário |
|---|---|
| ID / atributo | |
| Fonte e estímulo | |
| Ambiente e artefato | |
| Resposta esperada | |
| Medida de resposta | |
| Evidência | |

## 5. Restrições, princípios e critérios de desenho

| ID | Restrição ou princípio | Fonte / justificativa | Tipo | Implicação / exceção |
|---|---|---|---|---|
| RES-01 | | | obrigatório | |
| PRI-01 | | | princípio | |

Distinga obrigação legal, contratual, padrão interno e preferência; diga quem concede exceção e por quanto tempo.

## 6. Estratégia arquitetural e decisões estruturantes

**Estilo / composição:** · **Particionamento do domínio:** · **Comunicação:** · **Consistência e transações:** · **Trade-offs reconhecidos:**

| Decisão | Alternativas | Decisão vigente | Impacto no DDA | RDA |
|---|---|---|---|---|
| DEC-01 | | | | RDA-NNNN |

Síntese e vínculo; a análise mora no RDA.

## 7. Visão de contexto (C4, nível 1)

**Objetivo:** sistema de interesse, atores e sistemas externos. **Artefato:** imagem, fonte e data. **Perspectiva:** AS-IS / TO-BE.

| ID | Elemento externo | Papel | Dados trocados | Protocolo | Dono / SLA | Limite de confiança |
|---|---|---|---|---|---|---|
| EXT-01 | | | | | | |

**Perguntas de revisão:** atores não humanos, usuários administrativos, legados, fluxos sensíveis e terceiros estão representados? Alguma integração "interna" cruza fronteira jurídica ou de segurança?

## 8. Visão estrutural (C4, níveis 2 e 3)

### 8.1 Contêineres de software

| ID | Contêiner | Responsabilidade / domínio | Tecnologia | Interfaces | Dados próprios | Código |
|---|---|---|---|---|---|---|
| CNT-01 | | | | API-NN | | |

### 8.2 Componentes internos relevantes

| ID | Contêiner | Componente | Responsabilidade | Dependências permitidas | Testes / contrato |
|---|---|---|---|---|---|
| CMP-01 | CNT-NN | | | | |

Nomes e IDs iguais nos diagramas, no inventário, nos contratos e no código.

## 9. Visões de execução, estados e concorrência

### 9.1 Catálogo de cenários dinâmicos

| ID | Cenário | Tipo de fluxo | Diagrama | RF / RNF | Situação excepcional |
|---|---|---|---|---|---|
| DIN-01 | | | | | |

### 9.2 Especificação de uma interação crítica

Pré-condição e identidade; passos em ordem; limites transacionais; timeout; concorrência e idempotência; estados e compensações; telemetria.

## 10. Arquitetura de dados e governança da informação

### 10.1 Modelo e propriedade dos dados

| ID | Entidade / conjunto | Sistema de registro | Classificação | Proprietário | Retenção | Localização / compartilhamento |
|---|---|---|---|---|---|---|
| DATA-01 | | | | | | |

**Modelo lógico:** · **Linhagem:** · **Armazenamento:** · **Transações e consistência:** · **Evolução de esquema:** · **Qualidade dos dados:**

### 10.2 Proteção e ciclo de vida

Base e finalidade de tratamento (sem presumir fundamento); minimização e acesso; criptografia; retenção, eliminação e anonimização; backup e restauração; transferência e terceiros.

## 11. APIs, integrações e eventos

| ID | Produtor e consumidor | Interface / evento | Versão / contrato | Autenticação | Latência / volume | Falhas e evolução |
|---|---|---|---|---|---|---|
| API-01 | | | | | | |
| EVT-01 | | | | | | |

Contrato mínimo por API e por evento; integrações legadas.

## 12. Visão física, implantação e infraestrutura

### 12.1 Topologia e ambientes

Diagrama de implantação; ambientes; provedores, regiões e zonas; fronteiras de rede; plataforma de execução; segregação.

### 12.2 Inventário de recursos e capacidade

| ID | Recurso | Ambiente / região | Dimensionamento / limite | Alta disponibilidade | Gestão / infra como código | Dependências |
|---|---|---|---|---|---|---|
| INF-01 | | | | | | |

Falhas estruturais analisadas; portabilidade e dependência de fornecedor; capacidade e carga.

## 13. Segurança, privacidade e conformidade

### 13.1 Modelo de ameaças e fronteiras de confiança

Ameaças por ativo; identidade e sessão; autorização; segredos e chaves; proteção de dados e integrações; cadeia de suprimento; monitoramento.

### 13.2 Matriz de controles e requisitos aplicáveis

| ID | Requisito / risco | Controle arquitetural | Evidência e responsável | Residual / exceção |
|---|---|---|---|---|
| SEC-01 | | | | |
| PRIV-01 | | | | |

Liste só o que se aplica de fato; validação jurídica é do responsável. Controle no desenho não é eficácia em produção.

## 14. Resiliência, observabilidade e operação

### 14.1 Disponibilidade e continuidade

SLIs e SLOs; dependências críticas; resiliência; backups e recuperação de desastre; limites operacionais.

### 14.2 Telemetria e atendimento

| Sinal | Fonte | Objetivo | Alerta / limiar | Painel / runbook |
|---|---|---|---|---|
| métrica | | | | |
| rastro | | | | |
| log / trilha | | | | |

Procedimentos: plantão, severidades, escalonamento, incidentes, postmortem, janelas de mudança.

## 15. Engenharia de entrega e evolução

Repositórios e propriedade; pipelines; estratégia de implantação; controle de alterações; infra como código; rollback; ambientes e dados de teste.

## 16. Validação arquitetural e evidências

| ID | Hipótese / requisito | Tipo de validação | Evidência esperada | Resultado | Responsável / data |
|---|---|---|---|---|---|
| VAL-01 | | | | | |

Portões de aceite; prova de conceito; exceções.

## 17. Custos, capacidade e viabilidade operacional

| Item | Hipótese de volume | Modelo de custo | Estimativa mensal | Sensibilidade |
|---|---|---|---|---|
| computação | | | | |
| dados | | | | |
| integração | | | | |
| operação | | | | |

Premissas financeiras; guardrails.

## 18. Riscos arquiteturais e dívida técnica

| ID | Risco / dívida | Causa e consequência | Probabilidade / impacto | Mitigação / contingência | Responsável / prazo | Estado |
|---|---|---|---|---|---|---|
| RIS-01 | | | | | | aberto |
| DEB-01 | | | | | | |

Risco aceito tem justificativa, autoridade, validade e indicador. Vulnerabilidade sem mitigação não é "dívida técnica".

## 19. Estratégia de implantação, migração e desativação

Origem e destino; fases e marcos; dados; compatibilidade; cutover; rollback; descomissionamento.

| Marco | Pré-requisito | Critério de sucesso | Evidência | Responsável |
|---|---|---|---|---|
| MIG-01 | | | | |

## 20. Catálogo de viewpoints, views e correspondências

| Viewpoint | Interessados e preocupações | Aspectos | Modelo / notação | Verificação |
|---|---|---|---|---|
| VP-CTX | | | C4 contexto | |
| VP-STR | | | C4 níveis 2 e 3 | |
| VP-RUN | | | sequência / dinâmica | |
| VP-DAT | | | modelo de dados e fluxo | |
| VP-DEP | | | implantação | |
| VP-SEC | | | fluxo de confiança e ameaças | |
| VP-MOT | | | ArchiMate motivação | |
| VP-BUS | | | ArchiMate processo de negócio | |
| VP-MIG | | | ArchiMate implementação e migração | |

### 20.1 Correspondências e consistência cruzada

| Relação / regra | Itens vinculados | Verificação | Ação em conflito |
|---|---|---|---|
| toda integração externa tem contrato e responsável | EXT, API/EVT | | |
| todo contêiner está na implantação | CNT, INF | | |
| todo RNF crítico tem validação | RNF, VAL | | |
| toda decisão estrutural liga a artefatos | RDA, DDA, código | | |
| todo tratamento de dado tem classificação | DATA, API/EVT, PRIV/SEC | | |

**Inconsistências conhecidas:** IDs, interpretação adotada, risco e prazo.

## 21. Rastreabilidade, evolução e decisões

| Origem | Decisão | Elemento de solução | Teste / evidência | Responsável / estado |
|---|---|---|---|---|
| RF-NN | RDA-NNNN | CNT-NN | VAL-NN | |

Política de manutenção; relação com os RDAs; pendências para a linha de base.

## 22. Glossário, anexos e referências

### 22.1 Glossário

| Termo | Definição neste sistema | Fonte |
|---|---|---|
| Contêiner (C4) | unidade executável ou repositório de dados; não é contêiner Docker | C4 |

### 22.2 Anexos controlados

| Anexo | Descrição | Versão / caminho |
|---|---|---|
| ANX-01 | diagramas C4 e legendas | |
| ANX-02 | contratos de API | |
| ANX-03 | modelo de dados e classificação | |
| ANX-04 | modelo de ameaças e testes de segurança | |
| ANX-05 | infra como código, pipelines, painéis, runbooks | |
| ANX-06 | índice de RDAs, riscos e planos de migração | |

### 22.3 Critérios de completude antes da aprovação

- [ ] Problema, resultado, escopo e linha de base explícitos; premissas com responsável.
- [ ] Partes interessadas e preocupações mapeadas a viewpoints e views.
- [ ] Requisitos significativos e atributos de qualidade com métrica verificável.
- [ ] Diagramas de contexto, estrutura, dinâmica e implantação legíveis, versionados e coerentes.
- [ ] Dados, contratos, identidade, segurança, privacidade e dependências externas documentados.
- [ ] Riscos, custos, operação, recuperação, testes, migração, rollback e propriedade descritos.
- [ ] Decisões vinculadas a RDAs, com alternativas registradas lá.
- [ ] Correspondências entre visões e rastreabilidade RNF para VAL verificadas.
- [ ] Divergências, exceções, pendências, responsáveis e prazos explícitos.
- [ ] Aprovação pelas alçadas corretas, com evidência acessível.

### 22.4 Referências de metodologia

- ISO/IEC/IEEE 42010:2022, Software, systems and enterprise, Architecture description: https://www.iso.org/standard/74393.html
- ISO/IEC 25010:2023, Product quality model: https://www.iso.org/standard/78176.html
- arc42, as 12 seções: https://arc42.org/overview/
- C4 model, os diagramas: https://c4model.com/diagrams
- Michael Nygard, "Documenting Architecture Decisions": https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions
- MADR 4.0.0: https://adr.github.io/madr/

**Nota de aplicação:** sistema simples não precisa preencher tudo; precisa que cada preocupação relevante tenha resposta, evidência ou justificativa de não aplicabilidade. Qualidade não se mede em páginas.
