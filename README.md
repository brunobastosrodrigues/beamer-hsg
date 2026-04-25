# Beamer HSG Template

A Beamer theme that replicates the University of St. Gallen
PowerPoint template, so the same visual identity can be used from
LaTeX sources. Vendored Gillius ADF font for an authentic
Gill-Sans-Nova look without system installs.

## Quick start

```bash
git clone https://github.com/brunobastosrodrigues/beamer-hsg.git
cd beamer-hsg
bin/new-deck.sh ~/my-talk
cd ~/my-talk
# edit deck.tex (replace TODO markers)
pdflatex deck.tex && pdflatex deck.tex && pdflatex deck.tex
```

For the Gill-Sans-Nova look, swap `pdflatex` for `xelatex` (or set
`$pdf_mode = 5` in `latexmkrc` and run `latexmk`).

## Folder

```
beamer-hsg/
├── beamerthemeHSG.sty                      the theme
├── latexmkrc                               default compile config
├── helpers.json                            machine-readable API manifest
├── AGENTS.md                               agent reference + decision table
├── OVERLEAF.md                             how to upload to Overleaf
├── README.md                               this file
├── example.tex / example-v1.pdf            ready-to-render demo
├── bin/new-deck.sh                         bootstrap a new deck
├── templates/
│   ├── skeleton.tex                        minimal compileable starter
│   ├── demo-using-the-template.tex         20-page tutorial
│   └── demo-using-the-template-v1.pdf      pre-compiled tutorial
├── hsg-logo-en.{pdf,png}                   "University of St. Gallen"
├── hsg-logo-de.{pdf,png}                   "Universität St. Gallen"
├── hsg-logo-cover.png                      logo + institute subtitle
├── hsg-badge.png                           green frame around cover photo
├── hsg-agenda-texture-portrait.jpg         concrete texture for agenda
├── hsg-closing-campus.jpg                  campus photo for closing
├── hsg-closing-logo-band.png               accreditation strip + tagline
└── fonts/
    ├── GilliusADF-{Regular,Italic,Bold,BoldItalic}.otf
    └── LICENSE-Gillius-ADF.txt             GPL-2 + font exception
```

## Helpers (one-line summary)

| Macro | Purpose |
|---|---|
| `\titlepage` | Cover slide. Set `\coverimage{path}` in preamble. |
| `\hsgagenda{ \item ... }` | Numbered agenda + concrete-texture column. |
| `\hsgsetsections{a, b, c}` | Declare deck outline (drives sidebar). |
| `\hsgsection{Name}` | Silent: advances sidebar progress. |
| `\hsgstatement{text}` | One bold green sentence at 36 pt. |
| `\hsgquote{q}{author}` | Quote on white. |
| `\hsgquoteinverted{q}{author}` | Quote on green. |
| `\hsgfullimage{path}` | Full-bleed image. |
| `\hsgclosing` | Closing *Questions?* slide with campus photo. |
| `\hsgemph{word}` | Inline HSG-green bold accent. |

For full details and the layout-decision table, see **AGENTS.md**.

## Overleaf

See **OVERLEAF.md**. TL;DR: download the GitHub release ZIP →
*New Project → Upload Project* → set compiler to XeLaTeX → compile.

## Fonts

`fonts/` ships **Gillius ADF** (Arkandis Digital Foundry, GPL-2+FE),
the open-source clone of Gill Sans Nova. xelatex/lualatex pick it up
automatically via `fontspec`. pdflatex falls back to Lato (the
closest humanist sans available in TeX Live).

## Assets

Logos are vector PDFs derived from the official Wikimedia Commons SVG
(public domain). Photos and the accreditation strip are extracted from
the `HSG-slide-template.pptx` master. The closing-slide campus photo
shows the HSG library courtyard.

## Licence

The theme code (`beamerthemeHSG.sty`, scripts, templates, manifests)
is unlicensed for now — treat as "all rights reserved" until a licence
is set. The vendored Gillius ADF fonts retain their **GPL-2+FE**
licence (see `fonts/LICENSE-Gillius-ADF.txt`); the font exception
allows embedding in a compiled PDF without infecting the document with
GPL.
