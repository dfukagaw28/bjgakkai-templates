# 紀要「文化情報学」LaTeX テンプレート（非公式・叩き台）

同志社大学文化情報学会 紀要『文化情報学』の
[執筆要項（2022年12月7日改訂）](https://www.bunkajoho.org/journal/jnl_yoko.html)
に基づいて作成した LaTeX テンプレートです。**編集委員会の公式テンプレートではありません。**

## ファイル構成

テンプレート一式は `latex/` にあります。

| ファイル | 内容 |
| --- | --- |
| `latex/bunkajoho.cls` | クラスファイル（jlreq + LuaLaTeX）。種別・タイトルページ・節番号・図表・脚注 |
| `latex/bunkajoho.bbx` | 文献リスト書式（biblatex, authoryear-comp ベース） |
| `latex/bunkajoho.cbx` | 本文中引用書式（`\citet` / `\citep`） |
| `latex/sample.tex` | 使用例兼説明書 |
| `latex/sample.bib` | 執筆要項 7. の文献例をそのまま収録 |
| `latex/latexmkrc` | `latexmk sample` で LuaLaTeX + biber を実行 |

## 必要環境

- TeX Live 2023 以降（LuaLaTeX, jlreq, luatexja, biblatex, biber, 原ノ味フォント）
- Overleaf の場合: Menu → Compiler を **LuaLaTeX** に設定

## コンパイル

```sh
cd latex
latexmk sample
```

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
