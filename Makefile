# Markdown から LaTeX 版の見本（latex/sample.tex）と Word 版の見本（docx/sample.docx）を生成する
#   sample.md      → latex/sample.tex（Markdown 利用者向けの見本）
#   docx/sample.md → docx/sample.docx（Word 利用者向けの見本）
#   make          … latex/sample.tex と docx/sample.docx を生成
#   make pdf      … さらに latex/sample.pdf をビルド（LuaLaTeX + biber）
#   make clean    … LaTeX の中間ファイルを削除
#   make overleaf … Overleaf 用の zip（dist/bunkajoho-latex.zip）を作る
#   make typst    … Typst 版の見本 PDF（typst/main.pdf, main-en.pdf）を作る
#   make typst-zip … Typst 版の zip（dist/bunkajoho-typst.zip）を作る
#   make reference-docx REF=<学会の Word テンプレート.docx> … docx/reference.docx を作り直す

PANDOC ?= pandoc
# east_asian_line_breaks: 日本語の文中の改行を空白にしない
READER := markdown-auto_identifiers+east_asian_line_breaks
WRAP := --wrap=preserve

.PHONY: all pdf clean overleaf typst typst-zip reference-docx

all: latex/sample.tex docx/sample.docx

latex/sample.tex: sample.md pandoc/bunkajoho.latex pandoc/latex.lua
	$(PANDOC) $< -f $(READER) $(WRAP) --biblatex \
	  --template=pandoc/bunkajoho.latex --lua-filter=pandoc/latex.lua -o $@

docx/sample.docx: docx/sample.md latex/sample.bib latex/figure1.png pandoc/bunkajoho.csl pandoc/docx.lua docx/reference.docx
	$(PANDOC) $< -f $(READER) --resource-path=.:latex \
	  --citeproc --csl=pandoc/bunkajoho.csl \
	  --lua-filter=pandoc/docx.lua --reference-doc=docx/reference.docx -o $@

pdf: latex/sample.tex
	cd latex && latexmk sample main main-en

clean:
	cd latex && latexmk -c sample main main-en

# Overleaf 用: 手書きの見本 main.tex（和文）・main-en.tex（英語）とクラス・文献スタイル一式（生成物の sample.tex は含めない）
OVERLEAF_FILES := main.tex main-en.tex bunkajoho.cls bunkajoho.bbx bunkajoho.cbx sample.bib figure1.png latexmkrc

overleaf: $(addprefix latex/,$(OVERLEAF_FILES))
	mkdir -p dist
	rm -f dist/bunkajoho-latex.zip
	cd latex && zip -q ../dist/bunkajoho-latex.zip $(OVERLEAF_FILES)

# Typst 版: typst コマンドがなければ quarto に同梱の typst を使う
TYPST ?= $(shell command -v typst >/dev/null 2>&1 && echo typst || echo quarto typst)
TYPST_FILES := main.typ main-en.typ bunkajoho.typ bunkajoho.csl sample.yml figure1.png

typst: typst/main.pdf typst/main-en.pdf

typst/%.pdf: typst/%.typ typst/bunkajoho.typ typst/bunkajoho.csl typst/sample.yml typst/figure1.png
	$(TYPST) compile $< $@

typst-zip: $(addprefix typst/,$(TYPST_FILES))
	mkdir -p dist
	rm -f dist/bunkajoho-typst.zip
	cd typst && zip -q ../dist/bunkajoho-typst.zip $(TYPST_FILES)

reference-docx:
	@test -n "$(REF)" || { echo "usage: make reference-docx REF=<Word テンプレート.docx>"; exit 1; }
	python3 pandoc/make-reference-docx.py "$(REF)" docx/reference.docx
