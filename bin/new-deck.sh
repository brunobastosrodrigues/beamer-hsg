#!/usr/bin/env bash
# Usage: bin/new-deck.sh <target-dir>
#
# Bootstraps a new HSG-themed Beamer deck. Copies the theme, every asset,
# the fonts/ directory, and the latexmkrc into <target-dir>, plus the
# minimal skeleton renamed to deck.tex. The user fills in the TODO markers
# and compiles with `pdflatex deck.tex` (3 passes) or `latexmk deck.tex`.

set -euo pipefail

usage() {
  cat <<'EOF'
Usage: bin/new-deck.sh <target-dir>

Bootstraps a new HSG-themed Beamer deck in <target-dir>. Copies the theme,
every asset, the fonts/ directory, and the latexmkrc, plus the minimal
skeleton renamed to deck.tex. Fill in the TODO markers, then compile with
`pdflatex deck.tex` (3 passes) or `latexmk deck.tex`.

Arguments:
  <target-dir>   Directory to scaffold the deck into (created if missing).

Options:
  -h, --help     Show this help and exit.
EOF
}

case "${1:-}" in
  -h|--help)
    usage
    exit 0
    ;;
esac

if [ "$#" -eq 0 ]; then
  usage >&2
  exit 2
fi

TARGET="$1"
HERE="$(cd "$(dirname "$0")/.." && pwd)"

mkdir -p "$TARGET"

# Theme + assets
cp "$HERE/beamerthemeHSG.sty"          "$TARGET/"
cp "$HERE/latexmkrc"                   "$TARGET/"
mkdir -p "$TARGET/assets"
cp "$HERE/assets/"*.pdf "$HERE/assets/"*.png "$HERE/assets/"*.jpg "$TARGET/assets/"
cp -r "$HERE/fonts"                    "$TARGET/"

# Starter
cp "$HERE/example/skeleton.tex" "$TARGET/deck.tex"

cat <<EOF

  Deck scaffolded at: $TARGET

  Next steps:
    1. Edit $TARGET/deck.tex and replace every TODO marker.
    2. Compile (three passes):
         cd $TARGET && pdflatex deck.tex && pdflatex deck.tex && pdflatex deck.tex
       Or with latexmk:
         cd $TARGET && latexmk deck.tex

EOF
