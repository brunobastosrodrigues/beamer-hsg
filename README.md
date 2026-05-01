# Beamer HSG Template

> **Disclosure.** This is **not** an official University of St. Gallen
> template, intended for **internal team meetings,
> seminars, lecture handouts, draft talks, and other non-official
> situations** where a quick LaTeX-driven slide deck is useful. For any
> **official HSG occasion** (e.g., institutional communication, public
> representation of the University, branded external events) you must
> use the **official HSG PowerPoint template** distributed by the
> University's Communications & Marketing office. The HSG name, logos,
> and corporate identity are property of the University of St. Gallen;
> their use in this repository is for personal/academic convenience
> only and confers no endorsement.

A Beamer theme that replicates the University of St. Gallen
PowerPoint template, so the same visual identity can be used from
LaTeX sources. Vendored Gillius ADF font for an authentic
Gill-Sans-Nova look without system installs.

**Recommended use cases**

- Internal lab / research-group presentations
- Lecture slides for HSG-affiliated courses
- PhD progress meetings, thesis-committee updates
- Quick draft decks where setting up PowerPoint is overkill
- Any private working presentation among HSG colleagues

**Not recommended for**

- Official university communications
- External keynotes representing HSG
- Branded recruiting / marketing materials
- Anything where the absence of the *official* corporate identity
  would be a problem

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
├── beamerthemeHSG.sty                  the theme (root for \usetheme{HSG})
├── latexmkrc                           default compile config
├── helpers.json                        machine-readable API manifest
├── AGENTS.md                           agent reference + decision table
├── OVERLEAF.md                         how to upload to Overleaf
├── README.md                           this file
├── bin/
│   └── new-deck.sh                     bootstrap a new deck
├── assets/                             every image asset
│   ├── hsg-logo-{en,de}.{pdf,png}      vector + raster logos
│   ├── hsg-logo-cover.png              logo + institute subtitle
│   ├── hsg-badge.png                   green frame around cover photo
│   ├── hsg-agenda-texture-portrait.jpg concrete texture for agenda
│   ├── hsg-closing-campus.jpg          campus photo for closing
│   └── hsg-closing-logo-band.png       accreditation strip + tagline
├── fonts/
│   ├── GilliusADF-{Regular,Italic,Bold,BoldItalic}.otf
│   └── LICENSE-Gillius-ADF.txt         GPL-2 + font exception
├── example/
│   ├── skeleton.tex                    minimal compileable starter
│   ├── demo-using-the-template.tex     20-page tutorial
│   └── demo-using-the-template-v1.pdf  pre-compiled tutorial
└── examples/
    ├── example.tex                     showcase deck source
    └── example-v*.pdf                  pre-compiled showcase versions
```

The theme resolves image filenames against `./assets/`, `./`, and
`../assets/` automatically (`\graphicspath{...}`), so users can keep
the organised layout above OR a flat layout (everything next to the
`.tex`). `bin/new-deck.sh` produces an `assets/` subfolder by default.

## Helpers (one-line summary)

| Macro | Purpose |
|---|---|
| `\titlepage` | Cover slide. Set `\coverimage{path}` in preamble. |
| `\hsgagenda{ \item ... }` | Numbered agenda + concrete-texture column. |
| `\hsgsetsections{a, b, c}` | Declare deck outline (drives sidebar). |
| `\hsgsection{Name}` | Silent: advances sidebar progress. |
| `\hsgtwocol{l}{r}` | Two columns aligned with the frametitle. |
| `\hsgthreecol{a}{b}{c}` | Three columns with the same alignment guarantee. |
| `\hsgstatement{text}` | One bold green sentence, centred on the slide. |
| `\hsgquote[photo.jpg]{q}{author}` | Quote on white; optional square author avatar. |
| `\hsgquoteinverted[photo.jpg]{q}{author}` | Quote on green; same optional avatar. |
| `\hsgfullimage{path}` | Full-bleed image. |
| `\hsgvideolink{url}{thumbnail.jpg}` | Clickable video thumbnail with play overlay. |
| `\hsgbackup` | Appendix separator; switches progress to *appendix*. |
| `\hsgbibliography` | References slide via biblatex (`allowframebreaks`). |
| `\hsgclosingcontact{name}{email}` | One translucent contact box per call (repeatable). |
| `\hsgclosing` | Closing *Questions?* slide with campus photo. |
| `\hsgemph{word}` | Inline HSG-green bold accent. |

For full details and the layout-decision table, see **AGENTS.md**.

## Overleaf

See **OVERLEAF.md**. TL;DR: download the GitHub release ZIP →
*New Project → Upload Project* → set compiler to XeLaTeX → compile.

## Fonts

The HSG corporate identity uses two families:

| Role  | HSG official      | Open clone (vendored) | Licence    |
|-------|-------------------|-----------------------|------------|
| Sans  | Gill Sans MT Pro  | Gillius ADF           | GPL-2+FE   |
| Serif | Palatino OTF      | TeX Gyre Pagella      | GUST FL    |

xelatex / lualatex pick up both automatically via `fontspec` from
`./fonts/`. Slides are sans-dominant (`\sffamily` is the default);
the serif family is available via `\rmfamily` or `\textrm{...}` for
formal-document body text.

pdflatex falls back to **Lato** (sans) + **mathpazo** (Palatino-clone
serif). Always available; less faithful to the corporate look.

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
