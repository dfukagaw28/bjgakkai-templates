# 紀要「文化情報学」LaTeX / Word テンプレート（非公式・叩き台）

同志社大学文化情報学会 紀要『文化情報学』の
[執筆要項（2022年12月7日改訂）](https://www.bunkajoho.org/journal/jnl_yoko.html)
に基づいて作成したテンプレートです。**編集委員会の公式テンプレートではありません。**

1 つの Markdown ファイル（`sample.md`）から、LaTeX 版（`latex/sample.tex`）と
Word 版（`docx/sample.docx`）の両方を pandoc で生成できます。

## ファイル構成

| ファイル | 内容 |
| --- | --- |
| `sample.md` | 使用例兼説明書の原稿（LaTeX 版・Word 版の元） |
| `Makefile` | `sample.md` から `latex/sample.tex` と `docx/sample.docx` を生成 |
| `pandoc/bunkajoho.latex` | pandoc 用 LaTeX テンプレート |
| `pandoc/latex.lua` | LaTeX 用フィルタ（表・図・数式・番号なし見出し・付録・文献リスト） |
| `pandoc/docx.lua` | Word 用フィルタ（タイトル部・見出し番号・数式番号・図表番号・文献見出し） |
| `pandoc/bunkajoho.csl` | Word 版の引用・文献リスト書式（要項 7. を再現する CSL） |
| `pandoc/make-reference-docx.py` | 学会事務局の Word テンプレートから `docx/reference.docx` を作るスクリプト |
| `docx/reference.docx` | Word 版の書式見本（学会事務局の Word テンプレートにスタイルを追加したもの） |
| `docx/sample.docx` | Word 版の使用例（`sample.md` から生成） |
| `latex/bunkajoho.cls` | クラスファイル（jlreq + LuaLaTeX）。種別・タイトルページ・節番号・図表・脚注 |
| `latex/bunkajoho.bbx` | 文献リスト書式（biblatex, authoryear-comp ベース） |
| `latex/bunkajoho.cbx` | 本文中引用書式（`\citet` / `\citep`） |
| `latex/main.tex` | LaTeX 版の使用例兼説明書（手書き。LaTeX での書き方を説明。Overleaf 用 zip に入る） |
| `latex/main.pdf` | `main.tex` の出力 |
| `latex/sample.tex` | 使用例兼説明書（`sample.md` から生成。直接編集しない） |
| `latex/figure1.png` | 使用例の図（プレースホルダ） |
| `latex/sample.bib` | 執筆要項 7. の文献例をそのまま収録 |
| `latex/latexmkrc` | `latexmk sample` で LuaLaTeX + biber を実行 |

## 必要環境

- TeX Live 2023 以降（LuaLaTeX, jlreq, luatexja, biblatex, biber, 原ノ味フォント）
- Overleaf の場合: Menu → Compiler を **LuaLaTeX** に設定

## コンパイル

```sh
make          # sample.md → latex/sample.tex, docx/sample.docx
make pdf      # さらに latex/sample.pdf をビルド
make clean    # LaTeX の中間ファイルを削除
make overleaf # Overleaf 用の zip（dist/bunkajoho-latex.zip）を作る
```

LaTeX 版だけを使う場合は、`latex/main.tex` を書き換えて `latex/` で `latexmk main` としてビルドします。
Overleaf では `make overleaf` で作った zip を New Project → Upload Project でアップロードします。
Markdown から生成するには pandoc 3.1 以降が必要です。

## Markdown での書き方

- 先頭のメタデータに `type`（`paper` / `note` / `material` / `review`）、`title`、`subtitle`、`author`（複数可）、`abstract`、`bibliography` を書く
- 見出しは `#`（節）、`##`（項）、`###`（目）。番号は自動で付く。番号なしは `# 謝辞 {.unnumbered}`、付録は `# 付録の例 {.appendix}`
- 別行数式は `$$ ... $$`（通し番号が付く）。図は `![キャプション](file.png){width=90%}`、表はキャプション付きのパイプテーブル。2段抜きの図表は `::: wide` で囲む（LaTeX 版のみ。図の幅は版面幅が基準になる）
- 引用は `@key`（Gibson （1979））、`[@key]`（（佐伯・佐々木, 1990））、`@key [p.123]`、`Simon [-@a; -@b]`（Simon （1973, 1981））
- 文献リストは `::: {#refs}` の位置に「文献」の見出し付きで出力される
- 式・図・表の番号は、本文中では「式 (2)」「図 1」のように直接書く

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

## 文献（.bib）の書き方

- 和文文献には `langid = {japanese}` を付ける（「・」「（編）」『 』「．」に切り替わる）
- 和文著者は `author = {佐伯, 胖 and 佐々木, 正人}` のように「姓, 名」で書く
- 和文文献を欧文とアルファベット順に混在させるには `sortname = {Saeki, Yutaka}` を付ける
- 翻訳書の併記は `addendum` に書く（丸括弧は自動）
- 出版社名などに and を含む場合は `publisher = {{Simon and Schuster}}` のように二重の波括弧で囲む
- Word 版（CSL）では `langid` の有無で和文・欧文を判定し、和文文献はキーの順に並ぶ。欧文文献には `langid` を付けず、和文文献のキーはローマ字（姓＋年）にする

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
