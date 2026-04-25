# Beamer HSG template — agent usage guide

This file tells coding agents (Claude Code, Codex, Cursor, Aider, and similar
tools) how to produce LaTeX Beamer presentations that match the University of
St. Gallen visual identity using the theme in this folder.

Keep this document short. Follow it exactly. Do not improvise styling when a
helper below already covers the layout.

---

## 0. Quickstart for agents (read this first)

```
1. Read templates/skeleton.tex          ← canonical starter
2. Read helpers.json                     ← machine-readable API manifest
3. Read templates/demo-using-the-template.tex  ← one example of every helper
4. Bootstrap a new deck:
     bin/new-deck.sh ~/path/to/new-deck
     cd ~/path/to/new-deck && pdflatex deck.tex && pdflatex deck.tex && pdflatex deck.tex
5. For Overleaf: see OVERLEAF.md
```

The fastest path is `bin/new-deck.sh` because it copies every required
asset (theme, logos, photos, fonts/, latexmkrc) into the target folder
in one shot. After that, fill in the `TODO` markers in `deck.tex`.

If something breaks, jump to *Section 6 — Common errors*.

---

## 1. Folder contract

```
beamer-hsg/
├── beamerthemeHSG.sty                  the theme. DO NOT EDIT unless asked.
├── latexmkrc                           default compile config (3-pass pdflatex).
├── helpers.json                        machine-readable API manifest.
├── README.md, AGENTS.md, OVERLEAF.md   human + agent docs.
├── bin/new-deck.sh                     scaffold a new deck in target dir.
├── assets/                             every image asset, organised in one folder.
│   ├── hsg-logo-{en,de}.{pdf,png}      vector + raster HSG logos.
│   ├── hsg-logo-cover.png              logo + institute subtitle.
│   ├── hsg-badge.png                   green frame around cover photo.
│   ├── hsg-agenda-texture-portrait.jpg concrete-texture column for the agenda.
│   ├── hsg-closing-campus.jpg          campus photo for closing.
│   └── hsg-closing-logo-band.png       accreditation strip + tagline.
├── fonts/                              vendored Gillius ADF OTFs + licence.
├── templates/                          starter and tutorial decks.
└── examples/                           showcase deck + pre-compiled PDFs.
```

The theme resolves image filenames against `./assets/`, `./`, and
`../assets/` automatically via `\graphicspath`. So when an agent runs
`bin/new-deck.sh /path/to/new-deck`, the script copies the theme +
`assets/` + `fonts/` into the target directory; the user's `deck.tex`
sits at the root and `\includegraphics{hsg-...}` resolves transparently.

Do NOT reference assets via absolute paths. Do NOT prefix asset names
with `assets/` in your `\includegraphics{...}` calls — the
`\graphicspath` already covers that.

---

## 2. Minimal document

Every new presentation MUST follow this structure:

```latex
\documentclass[aspectratio=169]{beamer}
\usetheme{HSG}

\title{Short descriptive title}
\subtitle{Optional second line}           % omit if not needed
\author{Author Name}
\institute{University of St.\,Gallen\\Institute or course line}
\date{}                                   % usually empty
\coursefooter{Course Name}                % appears in footer before "School of Computer Science"
\coverimage{images/cover.jpg}             % optional hero image on the title-slide right half

% Presenter contact for the closing slide (sits inside the translucent box).
\hsgclosingcontact
  {Prof. Dr. Author Name}
  {author@example.edu}

\begin{document}

\begin{frame}[plain]\titlepage\end{frame}

\hsgagenda{
  \item Introduction
  \item Methodology
  \item Results
  \item Discussion
}

% Regular frames + any helpers from Section 4 go here.

\hsgclosing   % "Questions?" on full-bleed HSG campus photo (MUST be last).

\end{document}
```

Compile with `pdflatex file.tex` **three times** — `remember picture`
overlays need multiple passes to settle.

For the closest Gill Sans look, use `xelatex` or `lualatex`; the theme
auto-detects the compiler (Gill Sans Nova if licensed, else Gillius ADF,
else TeX Gyre Heros).

---

## 3. Global style rules (enforced by the theme)

The theme already supplies these — agents do NOT set them manually:

- HSG green primary colour: `HSGgreen` = `#00802F`
- Palette: `HSGgreenDark`, `HSGbluegrey`, `HSGsand`, `HSGcoral`, `HSGyellow`,
  `HSGtext`, `HSGmuted`

### HSGgreen is RESERVED — do NOT use it for titles or headings

`HSGgreen` has ONE job on content slides: marking the current section in
the left sidebar. Using it for frame titles, frame subtitles, column
headers, row headers, callout-box titles, or any heading-like text
creates a visual clash with the sidebar's progress cue.

| Where green is allowed | Where green is FORBIDDEN |
|---|---|
| Sidebar current section | `\frametitle{...}` |
| Page-number badge (chrome) | `\framesubtitle{...}` |
| `\hsgemph{word}` inline emphasis | Column headers like `\textbf{\color{HSGgreen} Title}` |
| Verdict callout chrome (coral) | `\fcolorbox{HSGgreen}{...}{...}` title labels |
| | Any sentence starting with "\textbf{\color{HSGgreen} ...}" |

Use `HSGmuted` or `HSGtext` (black) for titles. Use `HSGcoral` only for
warnings and negative verdicts. Use `\hsgemph{word}` for inline accents
inside body text, never for bulleting or for entire sentences.
- Slide-area contract: header 2.20 cm, content 5.80 cm, footer 1.00 cm,
  side margin 1.00 cm. Content fills the header/footer gap without overlap.
- Content slide chrome: small HSG logo bottom-left (`hsg-logo.png`), centred
  page number inside a green angular badge bottom-right.
- Frametitle is absolute-positioned at `x = \hsg@sidemargin` so it shares the
  exact same left edge as the body text.
- `\framesubtitle` inserts a green topic tag ABOVE the title. A `\vphantom`
  always reserves a line for the subtitle so the title's baseline is at the
  same Y on every slide (with or without subtitle).
- No Beamer navigation symbols.
- 16:9 widescreen aspect ratio.

Do NOT change these. Do NOT redefine `setbeamertemplate{frametitle}`,
`footline`, or `title page`.

---

## 4. Choosing the right slide for your content

The HSG master defines 18 unique layout types. Every one has a matching
Beamer helper in this theme. Use this decision table BEFORE writing a slide:

| You want to… | Master layout (German) | Beamer helper | Section |
|---|---|---|---|
| Open the deck with title + author + hero photo | *Titel Slide 1 / 2 / 3* | `\titlepage` in a `[plain]` frame (uses `\coverimage`) | 4.1 |
| Show the agenda / table of contents | *Agenda* | `\hsgagenda{ \item ... }` | 4.2 |
| Show title + one block of content (bullets, table, figure, prose) | *Titel und Content* | standard `\begin{frame}\frametitle{...}...\end{frame}` | 4.3 |
| Compare two concepts side-by-side | *Titel zwei Content* | `\begin{frame}` + native Beamer `columns[T]` | 4.4 |
| Show two images with captions | *Titel und zwei Bilder* / *Zwei Bilder mit Legende* | `\begin{frame}` + `columns[T]` + captions | 4.5 |
| Show a title line on its own (section opener with minimal chrome) | *Nur Titel* | `\begin{frame}\frametitle{...}\end{frame}` (empty body) | 4.6 |
| Divide major parts of the talk (Intro / Methods / Results / …) | *Titel Slide 2* | `\hsgsection{title}` / `\hsgsection[subtitle]{title}` | 4.7 |
| Split the deck into chapters (larger part separator) | *Kapiteltrenner 1 / 2* | `\hsgchapter{N}{title}` | 4.7b |
| Fill the whole slide with one image | *Bild Vollfläche* | `\hsgfullimage{path}` | 4.8 |
| Present a quotation on light background | *Zitat schwarze Schrift* | `\hsgquote{quote}{attribution}` | 4.9 |
| Present a quotation on green background | *Zitat weisse Schrift* | `\hsgquoteinverted{quote}{attribution}` | 4.9 |
| Present one large bold statement / takeaway | *Statement 1 / 2* | `\hsgstatement{text}` | 4.10 |
| Show presenter contact (never as a standalone slide — use the closing box) | *31_Contact / 32_Contact* | `\hsgclosingcontact{name}{email}` + `\hsgclosing` | 4.11 |
| Blank canvas for a custom-built slide | *Leer* | `\begin{frame}[plain]...\end{frame}` | 4.12 |
| Close the deck ("Thank you" / "Questions?") on the HSG campus photo | *Dank* | `\hsgclosing` (alias `\hsgthanks`) | 4.13 |

**Golden rule:** if the table above matches your intent, use the helper.
Do NOT hand-craft a layout that duplicates an existing one.

---

## 4.1 Title slide — `\titlepage`

Use for the first frame. Set `\coverimage{path}` in the preamble to supply
the hero photo on the right. The theme layers the HSG green badge *behind*
the photo so an L-shaped green frame peeks out at the photo's lower-left
(matching the official master's *Titel Slide 3* layout).

```latex
\coverimage{images/hero.jpg}
\begin{frame}[plain]\titlepage\end{frame}
```

Title/author block font sizes (Beamer pt, scaled from PPT master):

| Element | Beamer pt | PPT master equivalent |
|---|---|---|
| `\title`    | 22 pt | 40 pt Gill Sans Nova Light |
| `\subtitle` | 14 pt | 25 pt Gill Sans Nova Light |
| `\author`   |  9 pt | 14 pt Gill Sans Nova Body  |
| `\institute`|  8 pt | 12 pt Gill Sans Nova Body  |
| "From insight to impact" tagline | 6 pt | 10 pt |

## 4.1b Deck outline — `\hsgsetsections` + vertical left sidebar

Declare the deck's top-level outline ONCE in the preamble:

```latex
\hsgsetsections{Dataset, Methodology, Results, Acoustic test, Takeaways}
```

Then advance the progress counter by calling `\hsgsection{Name}` right
before the first slide of each section. `\hsgsection` is SILENT — it
does NOT render a divider slide, it only updates the sidebar.

Every content slide renders a vertical left sidebar (~2.2 cm wide) that
stacks the section names top-to-bottom:

- **Current section**: `HSGgreen`, bold, 7.5 pt.
- **All others**: `HSGmuted!80`, regular, 7 pt.

The sidebar reserves horizontal space automatically via
`\setbeamersize{sidebar width left=\hsg@sidebarwidth}`; body text is
narrowed accordingly. `[plain]` frames (title page, closing slide,
quotations, statements, full-bleed images) suppress the sidebar for a
clean canvas.

**Agenda guidance**: keep the bullet list in `\hsgagenda{...}` identical
to the `\hsgsetsections` list.

**Golden rule for outlines**: 4–6 sections max. Section names should be
short (1–2 words) because the sidebar is narrow.

## 4.2 Agenda — `\hsgagenda`

Use as the SECOND slide of every deck (right after the title). A
concrete-texture column on the right is enabled by default.

```latex
\hsgagenda{
  \item Context
  \item Methods
  \item Results
  \item Outlook
}
```

Override the texture: `\hsgagendaimage{path/to/image.jpg}` in the preamble.
Disable it entirely: `\hsgagendaimage{}` (empty argument).

## 4.3 Title + one content block — standard frame

Use for 80 % of slides. Body can be bullets, a table, a TikZ figure, or prose.

```latex
\begin{frame}
  \frametitle{Results}
  \framesubtitle{Key findings}        % optional green topic tag
  \begin{itemize}
    \item \hsgemph{Detection AUC} improved from 0.64 to 0.89 (+39 %).
    \item False-positive rate held at 2 %.
  \end{itemize}
\end{frame}
```

## 4.4 Title + two columns — native Beamer `columns`

Use for A/B comparisons, pros/cons, before/after.

```latex
\begin{frame}
  \frametitle{Two approaches}
  \begin{columns}[T]
    \column{0.5\textwidth}
      \textbf{\color{HSGgreen} Symmetric}
      \begin{itemize}\item Shared key\item Fast\end{itemize}
    \column{0.5\textwidth}
      \textbf{\color{HSGgreen} Asymmetric}
      \begin{itemize}\item Key pair\item Slow\end{itemize}
  \end{columns}
\end{frame}
```

## 4.5 Two images with captions

```latex
\begin{frame}
  \frametitle{Before and after}
  \begin{columns}[T]
    \column{0.5\textwidth}
      \includegraphics[width=\linewidth]{before.jpg}\\
      {\footnotesize\itshape Baseline system.}
    \column{0.5\textwidth}
      \includegraphics[width=\linewidth]{after.jpg}\\
      {\footnotesize\itshape Proposed system.}
  \end{columns}
\end{frame}
```

## 4.6 Title only (section opener, minimal chrome)

```latex
\begin{frame}
  \frametitle{Part II — Evaluation}
\end{frame}
```

## 4.7 Section advance — `\hsgsection`

`\hsgsection{Name}` advances the deck to the next section. It is SILENT
— no frame is rendered. Its only effect is to update the inline footer
progress display ("Section name · N / M") on every subsequent content
slide.

```latex
\hsgsection{Introduction}                            % advances progress
\hsgsection[ignored]{Introduction}                   % optional arg kept for backward compat
```

`\hsgsection` DOES NOT produce a divider slide. The section-separator
pattern from the original HSG master is intentionally omitted because
the inline footer progress already shows where the deck is.

Override the right-side image key (`\hsgsectionimage`) is kept for
backward compatibility but currently has no effect.

## 4.7b Chapter separator — `\hsgchapter`

Matches master layout *Kapiteltrenner*. Large chapter number + title,
optionally over a full-bleed background image. Use for deck-wide part
breaks (Part I / II / III). Heavier than `\hsgsection`.

```latex
\hsgchapter{02}{Methodology}
\hsgchapter[images/backdrop.jpg]{03}{Results}
```

## 4.8 Full-bleed image — `\hsgfullimage`

Image fills the whole slide, small HSG logo overlayed bottom-left, no footer.
Pre-crop the image to 16:9.

```latex
\hsgfullimage{images/turbine-hall.jpg}
```

## 4.9 Quotation — `\hsgquote` / `\hsgquoteinverted`

```latex
\hsgquote
  {The cloud is just somebody else's computer.}
  {Anonymous}

\hsgquoteinverted
  {The best way to predict the future is to invent it.}
  {Alan Kay}
```

## 4.10 One-line statement — `\hsgstatement`

Single bold sentence centred on the slide in HSG green. Use for key takeaways.

```latex
\hsgstatement{Security is a process, not a product.}
```

## 4.11 Contact info on the closing slide — `\hsgclosingcontact`

The HSG template does NOT use a separate "Contact" slide. Presenter contact
lives inside the translucent white box on the closing *Questions?* slide.
Set it in the preamble — `\hsgclosing` renders it automatically.

```latex
\hsgclosingcontact
  {Prof. Dr. Bruno Rodrigues}
  {bruno.rodrigues@unisg.ch}
\hsgclosing
```

Exactly two lines: `<title, First name Lastname>` bold, then the e-mail on
the line below (both in `HSGtext`, no green). Affiliation is NOT shown in
the box — it already appears on the title slide via `\institute{...}`.

Defaults: if `\hsgclosingcontact` is not set, the box falls back to
`\insertauthor` from the title block and omits the email.

The legacy `\hsgcontact{name}{email}{affiliation}` macro still exists for
backward compatibility, but do NOT add a standalone contact slide — put the
contact inside `\hsgclosing` via `\hsgclosingcontact`.

## 4.12 Blank canvas — `\begin{frame}[plain]`

Use only when no helper fits and you genuinely need the full 16×9 canvas.
Avoid unless absolutely necessary.

## 4.13 Closing slide — `\hsgclosing`

MUST be the last slide of every deck. Faithful reproduction of master
layout *31_Contact* (slideLayout32 in the PPTX):

- Full-bleed HSG campus photo (`hsg-closing-campus.jpg`).
- "Questions?" headline top-left in white. Override with
  `\hsgclosingtext{Custom headline.}` in the preamble.
- Translucent white box at Beamer `(12.06, 4.27)` cm, size
  `3.69 × 2.17` cm, 81 % opacity (matches master Rechteck 7).
- Inside the box: "University of St. Gallen" logo (`hsg-logo-en.png`)
  at the top, then the contact lines from `\hsgclosingcontact` at 5 pt.
- Bottom strip (`hsg-closing-logo-band.png`) with EQUIS, AACSB, AMBA
  accreditation logos and "From insight to impact" tagline — extracted
  pixel-accurate from master slide 5.

```latex
\hsgclosing                            % defaults to "Questions?"
\hsgclosingtext{Thank you.}\hsgclosing % custom headline
```

Override the background photo: `\hsgclosingphoto{path/to/image.jpg}`.

`\hsgthanks` is kept as a backward-compatible alias for `\hsgclosing`.

## 4.14 Inline emphasis — `\hsgemph`

```latex
Use \hsgemph{key term} to draw the reader's eye in HSG green bold.
```

---

## 5. Rules an agent MUST follow

1. **Never modify `beamerthemeHSG.sty`** unless the user explicitly asks.
2. **Always copy all image assets** listed in Section 1 next to the `.tex` file.
3. **Compile three times** with `pdflatex` (or `xelatex`).
4. **Do not redefine HSG colours.** Use the names in Section 3.
5. **Do not colour bullets.** Bullets are black by design. Accent with `\hsgemph{...}`.
6. **Do not load extra Beamer themes or colour themes.** `\usetheme{HSG}` is complete.
7. **Do not use `\usefonttheme`.** The theme handles fonts.
8. **Pick the helper that matches the intent** from Section 4. Do not
   reconstruct a layout by hand if a helper exists.
9. **Never rename exported commands.** Public API:
   `\coursefooter`, `\coverimage`, `\hsgemph`, `\hsgagenda`,
   `\hsgagendaimage`, `\hsgsetsections`, `\hsgsection`,
   `\hsgsectionimage`, `\hsgchapter`, `\hsgquote`, `\hsgquoteinverted`,
   `\hsgstatement`, `\hsgfullimage`, `\hsgclosing`, `\hsgclosingtext`,
   `\hsgclosingphoto`, `\hsgclosingcontact`, `\hsgthanks`, `\hsgcontact`.
10. **Always set `\hsgclosingcontact` in the preamble** so the presenter's
    name and email appear in the closing-slide box.
11. **Deck order**: `\titlepage` → `\hsgagenda` → content (with optional
    `\hsgsection` dividers) → `\hsgclosing`. Never omit agenda or closing.
12. **Verify the compiled PDF** per Section 8 before declaring the task done.
13. **Version every compiled PDF that leaves your working dir** (`-v1`,
    `-v2`, ...) — Nextcloud does not reliably show overwritten files.
14. **Never let content overflow a bounding box.** Every rendered slide
    MUST be pixel-checked for overflow before the task is done. Common
    offenders:
    - TikZ labels wider than their `minimum width=` box (for example a
      long tag like `5. INTERPRETATION` inside a 2.5 cm stage box).
      Always constrain TikZ label nodes with `text width=Xcm, align=center`
      so long strings wrap instead of spilling out.
    - Figures that appear tiny because the `width=` was left conservative
      — at 16×9 cm the usable width is ~14 cm, use `width=0.80-0.88\linewidth`
      for detail-rich charts rather than 0.5\linewidth.
    - Frame titles or bullet lines that cross into the footer area
      (check all slides that use `shrink=`).
    - `\fcolorbox` borders that bleed past 0.95\linewidth.
    Run `pdftoppm -r 120 out.pdf /tmp/check` and inspect each PNG; if ANY
    slide has overflow, fix it before declaring the task complete.

---

## 6. Common errors and fixes

| Symptom | Cause | Fix |
|---|---|---|
| Title slide missing logo / green frame misplaced | Only one or two `pdflatex` passes | Run three passes |
| Cover photo has no green L-frame around it | `hsg-badge.png` missing | Copy it into the working dir |
| Closing slide has no accreditation logos at the bottom | `hsg-closing-logo-band.png` missing | Copy it into the working dir |
| Closing box shows wrong logo (with Institute line) | Theme is using `hsg-logo-cover.png` in the box | Copy `hsg-logo-en.png` — the box requires the English-only variant |
| Frametitle and body text start at different x | You redefined `\setbeamertemplate{frametitle}` | Remove your override; the theme absolute-positions it |
| Content overlaps the footer | Body too tall after frametitle | Reduce content, split slide, or drop `\framesubtitle` |
| `"File hsg-logo.png not found"` | Asset missing | Copy ALL assets from Section 1 |
| `"Command \coursefooter already defined"` | You used `\newcommand` | Use the setter form: `\coursefooter{Name}` |
| Bullets render green | Custom `\setbeamercolor` in preamble | Remove it |
| Footer starts with `|` | Empty `\coursefooter` argument | Supply a course name or remove the line |
| Font looks generic | Compiled with `pdflatex` | Use `xelatex` + install Gillius ADF or Gill Sans Nova |
| Agenda lacks the concrete-texture column | `\hsgagendaimage{}` called with empty arg | Remove that line to restore default |
| Closing-box text doesn't fit | Name/email too long at 5 pt | Abbreviate the title, e.g. `Prof. B. Rodrigues` |

---

## 7. Layout patterns that work reliably

### 7.1 Boxed content: `\fcolorbox` + `\parbox` over TikZ absolute coordinates

```latex
\fcolorbox{HSGgreen}{HSGgreen!10}{\parbox{0.95\linewidth}{%
  \textbf{\color{HSGgreen} Title}\\[2pt]
  \scriptsize Content ...}}
```

### 7.2 Multi-column overviews: native Beamer `columns`

```latex
\begin{columns}[T]
  \column{0.32\textwidth}  \fcolorbox{...}{...}{...}
  \column{0.32\textwidth}  \fcolorbox{...}{...}{...}
  \column{0.32\textwidth}  \fcolorbox{...}{...}{...}
\end{columns}
```

### 7.3 Vertical budget per slide

Header (frametitle) ~2.2 cm, footer 1 cm. Usable content area ≈ 5.8 cm tall.
If it doesn't fit:

1. Split into two slides.
2. Drop `\framesubtitle` if redundant.
3. Shrink font one step.

### 7.4 Compile loop

```bash
pdflatex file.tex
pdflatex file.tex
pdflatex file.tex
```

### 7.5 Version-control-friendly output

Always write the compiled PDF with a version suffix so earlier revisions
stay accessible and Nextcloud shows the new file:

```bash
cp file.pdf file-v1.pdf   # bump: -v1, -v2, ...
```

---

## 8. Mandatory verification

Before declaring the task complete:

```bash
pdftoppm -png -r 120 presentation.pdf /tmp/pres-check
```

For each PNG, confirm:

- [ ] HSG logo bottom-left is not covered on content slides.
- [ ] Title-slide photo sits inside the green badge outline.
- [ ] Title and subtitle on the cover share the same left x (no indent offset).
- [ ] Frametitle (green subtitle + black title) shares the exact left x with the body bullets / columns.
- [ ] Green page-number badge bottom-right is visible with the number centred.
- [ ] No body text crosses below the footer divider.
- [ ] Agenda (slide 3) shows the concrete-texture column on the right.
- [ ] Closing slide shows: full-bleed campus photo, "Questions?" headline,
      translucent contact box (logo + name + email), bottom accreditation
      strip (EQUIS / AACSB / AMBA + tagline).
- [ ] `\framesubtitle` topic tags are not truncated.

If overlap is found, apply fixes from Section 7.3 and re-verify.

---

## 9. Reference

`example.tex` in this folder demonstrates every helper and every style rule.
Use it as a copy-paste source. The matching `example-v*.pdf` previews let
you verify visual fidelity before writing any new content.

The original HSG PowerPoint master (`HSG-slide-template.pptx`) and the
reference Tridonic talk (`HSG-Tridonic-WirelessTracking.pptx`) live one
directory up. All numeric positions/sizes in this theme were extracted
pixel-accurate from those files via their OOXML XML.
