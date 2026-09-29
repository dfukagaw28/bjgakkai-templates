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

- [ ] **コンパイル未検証**。最初のビルドで以下を修正済みだが、その後のビルドが未完了:
  - `abstract` 環境の再定義 → `\RenewDocumentEnvironment`
  - `zw` 単位 → `\zw`（luatexja）
  - `\ifentryjapanese` の二重定義 → `\providecommand`
  - `\citep` の括弧切替（`\AtEveryCitekey` + `\global\let`）
- [x] 判型・字詰め・タイトルページ・見出しを学会事務局の Word テンプレート（2024年10月更新）に合わせた
  - A4 / 本文 9pt / 行送り 14.4pt / 2段組（24字×49行×2段）/ 天 33mm・左右 約25mm
  - ページ番号・柱なし（ページ番号は事務局が付ける）、要旨の見出しなし
  - フォントは原ノ味のまま（Word 版の MS 明朝・Times New Roman には合わせない）
- [ ] 和文文献の句読点（「．」「，」）が要項の例と一致するか出力を確認
- [ ] `\citep` で和文・欧文が混在するときの括弧の扱いを確認
- [ ] 英語論文（`english` オプション）の出力確認
