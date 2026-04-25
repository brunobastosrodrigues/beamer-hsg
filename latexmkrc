# HSG Beamer template — latexmk default build configuration.
#
# Default: pdflatex (Lato fallback). For the official Gill-Sans-Nova
# look, switch $pdf_mode to 5 (xelatex). The theme will pick up the
# vendored Gillius ADF OTFs in fonts/ automatically.
#
# Overleaf: in Project Settings > Compiler, choose pdfLaTeX or XeLaTeX
# to match this setting.

$pdf_mode    = 1;       # 1 = pdflatex, 5 = xelatex, 4 = lualatex
$max_repeat  = 4;       # remember-picture overlays need 3+ passes

$pdflatex    = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';
$xelatex     = 'xelatex  -interaction=nonstopmode -synctex=1 %O %S';
$lualatex    = 'lualatex -interaction=nonstopmode -synctex=1 %O %S';

# Files to clean with `latexmk -c`
$clean_ext   = 'aux log nav out snm toc vrb synctex.gz fls fdb_latexmk';
