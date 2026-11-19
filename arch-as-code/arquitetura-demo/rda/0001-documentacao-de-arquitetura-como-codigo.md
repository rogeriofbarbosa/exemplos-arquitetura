---
status: aceita
date: 2026-10-12
decision-makers: arquiteto responsável
consulted: engenharia
informed: quem escreve especificações e quem consome a arquitetura (pessoas e agentes de IA)
---
# RDA-0001: documentar a arquitetura como código, em texto versionado, junto das especificações

**Finalidade:** registrar a decisão sobre COMO a arquitetura da Plataforma Exemplo é descrita e mantida, com as alternativas e os critérios.

**Identificador:** RDA-0001
**Sistema / domínio:** Plataforma Exemplo (todos os contêineres); o documento vive no repositório de especificações
**Estado:** aceita
**Autores:** arquiteto responsável
**Responsável pela decisão:** arquiteto responsável
**DDA vinculado:** [`../dda/01-plataforma-exemplo.md`](../dda/01-plataforma-exemplo.md), §6 e §15
**Projetos afetados:** o repositório de especificações (onde a documentação vive); painel web, app, API e infraestrutura são o objeto descrito.

## 0. Controle e governança do registro

| Campo | Valor |
|---|---|
| ID e título | RDA-0001: documentar a arquitetura como código |
| Categoria | Documentação / Plataforma |
| Abrangência | toda a documentação de arquitetura; não altera código de produto |
| Decisor com alçada | arquiteto responsável |
| DDA, especificação, incidentes associados | DDA §6 e §15; índice em [`../README.md`](../README.md) |
| Registros relacionados | nenhum anterior; é o primeiro RDA |
| Data de reavaliação ou gatilho | surgir editor gráfico que devolva Structurizr DSL; segundo produto no mesmo repositório (modo multi-workspace); exigência de parceiro por formato específico |

## 1. Declaração objetiva da decisão

**Questão a decidir:** em que forma e com que ferramentas a arquitetura é descrita para que pessoas, agentes de IA, auditoria e parceiros a leiam, e para que ela não envelheça em silêncio em relação ao código?
**Decisão em uma frase:** adotar documentação de arquitetura como código, em texto versionado (modelo C4 em Structurizr DSL, visões ArchiMate em PlantUML, comportamento em Mermaid, DDA e RDAs em Markdown), aceitando que a autoria é textual e que não existe editor gráfico para a parte C4.

## 2. Contexto, problema e forças em conflito

**Situação atual (AS-IS):** documentação em Markdown com boa convenção, mas sem diagrama formal: os diagramas eram arte ASCII espalhada por vários documentos, e as decisões viviam em tabelas e comentários sem numeração, ciclo de vida ou índice.
**Problema:** sem modelo, cada diagrama é um desenho solto que não se valida, não se reutiliza entre visões e não acusa quando o código muda; sem registro de decisões, a história se perde e as mesmas discussões se reabrem.
**Por que decidir agora:** a documentação passou a servir também a terceiros (parceiros, auditoria) e a orientar agentes de IA que implementam as especificações.
**Forças em conflito:** autoria humana visual contra manutenção por agentes a partir do código; semântica de modelo contra simplicidade do ferramental; notação reconhecida por quem desenvolve (C4) contra notação reconhecida por auditoria e parceiros (ArchiMate).
**Premissas declaradas:** a maior parte do texto do repositório é escrita por agentes a partir do código, e continuará sendo.
**Não-objetivos:** não decide o conteúdo da arquitetura, só a forma de descrevê-la; não decide ferramenta de desenho livre para rascunho.

## 3. Fatores de decisão, requisitos, restrições e critérios

### 3.1 Critérios verificáveis

| ID | Critério | Natureza | Regra ou métrica de aceite | Importância |
|---|---|---|---|---|
| CR-01 | o agente lê e escreve 100% do artefato | eliminatório | fonte em texto, sem coordenadas de layout exigidas | obrigatório |
| CR-02 | renderização determinística com erro de compilador | eliminatório | mesma entrada, mesma saída; sintaxe errada falha | obrigatório |
| CR-03 | semântica de modelo na camada de software | preferência | renomear elemento atualiza todas as visões | alta |
| CR-04 | diff legível e validação headless no CI, sem licença | preferência | roda em runner Linux com Docker | alta |
| CR-05 | notação reconhecida pelo público certo | preferência | C4 para quem desenvolve; ArchiMate para auditoria e parceiro | média |
| CR-06 | validação dos links para código e especificação | preferência | verificador de links sai com sucesso | alta |

**Restrições não negociáveis:** o modelo descreve o código, não o que se supõe publicado; nada se duplica do que o código já declara (schema, contrato da API, migrations).

### 3.2 Regra de priorização

Sem pesos: os dois critérios eliminatórios decidem sozinhos (CR-01 e CR-02 excluem ferramenta gráfica e arquivo com coordenadas como fonte). Os demais desempatam entre as opções em texto.

## 4. Alternativas consideradas, inclusive o status quo

| Alternativa | Descrição / mecanismo | Atende as restrições? | Benefícios | Limitações e riscos |
|---|---|---|---|---|
| ALT-A | Structurizr DSL (C4) + PlantUML com a biblioteca ArchiMate + Mermaid; DDA e RDA em Markdown; SVG gerados | sim | texto do começo ao fim; modelo onde importa; um renderizador (PlantUML com Graphviz); o Structurizr exibe modelo, DDA e RDAs juntos | duas notações pedem tabela de correspondência; a biblioteca ArchiMate do PlantUML não valida as regras de relacionamento; layout sempre automático |
| ALT-B | Archi (com coArchi) como fonte do modelo ArchiMate; C4 modelado como especialização | parcialmente (falha CR-01 nas visões) | modelo ArchiMate completo com validação; editor gráfico; exporta CSV, formato aberto e relatório HTML | XML com coordenadas e sem auto-layout; importação traz o modelo mas não as visões; automatizar visões exige plugin de script |
| ALT-C | PlantUML puro (C4-PlantUML e ArchiMate), sem modelo | sim | o mais simples de instalar e escrever | cada diagrama é independente: renomear a API em dez diagramas é dez edições, e nada acusa inconsistência |
| ALT-D | ferramenta gráfica (draw.io, Miro, Visio, IcePanel) exportando imagem | não (CR-01, CR-02) | autoria visual rápida | fonte binária ou na nuvem de terceiro; sem diff; imagem envelhece no primeiro rename sem acusar |
| ALT-E | manter como está (ASCII e decisões informais) | não (CR-02, CR-03) | custo zero | o problema da §2 permanece |

**Descartadas antes da comparação:** D2 (sem notação C4 ou ArchiMate); LikeC4 (texto-primeiro como o Structurizr, sem vantagem decisiva).
**Dependência de fornecedor e reversibilidade:** o DSL, os `.puml` e o Markdown são abertos; migrar para outra ferramenta custa um conversor, não uma reescrita.

## 5. Matriz comparativa e análise de trade-offs

| Critério | ALT-A | ALT-B | ALT-C | ALT-D | Confiança |
|---|---|---|---|---|---|
| CR-01 (eliminatório) | atende | falha nas visões | atende | falha | alta |
| CR-02 (eliminatório) | atende | parcial | atende | falha | alta |
| CR-03 modelo | melhor | melhor | pior | similar (IcePanel) | alta |
| CR-04 CI sem licença | atende | parcial (exige display virtual) | atende | falha | média |
| CR-05 notação | ambas | ArchiMate, C4 por especialização | ambas | varia | média |
| Reversibilidade | alta | média (XML próprio) | alta | baixa | alta |

**Análise crítica:** ALT-A é a única que atende os dois eliminatórios e ainda tem modelo na camada que mais muda (software). ALT-B domina em semântica ArchiMate, mas deixa o ciclo com agentes pela metade. ALT-C perde para ALT-A só em CR-03, e é o que ALT-A usa onde o modelo importa pouco (visões de empresa, poucas e lentas).
**Teste de sensibilidade:** se a autoria humana visual passar a dominar o fluxo, ALT-B ou um editor gráfico de C4 voltam à mesa; gatilho registrado na §0.

## 6. Decisão e justificativa

**Opção selecionada:** ALT-A.
**Formulação normativa:** "Para a documentação de arquitetura da Plataforma Exemplo, adotamos texto versionado (Structurizr DSL para o C4, PlantUML para as visões ArchiMate, Mermaid para comportamento, Markdown para DDA e RDAs), visando manutenção por agentes a partir do código e validação automática, aceitando que não há editor gráfico para a parte C4 e que a autoria visual se faz por rascunho transcrito."
**Justificativa principal:** CR-01 e CR-02 (texto e determinismo) permitem ao agente manter o modelo coerente com o código e ao CI acusar deriva; CR-03 e CR-06 fecham o ciclo com a validação do Structurizr e do verificador de links.
**Por que não as alternativas:** ALT-B falha CR-01 nas visões; ALT-C não tem modelo; ALT-D falha os dois eliminatórios; ALT-E mantém o problema.
**Limites:** não determina o conteúdo das visões, o nível de detalhe do DDA, nem a ferramenta de rascunho livre; não impede usar o Archi como visualizador quando alguém pedir o formato aberto.

## 7. Como a decisão altera o desenho

| Aspecto | Mudança resultante | Artefato a alterar |
|---|---|---|
| Documentação | pasta de arquitetura com modelo, DDA, RDAs, templates e scripts | `README.md`, `workspace.dsl`, `dda/`, `rda/`, `templates/`, `scripts/` |
| CI | validação do workspace e dos links a cada mudança | workflow de validação de documentos |
| Git | `workspace.json` e `.structurizr/` ignorados (layout é automático) | `.gitignore` |
| Código de produto | nenhuma | nenhum |

**Restrições de implementação:** nenhum `README.md` dentro de `dda/` ou `rda/` (o Structurizr importa todo Markdown dessas pastas); chaves de visão em ASCII; propriedade `codigo` em todo contêiner; diagrama no DDA como imagem SVG gerada, nunca `embed:`.

## 8. Consequências

### 8.1 Benefícios esperados

- Um renderizador (PlantUML com Graphviz) para o C4 exportado e o ArchiMate.
- O Structurizr local exibe modelo, DDA e RDAs no mesmo lugar, com recarga automática ao salvar.
- Agentes escrevem e revisam tudo em texto; o verificador de links prova que cada caminho de código citado existe.
- Diagrama envelhecido ou editado à mão aparece como diff ao regenerar.

### 8.2 Custos e consequências negativas assumidas

- Não há editor gráfico que devolva Structurizr DSL; a modelagem inicial visual exige rascunho e transcrição.
- Duas notações (C4 e ArchiMate) exigem a tabela de correspondência mantida no DDA §20.
- A biblioteca ArchiMate do PlantUML não valida as regras de relacionamento da especificação 3.2; a revisão confere contra o Apêndice B dela.
- Layout sempre automático: visão com muitas setas numa caixa fica ilegível e precisa ser dividida.

### 8.3 Consequências neutras e obrigações novas

- Toda decisão nova vira RDA pelo template.
- O modelo descreve o código; o estado publicado se lê na própria infraestrutura, nunca num documento.
- Produto novo no mesmo repositório entra como workspace próprio, com um workspace de paisagem ligando os sistemas.

## 9. Riscos, controles, reversibilidade e exceções

| ID | Risco / modo de falha | Probabilidade / impacto | Mitigação e teste | Gatilho |
|---|---|---|---|---|
| AR-01 | o modelo envelhece em relação ao código | média / alto | propriedade `codigo` + verificador de links; revisão do modelo em cada entrega | entrega que toca contêiner ou integração sem tocar o DSL |
| AR-02 | diagrama automático ilegível | média / médio | dividir visões; ajustar espaçamentos; evitar linhas ortogonais (rótulos sobrepostos) | reclamação de leitura |
| AR-03 | o Structurizr muda formato ou comandos | baixa / médio | DSL é aberto; exportação para PlantUML e JSON | release com quebra |
| AR-04 | terceiro exige formato que o texto não dá | baixa / baixo | exportar para o formato aberto via Archi como visualizador | pedido de parceiro |

**Reversibilidade:** alta; os formatos são abertos.
**Condições de revogação:** o fluxo de autoria passar a ser majoritariamente humano e visual; surgir editor gráfico que devolva Structurizr DSL.

## 10. Plano de validação e critérios de comprovação

| ID | Hipótese decisiva | Verificação | Critério de sucesso |
|---|---|---|---|
| TST-01 | o modelo valida e exporta sem erro | `scripts/structurizr.sh validate` e `inspect` | sai com sucesso e sem achados |
| TST-02 | a geração é determinística | duas gerações seguidas, hashes comparados | hashes idênticos |
| TST-03 | o Structurizr importa DDA e RDAs | tela local | seções, imagens e decisão com estado e data |
| TST-04 | os links para código e especificação existem | verificador de links | sai com sucesso |
| TST-05 | o CI acusa modelo inválido | job de validação | job vermelho ao quebrar o DSL |

**Confirmação contínua:** `structurizr.sh validate` sem erro; regenerar os diagramas não produz diff; verificador de links sem erro; nenhum `.drawio`, `.archimate` ou imagem editada à mão na pasta de arquitetura.

## 11. Migração, entrega e rollback

**Impacto no legado:** os diagramas ASCII permanecem onde estão e perdem o papel de fonte quando a visão equivalente existir no modelo; as decisões informais viram RDAs retroativos.
**Rollback:** apagar a pasta; nada mais depende dela.

## 12. Responsabilidades e decisão formal

| Participante | Papel no processo | Posição |
|---|---|---|
| Arquiteto responsável | decisor e autor | aceita |
| Engenharia | consultada | recomendou ALT-A; apresentou ALT-B quando se pediu editor gráfico |

**Dissenso registrado:** nenhum. Registrou-se que ALT-A não resolve a autoria visual inicial, e o custo foi assumido.

## 13. Dependências, rastreabilidade e revisão

**Depende de:** convenções do repositório de especificações (bloco de estado, verificador de links, CI).
**Contradiz ou substitui:** nenhum registro anterior.
**DDA afetado:** [`01-plataforma-exemplo.md`](../dda/01-plataforma-exemplo.md), §6, §15 e §20.
**Requisitos e riscos afetados:** DDA RES-04 (documentação como código) e RIS-04 (deriva entre modelo e código).
**Gatilhos para novo RDA:** editor gráfico que devolva Structurizr DSL; exigência externa de formato; mudança do fluxo de autoria.

## 14. Checklist de qualidade

- [x] Uma única decisão significativa, expressa objetivamente.
- [x] Contexto, problema, urgência, alternativas e status quo descritos.
- [x] Critérios eliminatórios separados das preferências.
- [x] Premissas, trade-offs e fontes explícitos.
- [x] Benefícios e consequências negativas assumidos.
- [x] Comparação sem pontuação arbitrária.
- [x] Limites, riscos, rollback e reversibilidade descritos.
- [x] Plano de verificação.
- [x] Política de reavaliação.

## 15. Referências

- Structurizr, "Why as code": https://docs.structurizr.com/as-code
- Biblioteca ArchiMate do PlantUML: https://github.com/plantuml-stdlib/Archimate-PlantUML
- Archi: https://www.archimatetool.com
- MADR 4.0.0: https://adr.github.io/madr/
- Michael Nygard, "Documenting Architecture Decisions" (2011): https://cognitect.com/blog/2011/11/15/documenting-architecture-decisions
