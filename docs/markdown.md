# Markdown で書く

Markdown と pandoc に慣れている人向けの方法です。
1 つの Markdown ファイルから、LaTeX 版と Word 版の両方を作れます。
見本は [`sample.md`](../sample.md) です。

ビルドには pandoc 3.1 以降が必要です（LaTeX 版の PDF を作るには TeX も必要）。
手順は [開発者向け情報](development.md#コンパイル) を参照してください。

## 書き方

- 先頭のメタデータに `type`（`paper` / `note` / `material` / `review`）、`title`、`subtitle`、`author`（複数可）、`abstract`、`bibliography` を書く
- 見出しは `#`（節）、`##`（項）、`###`（目）。番号は自動で付く。番号なしは `# 謝辞 {.unnumbered}`、付録は `# 付録の例 {.appendix}`
- 別行数式は `$$ ... $$`（通し番号が付く）。図は `![キャプション](file.png){width=90%}`、表はキャプション付きのパイプテーブル。2段抜きの図表は `::: wide` で囲む（LaTeX 版のみ。図の幅は版面幅が基準になる）
- 引用は `@key`（Gibson （1979））、`[@key]`（（佐伯・佐々木, 1990））、`@key [p.123]`、`Simon [-@a; -@b]`（Simon （1973, 1981））
- 文献リストは `::: {#refs}` の位置に「文献」の見出し付きで出力される
- 式・図・表の番号は、本文中では「式 (2)」「図 1」のように直接書く

## 文献データ（.bib）の書き方

- 和文文献には `langid = {japanese}` を付ける（「・」「（編）」『 』「．」に切り替わる）
- 和文著者は `author = {佐伯, 胖 and 佐々木, 正人}` のように「姓, 名」で書く
- 和文文献を欧文とアルファベット順に混在させるには `sortname = {Saeki, Yutaka}` を付ける
- 翻訳書の併記は `addendum` に書く（丸括弧は自動）
- 出版社名などに and を含む場合は `publisher = {{Simon and Schuster}}` のように二重の波括弧で囲む
- Word 版（CSL）では `langid` の有無で和文・欧文を判定し、和文文献はキーの順に並ぶ。欧文文献には `langid` を付けず、和文文献のキーはローマ字（姓＋年）にする

[← README に戻る](../README.md)
