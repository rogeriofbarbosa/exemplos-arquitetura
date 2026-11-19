# Agente de Completude de Normativos e Cadeia de Valor: documentação

Esta pasta reúne a documentação da proposta de arquitetura para o hospital, a entrega contém apenas
a arquitetura e documentação para criação do agente de completude.

| Coleção | Conteúdo |
|---|---|
| [`especificacao/`](especificacao/README.md) | requisitos funcionais e técnicos, fases e testes, organizados por estado |
| [`arquitetura/`](arquitetura/README.md) | o DDA (Documento de Descrição da Arquitetura), os RDAs (Registros de Decisão de Arquitetura) e os diagramas |

## Base do projeto

As duas figuras abaixo são o ponto de partida do projeto: a primeira mostra a plataforma em que o
agente vai rodar, a segunda descreve o agente a ser desenvolvido.

### Arquitetura da plataforma Hospital+

Visão macro da Plataforma AI do Hospital+ (versão out/2026): modelos e LLM Gateway, banco vetorial,
Workflow AI (Haystack) com RAG, batch e online, agentes online, MCP Gateways, memória, guardrail,
conectores de canal, além das camadas de dados (Databricks e Airflow), plataforma digital e
aplicações AI. A legenda distingue o que está implantado, previsto, legado AWS, em avaliação e
com desligamento previsto.

![Arquitetura da plataforma Hospital+](Arquitetura%20da%20plataforma%20Hospital%2B.png)

### Agente de Completude de normativos e Cadeia de Valor

Fluxo do agente: o sub-agente de processos (1) define com os gestores o que a área faz, o
sub-agente de normativos internos (2) reúne as políticas e procedimentos já documentados, e o
sub-agente de completude (3) cruza esse material em duas camadas: uma determinística, contra
acreditações (JCI, cerca de 25) e legislação vigente já presentes na base do Hospital, e uma livre
e holística, contra o benchmark de mercado. A saída recomenda o que falta nos normativos internos
e nos processos mapeados na Cadeia de Valor (revisar, incluir, atualizar). O guardrail exige que o
agente liste o que não pode ser dito antes de sugerir.

![Correção no texto de acreditações](Correc%CC%A7a%CC%83o%20no%20texto%20de%20acreditac%CC%A7o%CC%83es.png)


## Hierarquia de autoridade

1. RDAs aceitos e DDA vigente.
2. Especificação.
3. Diagramas.
