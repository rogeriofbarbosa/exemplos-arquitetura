#!/usr/bin/env bash
# Regenera TODOS os diagramas a partir do texto. O que sai daqui é saída de build e nunca se edita
# à mão: C4 exportado do workspace.dsl pelo Structurizr e renderizado pelo PlantUML; ArchiMate
# renderizado direto dos .puml.
#
# Uso: scripts/gerar-diagramas.sh
# Requer: docker (imagem structurizr/structurizr), plantuml, dot (graphviz).
set -euo pipefail

AQUI="$(cd "$(dirname "$0")" && pwd)"
DADOS="$(cd "$AQUI/.." && pwd)"
C4="$DADOS/dda/diagramas/c4"
ARCHI="$DADOS/dda/diagramas/archimate"

for f in docker plantuml dot; do command -v "$f" >/dev/null || { echo "falta $f no PATH" >&2; exit 2; }; done

echo "▸ validate"
"$AQUI/structurizr.sh" validate

echo "▸ C4: export plantuml → dda/diagramas/c4"
rm -rf "$C4"; mkdir -p "$C4"
"$AQUI/structurizr.sh" export plantuml dda/diagramas/c4 | grep -v '^[0-9:. ]*\[main\] INFO' || true
plantuml -nometadata -tsvg "$C4"/*.puml

echo "▸ ArchiMate → dda/diagramas/archimate"
mkdir -p "$ARCHI"; rm -f "$ARCHI"/*.svg
plantuml -nometadata -tsvg -o "$ARCHI" "$DADOS"/archimate/*.puml

ls -1 "$C4"/*.svg "$ARCHI"/*.svg | sed "s|$DADOS/||"
