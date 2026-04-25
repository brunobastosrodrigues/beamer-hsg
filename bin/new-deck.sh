#!/usr/bin/env bash
# Usage: bin/new-deck.sh <target-dir>
#
# Bootstraps a new HSG-themed Beamer deck. Copies the theme, every asset,
# the fonts/ directory, and the latexmkrc into <target-dir>, plus the
# minimal skeleton renamed to deck.tex. The user fills in the TODO markers
# and compiles with `pdflatex deck.tex` (3 passes) or `latexmk deck.tex`.

set -euo pipefail

TARGET="${1:?usage: bin/new-deck.sh <target-dir>}"
HERE="$(cd "$(dirname "$0")/.." && pwd)"

mkdir -p "$TARGET"

# Theme + assets
cp "$HERE/beamerthemeHSG.sty"          "$TARGET/"
cp "$HERE/latexmkrc"                   "$TARGET/"
cp "$HERE"/hsg-logo-en.pdf             "$TARGET/"
cp "$HERE"/hsg-logo-en.png             "$TARGET/"
cp "$HERE"/hsg-logo-de.pdf             "$TARGET/"
cp "$HERE"/hsg-logo-de.png             "$TARGET/"
cp "$HERE"/hsg-logo-cover.png          "$TARGET/"
cp "$HERE"/hsg-badge.png               "$TARGET/"
cp "$HERE"/hsg-agenda-texture-portrait.jpg "$TARGET/"
cp "$HERE"/hsg-closing-campus.jpg      "$TARGET/"
cp "$HERE"/hsg-closing-logo-band.png   "$TARGET/"
cp -r "$HERE/fonts"                    "$TARGET/"

# Starter
cp "$HERE/templates/skeleton.tex" "$TARGET/deck.tex"

cat <<EOF

  Deck scaffolded at: $TARGET

  Next steps:
    1. Edit $TARGET/deck.tex and replace every TODO marker.
    2. Compile (three passes):
         cd $TARGET && pdflatex deck.tex && pdflatex deck.tex && pdflatex deck.tex
       Or with latexmk:
         cd $TARGET && latexmk deck.tex

EOF
