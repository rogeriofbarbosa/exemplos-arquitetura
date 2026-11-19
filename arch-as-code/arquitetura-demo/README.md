# Arquitetura como código: modelo de exemplo

Exemplo completo e autocontido de documentação de arquitetura **como código, em texto**, para um
sistema fictício (a "Plataforma Exemplo"). Esta pasta é o diretório de dados do Structurizr: ele lê
o modelo, o DDA e os RDAs daqui e os exibe juntos. A decisão de documentar assim, com as
alternativas descartadas, está no [RDA-0001](rda/0001-documentacao-de-arquitetura-como-codigo.md).

## O que mora aqui

| Caminho | Conteúdo | Quem escreve |
|---|---|---|
| [`workspace.dsl`](workspace.dsl) | o modelo C4 (pessoas, contêineres, componentes, domínios, implantação) em Structurizr DSL; as visões derivam dele | pessoa ou agente, em texto |
| [`dda/`](dda/01-plataforma-exemplo.md) | o Documento de Descrição da Arquitetura (DDA), nas 23 seções do modelo (ISO 42010, arc42 e C4 adaptados), importado pelo Structurizr como documentação | pessoa ou agente |
| `dda/diagramas/` | **saída de build**: C4 exportado e renderizado, ArchiMate renderizado. Nunca editar; regenerar | `scripts/gerar-diagramas.sh` |
| [`rda/`](rda/0001-documentacao-de-arquitetura-como-codigo.md) | um Registro de Decisão de Arquitetura (RDA, o ADR) por arquivo, `NNNN-titulo-curto.md` (o importador do Structurizr só lê nome que começa por número), com o bloco MADR no topo, importados pelo Structurizr como decisões | pessoa ou agente |
| [`archimate/`](archimate/motivacao.puml) | as visões ArchiMate em PlantUML (`!include <archimate/Archimate>`) | pessoa ou agente |
| [`templates/`](templates/dda.md) | os modelos de [DDA](templates/dda.md) e de [RDA](templates/rda.md) | copiar, não editar |
| [`scripts/`](scripts/structurizr.sh) | subir o Structurizr, validar e gerar os diagramas | |

**Nenhum `README.md` dentro de `dda/` ou `rda/`**: o Structurizr importa todo Markdown dessas
pastas como seção ou como decisão.

## Visões do modelo

| Chave | Tipo | O que mostra |
|---|---|---|
| `Contexto` | C4 nível 1 | quem usa o sistema e com que sistemas externos ele fala |
| `Conteineres` | C4 nível 2 | os cinco contêineres e quem os usa |
| `Integracoes` | C4 nível 2 | a API e cada integração externa |
| `Dominios` | personalizada | o mapa de domínios do negócio (principais, de suporte, genéricos, vizinho) |
| `DominiosComponentes` | C4 nível 3 | os domínios como componentes da API e as dependências entre eles |
| `DominiosUso` | C4 nível 3 | quem usa cada componente |
| `DominiosIntegracoes` | C4 nível 3 | o que cada componente usa fora da API |
| `Producao` | implantação | onde cada contêiner roda |

## Como usar

Requer Docker (imagem `structurizr/structurizr`), e para gerar os SVG, `plantuml` e `graphviz`.

```bash
# Ver o modelo, o DDA e os RDAs no navegador (recarrega sozinho ao salvar)
scripts/structurizr.sh local        # http://localhost:8088
scripts/structurizr.sh stop

# Antes de entregar uma mudança
scripts/structurizr.sh validate     # sintaxe e referências do modelo
scripts/structurizr.sh inspect      # regras de qualidade (descrição, tecnologia, elemento solto)
scripts/gerar-diagramas.sh          # regenera os SVG de dda/diagramas a partir do texto
```

## Convenções

- **Texto é a fonte; imagem é saída.** `workspace.dsl` e `archimate/*.puml` se editam; `dda/diagramas/`
  se regenera.
- **Layout sempre automático** (`autoLayout` em toda visão). Por isso `workspace.json`, onde o
  Structurizr guarda layout manual, fica fora do git.
- **Cada contêiner tem a propriedade `codigo`** com a raiz do código que o realiza; o DDA repete esses
  caminhos, e um verificador de links prova que existem.
- **Chaves de visão em ASCII** (`Contexto`, `Conteineres`, `Producao`): viram nome de arquivo.
- **Diagrama dentro do DDA** entra como imagem SVG gerada, por caminho relativo: renderiza no GitHub,
  no editor e no Structurizr. A sintaxe `embed:` do Structurizr não se usa, porque fora dele vira
  imagem quebrada.
- **RDA** segue o [modelo](templates/rda.md): bloco de metadados com `status` e `date` (lidos pelo
  importador `madr` do Structurizr), critérios eliminatórios separados das preferências, alternativas
  com o status quo, e a **Confirmação contínua**, que diz como provar no código que a decisão continua
  valendo. Estados: `proposta`, `em avaliação`, `aceita`, `rejeitada`, `descontinuada`,
  `substituída por RDA-NNNN`.
- **DDA** segue o [modelo](templates/dda.md): 23 seções com identificadores estáveis (RF, RNF, RES,
  PRI, DEC, EXT, CNT, CMP, DIN, DATA, API, EVT, INF, SEC, PRIV, VAL, RIS, MIG, VP). O que não foi
  verificado entra como **Pendente** com responsável, nunca como fato; o que não se aplica entra como
  N/A com justificativa.
- **O que está aqui descreve o código**, não o que se supõe publicado.

## Decisões (RDAs)

| RDA | Decisão | Estado |
|---|---|---|
| [RDA-0001](rda/0001-documentacao-de-arquitetura-como-codigo.md) | documentar a arquitetura como código, em texto versionado, junto das especificações | aceita |
