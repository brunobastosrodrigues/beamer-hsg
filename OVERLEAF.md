# Using this template on Overleaf

The repo is private, so we cannot use Overleaf's "Import from GitHub"
button. Instead, upload a release ZIP. Two minutes, two routes.

## Route A — From a GitHub release (recommended)

1. **On the GitHub repo page**, open *Releases* in the right column,
   pick the latest tag (e.g. `v0.2.0`), and click
   *Source code (zip)*.
2. **On Overleaf**, *New Project → Upload Project*, drop the ZIP.
3. **Project Settings** (top-left menu) → *Compiler*:
   - **pdfLaTeX** for the Lato fallback (always works).
   - **XeLaTeX** for the official Gill-Sans-Nova look (the vendored
     `fonts/GilliusADF-*.otf` files are picked up automatically).
4. Open `example/skeleton.tex` (or copy it to `main.tex` and set it as
   *Main document* in Project Settings → Main document).
5. Replace every `TODO` marker, click *Recompile*. The first compile
   takes ~30 s while Overleaf indexes the fonts; later compiles are
   cached.

## Route B — Local clone, ZIP, upload

If you have the repo cloned locally:

```bash
cd ~/projects/beamer-hsg
git archive --format=zip --output=/tmp/beamer-hsg.zip HEAD
# Upload /tmp/beamer-hsg.zip to Overleaf via "New Project → Upload Project"
```

This is also useful for shipping a deck to a collaborator who does not
have GitHub access — the ZIP is fully self-contained.

## What's in the ZIP

```
beamerthemeHSG.sty          theme — do not edit
latexmkrc                   default compile config
hsg-*.pdf, hsg-*.png, *.jpg every asset (logos, photos, accreditation)
fonts/GilliusADF-*.otf      vendored open Gill-Sans-Nova substitute
fonts/LICENSE-Gillius-ADF.txt  GPL-2+FE licence statement
example/skeleton.tex      minimal compileable starter
example/demo-using-the-template.tex  20-page tutorial deck
example.tex, example-v1.pdf the showcase deck
helpers.json                machine-readable API manifest
AGENTS.md                   reference for coding agents
README.md                   human-oriented overview
```

## Tips

- **Compiler-mismatch symptom**: blank PDF, log says
  `fontspec error: "no-glyph"`. You're on pdfLaTeX while the deck
  expects xelatex (or vice versa). Switch in *Project Settings*.
- **Slow first compile**: Overleaf re-indexes the OTFs in `fonts/` on
  upload; subsequent compiles use the cache.
- **Photo missing from cover**: Overleaf project root must contain a
  file matching the `\coverimage{...}` path. Drop your hero photo into
  the project root and reference it by filename.
- **Three-pass requirement**: latexmk in `latexmkrc` is set to
  `$max_repeat = 4`; Overleaf's recompile button runs latexmk
  internally, so this is automatic.
