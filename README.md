# Beamer HSG Template

A Beamer theme that replicates the University of St. Gallen PowerPoint
template, so the same visual identity can be used from LaTeX sources.

## Contents

```
beamer-hsg-template/
├── beamerthemeHSG.sty     the Beamer theme
├── hsg-logo.png           the HSG logo, extracted from the official .pptx
├── hsg-badge.png          angular shape asset (reserved for future use)
├── hsg-tagline.png        "From insight to impact" raster (reserved)
├── example.tex            sample presentation
├── example.pdf            pre-compiled preview
└── README.md              this file
```

## Usage

Put the folder next to your `.tex` file, or copy the `.sty` and the
`hsg-logo.png` into the same directory as your document. Then:

```latex
\documentclass[aspectratio=169]{beamer}
\usetheme{HSG}

\title{Computer Networks}
\subtitle{Network Security}
\author{Bruno Rodrigues}
\institute{University of St.\,Gallen\\Bachelor in Computer Science\\Computer Networks (2,906)}
\coursefooter{Computer Networks}   % appears before "School of Computer Science" in the footer

\begin{document}

\begin{frame}[plain]
  \titlepage
\end{frame}

\begin{frame}
  \frametitle{Lecture goals}
  \framesubtitle{Hello World}    % small green tag above the title
  \begin{itemize}
    \item To \hsgemph{provide} a general overview of encryption mechanisms.
    \item To \hsgemph{overview} symmetric and asymmetric crypto.
  \end{itemize}
\end{frame}

\end{document}
```

Compile twice to let `remember picture` settle:

```bash
pdflatex example.tex
pdflatex example.tex
```

## What the theme provides

- **Title page** with the HSG logo top-left, a green triangular wedge
  bottom-right, and the "From insight to impact." tagline.
- **Content pages** with a small green topic tag above the title
  (`\framesubtitle{...}`), black bullets, and a footer containing the
  course name, "School of Computer Science", and the university name.
- **Angular slide-number badge** in HSG green at the bottom-right.
- `\hsgemph{...}` command for inline green-bold keyword emphasis.
- HSG colour palette defined as LaTeX colours: `HSGgreen`, `HSGgreenDark`,
  `HSGbluegrey`, `HSGsand`, `HSGcoral`, `HSGyellow`.

## Fonts

The HSG corporate font is Gill Sans Nova, which is proprietary and not
typically installed on Linux systems. The theme falls back to **Lato Light**,
a widely available humanist sans-serif that is the closest open-source
match. If Gill Sans Nova is available on your system, you can swap the
font declaration in `beamerthemeHSG.sty`:

```latex
% Replace
\RequirePackage[default,light]{lato}
% with
\RequirePackage{fontspec}       % requires lualatex or xelatex
\setsansfont{Gill Sans Nova}
```

and compile with `lualatex` or `xelatex` instead of `pdflatex`.

## Assets

The HSG logo and tagline raster in this folder come from the official
`HSG-slide-template.pptx` published by the University of St. Gallen. If
the University updates its corporate design, drop in a replacement
`hsg-logo.png` and recompile.
