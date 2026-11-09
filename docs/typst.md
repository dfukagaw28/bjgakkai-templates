# Typst で書く

[Typst](https://typst.app/) は、LaTeX より短く簡単な書き方で原稿を PDF にできる組版ソフトです。
見出しは `=`、強調は `*...*` のように、Markdown に近い書き方をします。
このテンプレートの Typst 版は、LaTeX 版と同じ体裁（字詰め・文字サイズ・タイトル部・見出し・文献リスト）になるように作ってあります。

> [!NOTE]
> 執筆要項では、原稿は LaTeX または Word で作ることになっています。
> Typst で作った原稿を受け付けてもらえるかどうかは、投稿の前に編集委員会に確認してください。

Typst は次の 2 つの方法で使えます。どちらでも同じファイル一式を使います。

| 方法 | こんな人に | 必要なもの |
| --- | --- | --- |
| [ブラウザ（typst.app）](#ブラウザtypstappで書く) | インストールせずに使いたい人 | ブラウザ（Overleaf と同じ感覚で使える） |
| [VS Code](#vs-code-で書く) | 自分のパソコンで書きたい人 | VS Code、拡張機能 Tinymist、フォント |

## テンプレートのファイル

[zip ファイル](https://github.com/dfukagaw28/bjgakkai-templates/releases/latest/download/bunkajoho-typst.zip) をダウンロードして展開すると、次のファイルが入っています。

| ファイル | 役割 | 書き換える？ |
| --- | --- | --- |
| `main.typ` | 原稿の本体（和文の見本） | **書き換える** |
| `main-en.typ` | 英語論文の見本 | 英語で書くときに使う（[下記](#英語で書く場合)） |
| `sample.yml` | 引用する文献のデータ | **書き換える** |
| `figure1.png` | 見本の図 | 自分の図に差し替える |
| `bunkajoho.typ`、`bunkajoho.csl` | 紀要の体裁を決めるファイル | 書き換えない |

完成見本の PDF：[和文](../typst/main.pdf)／[英語論文](../typst/main-en.pdf)

## ブラウザ（typst.app）で書く

1. [typst.app](https://typst.app/) を開き、**Sign up** からアカウントを作ります（無料プランで十分です）。
2. ダッシュボードで **Empty document** を選び、プロジェクトを作ります。名前は自由です。
3. 左のファイル一覧に最初からある `main.typ` を削除します（ファイル名の右のメニュー → **Delete**）。
4. 展開した zip の中のファイルを**すべて**選び、左のファイル一覧にドラッグ＆ドロップしてアップロードします。
   ファイル一覧の上にあるアップロードのボタンからも選べます。
5. `main.typ` を開くと、右側に PDF が表示されます。

書き換えると、右側の PDF はすぐに更新されます（Overleaf のように Recompile を押す必要はありません）。
PDF をダウンロードするには、画面右上のダウンロードのボタンを押します。

> [!TIP]
> 指導教員や共著者と一緒に編集するには、右上の **Share** から招待します。

## VS Code で書く

### 準備（最初の 1 回だけ）

1. [VS Code](https://code.visualstudio.com/) をインストールします。
2. VS Code の左の **拡張機能**（四角が 4 つのアイコン）で `Tinymist` を検索し、**Tinymist Typst** をインストールします。
   Typst 本体も一緒に入るので、別にインストールする必要はありません。
3. フォントをインストールします。テンプレートは「Noto Serif CJK JP」（明朝）と「Noto Sans CJK JP」（ゴシック）を使います。
   - [Noto Serif CJK JP](https://github.com/notofonts/noto-cjk/releases/download/Serif2.003/07_NotoSerifCJKjp.zip) と [Noto Sans CJK JP](https://github.com/notofonts/noto-cjk/releases/download/Sans2.004/06_NotoSansCJKjp.zip) の zip をダウンロードして展開する
   - 中の `.otf` ファイルを選んで右クリック → **インストール**（Mac ではダブルクリック → **インストール**）
   - インストールしたら VS Code を再起動する

   名前の似た「Noto Serif JP」「Noto Sans JP」（Google Fonts で配布されているもの）では代わりになりません。

### 書く

1. zip を展開したフォルダを VS Code で開きます（**ファイル** → **フォルダーを開く**）。
2. `main.typ` を開き、右上のプレビューのボタン（虫めがねの付いたアイコン）を押すと、横に PDF のプレビューが出ます。
   書き換えると、プレビューはすぐに更新されます。
3. PDF を作るには、`main.typ` の 1 行目の上に小さく出ている **Export PDF** を押します。
   見当たらなければ、**F1** を押して `export pdf` と入力し、Typst の PDF 出力のコマンドを選びます。
   `main.pdf` が同じフォルダにできます。

## 表題・著者名・要旨を書き換える

`main.typ` の先頭付近にある次の部分を書き換えます。

```typst
#show: bunkajoho.with(
  type: "paper",
  title: [紀要「文化情報学」Typst テンプレートの使い方],
  subtitle: [執筆要項に基づくテンプレートと文献スタイル],
  authors: [同志社 太郎・文化 花子],
  abstract: [
    本稿は、……
  ],
)
```

- `type` は種別です。研究論文は `"paper"`、研究ノートは `"note"`、資料紹介は `"material"`、書評は `"review"` にします。
- 副題がなければ、`subtitle:` の行を消します。
- 複数の著者は「・」で区切ります。
- 要旨は `abstract: [` と `],` の間に書きます。

## 本文を書く

`main.typ` の本文の部分を、見本を参考に書き換えます。よく使う書き方は次のとおりです。

| 書きたいもの | 書き方 |
| --- | --- |
| 段落を変える | 空行を 1 行入れる |
| 節・項・目の見出し（番号は自動） | 行頭に `= 見出し`、`== 見出し`、`=== 見出し` |
| 注（脚注） | `本文#footnote[注の内容。]` |
| 式（別行・番号付き） | `$ E = m c^2 $ <eq:energy>`（`$` の内側の前後に空白） |
| 文中の式 | `$x^2$`（空白を入れない） |
| 図・表・式の参照 | `@fig:example`、`@tab:example`、`@eq:energy` |
| 謝辞 | `#acknowledgments[謝辞の内容。]` |
| 付録 | 文献リストの後に `#show: appendix` と書き、その後に `= 見出し` |

半角の `# * _ $ @ < > [ ] \` などは Typst の命令に使われます。
本文にそのまま出したいときは、`\#` のように前に `\` を付けます。全角の文字はそのまま書いて構いません。

図・表の書き方は、見本の `main.typ` の「図表」の節を見てください。
図は段の上端に置かれます。2 段にまたがる大きな図表は `scope: "parent"` を加えます。

## 文献を引用する

### 文献データを書く

引用する文献は `sample.yml` に書きます。
LaTeX 版の `sample.bib` とは書き方が違う（Typst 用の **Hayagriva** という形式）ので注意してください。

```yaml
gibson1979:
  type: book
  author: Gibson, J. J.
  date: 1979
  title: The Ecological Approach to Visual Perception
  publisher:
    name: Houghton Mifflin
    location: Boston

saeki1990:
  type: anthology
  editor: ["佐伯, 胖", "佐々木, 正人"]
  date: 1990
  title: アクティブ・マインド
  publisher:
    name: 東京大学出版会
    location: 東京
  language: ja
```

- 1 行目（`gibson1979:`）が**キー**です。本文で引用するときにこの名前を使います。
- 著者は「姓, 名」で書きます。複数の著者は `["姓, 名", "姓, 名"]` のように並べます。
- **和文文献には `language: ja` を付けます。** これで「・」「（編）」『 』「．」などの和文の書式になります。
- 文献リストはキーの順に並ぶので、和文文献のキーは**ローマ字**（姓＋年）にします。
- 種類（`type`）は、雑誌論文 `article`、書籍 `book`、編集書 `anthology`、編集書の中の章 `chapter`、報告書 `report`、学位論文 `thesis` などです。
  雑誌論文の雑誌名や章の入っている本は `parent:` の下に書きます。`sample.yml` の例をまねてください。
- 訳書などの併記は `note:` に書きます（全角の（ ）で囲まれて末尾に付きます）。

文献ごとの書き方の決まりは [参考文献の書き方](references.md) を見てください。

### 本文で引用する

| 書きたいもの | 書き方 | 出力 |
| --- | --- | --- |
| 文の一部として | `#cite(<gibson1979>, form: "prose")` | Gibson（1979） |
| 括弧の中に | `@saeki1990` | （佐伯・佐々木, 1990） |
| ページを示す | `#cite(<haugeland1987>, form: "prose", supplement: [p.123])` | Haugeland（1987, p.123） |
| 複数の文献 | `@anzai1992 @joshi1981` | （安西 他, 1992; Joshi et al., 1981） |

引用した文献は、`#bibliography("sample.yml")` の位置に「文献」という見出しのもとに自動で並びます。
引用していない文献は載りません。

> [!WARNING]
> Typst では、同じ著者の複数の文献が「（Simon, 1973; 1981）」のように「;」で区切られます（要項では「,」）。
> 要項どおりにしたい場合は、次のように手で書いてください。
>
> ```typst
> Simon（#cite(<simon1973>, form: "year"), #cite(<simon1981>, form: "year")）
> ```
>
> ただしこの書き方では、同じ著者・同じ年の文献を区別する「1986a」「1986b」の a, b が付きません。

## 英語で書く場合

英語論文は `main-en.typ` を使います。
`main-en.typ` の先頭の `english: true` によって、種別（Research Paper など）、Acknowledgments・References・Appendix の見出し、Figure・Table のキャプションが英語になり、引用の括弧が半角になります。
副題がある場合は、表題の後にコロンを付けて次の行に出ます。

- typst.app では、`main-en.typ` を開くと、その PDF が表示されます（`main.typ` は消しても構いません）。
- VS Code では、`main-en.typ` を開いてプレビューします。

## うまくいかないとき

| 症状 | 対処 |
| --- | --- |
| 「unknown font family」という警告が出る、和文の字形がおかしい | フォントが入っていません。VS Code の場合は[準備](#準備最初の-1-回だけ)の 3. を、typst.app の場合は [Issues](https://github.com/dfukagaw28/bjgakkai-templates/issues) で知らせてください |
| 「file not found」というエラーが出る | `bunkajoho.typ`、`bunkajoho.csl`、`sample.yml`、画像ファイルが `main.typ` と同じ場所にあるか確かめてください |
| 「label does not exist」というエラーが出る | 引用したキーが `sample.yml` にないか、綴りが違っています |
| 和文文献が欧文の書式（「&」「(Eds.)」）になる | その文献に `language: ja` を付けてください |
| 文献リストの順番がおかしい | 和文文献のキーをローマ字（姓＋年）にしてください |

ほかに困ったことがあれば [よくある質問](faq.md) を見るか、[Issues](https://github.com/dfukagaw28/bjgakkai-templates/issues) で知らせてください。

[← README に戻る](../README.md)
