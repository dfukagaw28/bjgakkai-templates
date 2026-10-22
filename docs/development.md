# 開発者向け情報

テンプレートの構成・ビルド方法・組版の仕様・TODO をまとめたページです。
利用者向けの説明は [README](../README.md) から各ページへ進んでください。

## ファイル構成

| ファイル | 内容 |
| --- | --- |
| [`sample.md`](../sample.md) | Markdown 版の使用例兼説明書（`latex/sample.tex` の元） |
| [`docx/sample.md`](../docx/sample.md) | Word 版の使用例兼説明書の原稿（`docx/sample.docx` の元。Word での書き方を説明） |
| [`Makefile`](../Makefile) | `sample.md` から `latex/sample.tex` を、`docx/sample.md` から `docx/sample.docx` を生成 |
| [`pandoc/bunkajoho.latex`](../pandoc/bunkajoho.latex) | pandoc 用 LaTeX テンプレート |
| [`pandoc/latex.lua`](../pandoc/latex.lua) | LaTeX 用フィルタ（表・図・数式・番号なし見出し・付録・文献リスト） |
| [`pandoc/docx.lua`](../pandoc/docx.lua) | Word 用フィルタ（タイトル部・見出し番号・数式番号・図表番号・文献見出し） |
| [`pandoc/bunkajoho.csl`](../pandoc/bunkajoho.csl) | Word 版の引用・文献リスト書式（要項 7. を再現する CSL） |
| [`pandoc/make-reference-docx.py`](../pandoc/make-reference-docx.py) | 学会事務局の Word テンプレートから `docx/reference.docx` を作るスクリプト |
| [`docx/reference.docx`](../docx/reference.docx) | Word 版の書式見本（学会事務局の Word テンプレートにスタイルを追加したもの） |
| [`docx/sample.docx`](../docx/sample.docx) | Word 版の使用例（`docx/sample.md` から生成。直接編集しない） |
| [`latex/bunkajoho.cls`](../latex/bunkajoho.cls) | クラスファイル（jlreq + LuaLaTeX）。種別・タイトルページ・節番号・図表・脚注 |
| [`latex/bunkajoho.bbx`](../latex/bunkajoho.bbx) | 文献リスト書式（biblatex, authoryear-comp ベース） |
| [`latex/bunkajoho.cbx`](../latex/bunkajoho.cbx) | 本文中引用書式（`\citet` / `\citep`） |
| [`latex/main.tex`](../latex/main.tex) | LaTeX 版の使用例兼説明書（手書き。LaTeX での書き方を説明。Overleaf 用 zip に入る） |
| [`latex/main.pdf`](../latex/main.pdf) | `main.tex` の出力 |
| [`latex/sample.tex`](../latex/sample.tex) | 使用例兼説明書（`sample.md` から生成。直接編集しない） |
| [`latex/figure1.png`](../latex/figure1.png) | 使用例の図（プレースホルダ） |
| [`latex/sample.bib`](../latex/sample.bib) | 執筆要項 7. の文献例をそのまま収録 |
| [`latex/latexmkrc`](../latex/latexmkrc) | `latexmk sample` で LuaLaTeX + biber を実行 |

## 必要環境

- TeX Live 2023 以降（LuaLaTeX, jlreq, luatexja, biblatex, biber, 原ノ味フォント）
- Overleaf の場合: Menu → Compiler を **LuaLaTeX** に設定

## コンパイル

```sh
make          # sample.md → latex/sample.tex, docx/sample.md → docx/sample.docx
make pdf      # さらに latex/sample.pdf と latex/main.pdf をビルド
make clean    # LaTeX の中間ファイルを削除
make overleaf # Overleaf 用の zip（dist/bunkajoho-latex.zip）を作る
```

LaTeX 版だけを使う場合は、`latex/main.tex` を書き換えて `latex/` で `latexmk main` としてビルドします。
Overleaf では `make overleaf` で作った zip を New Project → Upload Project でアップロードします。
Markdown から生成するには pandoc 3.1 以降が必要です。

## 配布

README の「Overleaf で開く」「zip をダウンロード」は、GitHub Releases の最新版に添付された
`bunkajoho-latex.zip` を指しています（`releases/latest/download/bunkajoho-latex.zip`）。
リリースを作るときは `make overleaf` で作った `dist/bunkajoho-latex.zip` を添付してください。

## 基本的な使い方

```latex
\documentclass[paper]{bunkajoho}   % paper / note / material / review / english / draft
\addbibresource{refs.bib}
\title{表題}
\author{著者名}
\begin{abstract} ... \end{abstract}
\begin{document}
\maketitle
...
\printbibliography
\end{document}
```

## 状態・TODO

- [x] コンパイル確認済み（TeX Live 2023, LuaLaTeX + biber）
- [x] 文献スタイルを要項 7. の例に合わせた
  - 本文中の引用は、和文論文では全角（ ）、英語論文では半角 ( )。例: Gibson （1979）、（佐伯・佐々木, 1990）
  - 同一著者・同一年は「1990a, 1990b」と年を省略しない
  - 文献リストは「Cohen, P. R. & Levesque, H. J. (1985). 表題. 雑誌名, **巻**(号), 頁.」の形
- [x] 判型・字詰め・タイトルページ・見出しを刊行された論文 PDF（InDesign 組版）の実測値に合わせた
  - A4 / 本文 10bp / 行送り 14.6bp / 2段組（22字×46行×2段）/ 段間 22.5bp / 左右の余白 約23.4mm
  - 節見出し 11.5bp（2行取り）、項見出し 10bp、図表キャプション 9bp ゴシック、脚注 8.5bp、文献リスト 9bp
  - 種別 10bp・表題 16bp・副題 12bp・著者名 12bp（いずれもゴシック）、要旨 9bp（行送り 12bp）
  - 種別ラベルの下に版面幅の水平線、ページ番号・柱なし（ページ番号は事務局が付ける）、要旨の見出しなし
  - フォントは原ノ味のまま（刊行版のリュウミン・新ゴには合わせない）
  - 学会事務局の Word テンプレート（本文 9pt・1段22字）は、刊行版の字詰めに合わせたものと考えられる
- [ ] 付録の見出しは刊行版では 10bp だが、現在は節見出しと同じ 11.5bp
- [ ] 和文の雑誌論文は要項に例がないため、「『誌名』, **巻**（号）, 頁．」としている。日本心理学会の手引きに合わせるか要確認
- [ ] 英語論文（`english` オプション）の出力確認
- [ ] Word 版（`docx/sample.docx`）を Word で開いて体裁を確認（生成環境に Word / LibreOffice がなく、目視確認はしていない）
- [ ] Word 版の本文中引用で、和文文献の「佐伯・佐々木（1990）」の前後に空白が入る（CSL の制約）

[← README に戻る](../README.md)
