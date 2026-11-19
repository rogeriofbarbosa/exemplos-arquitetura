#!/usr/bin/env bash
# Structurizr (imagem Docker structurizr/structurizr) sobre esta pasta, que é o diretório de dados.
#
# Uso (a partir de qualquer diretório):
#   scripts/structurizr.sh local      # sobe http://localhost:8088 com o modelo, o DDA e os RDAs
#   scripts/structurizr.sh stop
#   scripts/structurizr.sh validate   # sintaxe e referências do workspace.dsl (sai 0 ou erro)
#   scripts/structurizr.sh inspect    # regras de qualidade do modelo (descrição, tecnologia, elemento solto)
#   scripts/structurizr.sh export [formato] [saída relativa à pasta]
#                                     # formato: plantuml (padrão) | plantuml/c4plantuml | mermaid | json | static
#
# Variáveis: STRUCTURIZR_PORT (8088), STRUCTURIZR_IMAGE.
#
# A exportação direta para PNG/SVG não é suportada pela imagem: os SVG saem do PlantUML, em
# gerar-diagramas.sh.
set -euo pipefail

DADOS="$(cd "$(dirname "$0")/.." && pwd)"
MONTAGEM=/usr/local/structurizr
WS="$MONTAGEM/workspace.dsl"
IMAGEM="${STRUCTURIZR_IMAGE:-structurizr/structurizr:latest}"
PORTA="${STRUCTURIZR_PORT:-8088}"
NOME=exemplo-structurizr

rodando() { docker ps --format '{{.Names}}' | grep -qx "$1"; }
run() { docker run --rm -v "$DADOS":"$MONTAGEM" "$IMAGEM" "$@"; }

case "${1:-}" in
  local)
    if rodando "$NOME"; then echo "já está rodando: http://localhost:$PORTA"; exit 0; fi
    docker run -d --rm --name "$NOME" -p "$PORTA:8080" \
      -e STRUCTURIZR_AUTOREFRESHINTERVAL=2000 \
      -v "$DADOS":"$MONTAGEM" "$IMAGEM" local >/dev/null
    echo "Structurizr local: http://localhost:$PORTA   (parar: $0 stop)"
    echo "Edite workspace.dsl, dda/ ou rda/: a página recarrega sozinha em 2 s."
    ;;
  stop)
    rodando "$NOME" && docker stop "$NOME" >/dev/null && echo "parado" || echo "não estava rodando"
    ;;
  validate)
    run validate -workspace "$WS"
    ;;
  inspect)
    run inspect -workspace "$WS"
    ;;
  export)
    formato="${2:-plantuml}"
    saida="${3:-dda/diagramas/c4}"
    mkdir -p "$DADOS/$saida"
    run export -workspace "$WS" -format "$formato" -output "$MONTAGEM/$saida"
    ;;
  *)
    sed -n '2,13p' "$0"; exit 2
    ;;
esac
