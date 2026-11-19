# Exemplos de arquitetura

Dois exemplos de documentação de arquitetura escrita em texto e versionada no git. Os dois usam o
mesmo método: um **DDA** (Documento de Descrição da Arquitetura) em 23 seções, baseado em
ISO/IEC/IEEE 42010, arc42 e C4 adaptados, e **RDAs** (Registros de Decisão de Arquitetura, os
ADRs) no formato MADR ampliado.

| Projeto | O que é | Comece por |
|---|---|---|
| [`arch-as-code/`](arch-as-code/arquitetura-demo/README.md) | **O método.** Um sistema fictício, a "Plataforma Exemplo", com a arquitetura inteira como código: o modelo C4 em Structurizr DSL, as visões ArchiMate em PlantUML, os diagramas gerados a partir do texto e os modelos de DDA e de RDA para copiar | [README do modelo](arch-as-code/arquitetura-demo/README.md) |
| [`hospital/`](hospital/docs/README.md) | **O método aplicado a um caso real.** A proposta de arquitetura (TO-BE, sem implementação) do Agente de Completude de Normativos e Cadeia de Valor, que roda sobre a Plataforma AI do hospital | [README da documentação](hospital/docs/README.md) |

Leia primeiro o `arch-as-code` para entender a estrutura e as convenções. Depois leia o `hospital`
para ver como elas se aplicam a um problema concreto, incluindo o que fica **Pendente** quando
uma informação depende do cliente.

## arch-as-code: arquitetura como código

Pasta: [`arch-as-code/arquitetura-demo/`](arch-as-code/arquitetura-demo/README.md)

| Artefato | Caminho |
|---|---|
| Modelo C4 (fonte de todas as visões) | [`workspace.dsl`](arch-as-code/arquitetura-demo/workspace.dsl) |
| DDA da Plataforma Exemplo | [`dda/01-plataforma-exemplo.md`](arch-as-code/arquitetura-demo/dda/01-plataforma-exemplo.md) |
| RDA-0001: documentar a arquitetura como código | [`rda/0001-documentacao-de-arquitetura-como-codigo.md`](arch-as-code/arquitetura-demo/rda/0001-documentacao-de-arquitetura-como-codigo.md) |
| Visão ArchiMate de motivação | [`archimate/motivacao.puml`](arch-as-code/arquitetura-demo/archimate/motivacao.puml) |
| Modelos para copiar | [DDA](arch-as-code/arquitetura-demo/templates/dda.md) · [RDA](arch-as-code/arquitetura-demo/templates/rda.md) |
| Diagramas gerados (não editar) | [`dda/diagramas/`](arch-as-code/arquitetura-demo/dda/diagramas/) |

Para ver o modelo, o DDA e os RDAs juntos no navegador (requer Docker):

```bash
cd arch-as-code/arquitetura-demo
scripts/structurizr.sh local      # http://localhost:8088
scripts/gerar-diagramas.sh        # regenera os SVG (requer plantuml e graphviz)
```

Os demais comandos e as convenções estão no
[README do modelo](arch-as-code/arquitetura-demo/README.md).

## hospital: Agente de Completude de Normativos e Cadeia de Valor

Pasta: [`hospital/docs/`](hospital/docs/README.md)

O agente cruza o que a área do hospital faz e o que já documentou com o que as acreditações, a
legislação e o mercado exigem, e recomenda o que falta nos normativos internos e na Cadeia de
Valor. As figuras de base do projeto, a plataforma e o fluxo do agente, estão no
[README da documentação](hospital/docs/README.md#base-do-projeto).

| Artefato | Caminho |
|---|---|
| Especificação (pendente de implementação) | [`especificacao/pendentes/agente-de-completude-2026-11.md`](hospital/docs/especificacao/pendentes/agente-de-completude-2026-11.md) |
| DDA do agente | [`arquitetura/dda/01-agente-de-completude.md`](hospital/docs/arquitetura/dda/01-agente-de-completude.md) |
| RDAs 0001 a 0005 | [`arquitetura/rda/`](hospital/docs/arquitetura/rda/) (índice no [README da arquitetura](hospital/docs/arquitetura/README.md#decisões-rdas)) |
| Diagramas | [`arquitetura/diagramas/`](hospital/docs/arquitetura/diagramas/) |

Neste projeto os diagramas são imagens PNG, e não são gerados a partir de um modelo como no
`arch-as-code`.

## Estrutura

```text
exemplos-arquitetura/
├── arch-as-code/
│   └── arquitetura-demo/      modelo C4, DDA, RDA, ArchiMate, modelos e scripts
└── hospital/
    └── docs/
        ├── especificacao/     requisitos, organizados por estado
        └── arquitetura/       DDA, RDAs e diagramas
```

## Convenções comuns

- Uma decisão nova exige um RDA novo. O RDA substituído não é apagado; muda para o estado
  `substituída por RDA-NNNN`.
- Estados de RDA: `proposta`, `em avaliação`, `aceita`, `rejeitada`, `descontinuada`,
  `substituída por RDA-NNNN`.
- O que não foi verificado entra no DDA como **Pendente**, com responsável, e nunca como fato.
