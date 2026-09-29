# sample.md から LaTeX 版（latex/sample.tex）と Word 版（docx/sample.docx）を生成する
#   make          … latex/sample.tex と docx/sample.docx を生成
#   make pdf      … さらに latex/sample.pdf をビルド（LuaLaTeX + biber）
#   make clean    … LaTeX の中間ファイルを削除
#   make reference-docx REF=<学会の Word テンプレート.docx> … docx/reference.docx を作り直す

PANDOC ?= pandoc
# east_asian_line_breaks: 日本語の文中の改行を空白にしない
READER := markdown-auto_identifiers+east_asian_line_breaks
WRAP := --wrap=preserve

.PHONY: all pdf clean reference-docx

all: latex/sample.tex docx/sample.docx

latex/sample.tex: sample.md pandoc/bunkajoho.latex pandoc/latex.lua
	$(PANDOC) $< -f $(READER) $(WRAP) --biblatex \
	  --template=pandoc/bunkajoho.latex --lua-filter=pandoc/latex.lua -o $@

docx/sample.docx: sample.md latex/sample.bib latex/figure1.png pandoc/bunkajoho.csl pandoc/docx.lua docx/reference.docx
	$(PANDOC) $< -f $(READER) --resource-path=.:latex \
	  --citeproc --csl=pandoc/bunkajoho.csl \
	  --lua-filter=pandoc/docx.lua --reference-doc=docx/reference.docx -o $@

pdf: latex/sample.tex
	cd latex && latexmk sample

clean:
	cd latex && latexmk -c sample

reference-docx:
	@test -n "$(REF)" || { echo "usage: make reference-docx REF=<Word テンプレート.docx>"; exit 1; }
	python3 pandoc/make-reference-docx.py "$(REF)" docx/reference.docx
