# Overleaf で書く

[Overleaf](https://www.overleaf.com/) は、ブラウザだけで LaTeX の原稿を書いて PDF にできるウェブサービスです。
ソフトのインストールは要りません。
LaTeX を使ったことがなくても、このテンプレートの見本を書き換えていけば原稿を作れます。

**全体の流れ**

1. Overleaf のアカウントを作る
2. テンプレートを開く
3. 表題・著者名・要旨を書き換える
4. 本文を書く
5. 文献を引用する
6. PDF をダウンロードする

## 1. Overleaf のアカウントを作る

[Overleaf の登録ページ](https://www.overleaf.com/register) を開き、
メールアドレスとパスワードを入力するか、Google アカウントなどで登録します。
無料プランで十分です。

## 2. テンプレートを開く

Overleaf にログインした状態で、次のリンクをクリックします。

**[Overleaf でテンプレートを開く](https://www.overleaf.com/docs?snip_uri=https://github.com/dfukagaw28/bjgakkai-templates/releases/latest/download/bunkajoho-latex.zip&engine=lualatex)**

確認画面が出たら、プロジェクトを作成するボタンを押します。
自分専用のプロジェクト（原稿一式）ができ、数秒後に見本の PDF が表示されます。

<details>
<summary>リンクがうまく開けない場合（zip をアップロードする方法）</summary>

1. [zip ファイル](https://github.com/dfukagaw28/bjgakkai-templates/releases/latest/download/bunkajoho-latex.zip) をダウンロードする（展開しなくてよい）
2. Overleaf のプロジェクト一覧で **New Project** → **Upload Project** を選び、zip を選ぶ
3. プロジェクトが開いたら、左上の **Menu** を開き、**Compiler** を **LuaLaTeX** に変更する

</details>

### 画面の見方

| 場所 | 内容 |
| --- | --- |
| 左 | ファイルの一覧。原稿は `main.tex` |
| 中央 | 編集画面。ここで `main.tex` を書き換える |
| 右 | 出来上がりの PDF |

書き換えたら、右側の上にある **Recompile** ボタンを押すと PDF が更新されます。
こまめに Recompile して、意図どおりになっているか確かめながら進めましょう。

> [!TIP]
> 見本の PDF には、このテンプレートの使い方が書いてあります。
> 中央の `main.tex` と右の PDF を見比べると、何をどう書くとどう出力されるかが分かります。

### ファイルの役割

触るのは `main.tex`、`sample.bib`、図の画像ファイルだけです。

| ファイル | 役割 | 書き換える？ |
| --- | --- | --- |
| `main.tex` | 原稿の本体 | **書き換える** |
| `main-en.tex` | 英語論文の見本 | 英語で書くときに使う（[下記](#英語で書く場合)） |
| `sample.bib` | 引用する文献のデータ | **書き換える** |
| `figure1.png` | 見本の図 | 自分の図に差し替える |
| `bunkajoho.cls`、`bunkajoho.bbx`、`bunkajoho.cbx` | 紀要の体裁を決めるファイル | 書き換えない |
| `latexmkrc` | PDF の作り方の設定 | 書き換えない |

## 3. 表題・著者名・要旨を書き換える

`main.tex` の先頭付近にある次の部分を書き換えます。

```latex
\documentclass[paper]{bunkajoho}
```

`paper` は種別です。研究論文は `paper`、研究ノートは `note`、資料紹介は `material`、書評は `review` にします。

```latex
\title{紀要「文化情報学」LaTeX テンプレートの使い方}
\subtitle{執筆要項に基づくクラスファイルと文献スタイル}
\author{同志社 太郎・文化 花子}
```

`{ }` の中を自分の表題・副題・著者名に書き換えます。
副題がなければ `\subtitle` の行を消します。
著者が複数いるときは「・」で区切ります。

```latex
\begin{abstract}
本稿は、……
\end{abstract}
```

`\begin{abstract}` と `\end{abstract}` の間に要旨を書きます。

> [!NOTE]
> `%` から行末まではコメントで、PDF には出ません。
> `main.tex` の中のコメントにも、書き換え方の説明があります。

## 4. 本文を書く

`\begin{document}` と `\end{document}` の間が本文です。
見本の本文を消して、自分の文章に置き換えていきます。

### 段落

段落を改めるには、空行を 1 行入れます。
ただ改行しただけでは、同じ段落の続きになります。

```latex
1 つ目の段落です。
ここも 1 つ目の段落の続きです。

2 つ目の段落です。
```

### 見出し

```latex
\section{はじめに}           % 節 → 「1.」
\subsection{先行研究}        % 項 → 「1.1」
\subsubsection{国内の研究}   % 目 → 「1.1.1」
```

番号は自動で付くので、自分で書く必要はありません。

### 使えない文字

`%` `$` `&` `#` `_` `{` `}` `~` `^` `\` は LaTeX の命令に使う文字なので、そのままでは本文に出ません。
`%` や `&` を出したいときは `\%`、`\&` のように前に `\` を付けるか、全角の「％」「＆」を使います。

URL に `_` や `%` が含まれる場合は `\url{https://...}` と書くと、そのまま出力されます。

### 注

```latex
本文\footnote{注の内容。}。
```

注はページの下に脚注として出ます。
執筆要項では、注はなるべく使わないこととされています。

### 図

1. 左のファイル一覧の上にあるアップロードのボタンを押し、図の画像ファイル（PNG・JPEG・PDF）をアップロードする
2. `main.tex` の図の部分で、ファイル名を書き換える

```latex
\begin{figure}[tb]
  \centering
  \includegraphics[width=0.9\linewidth]{figure1.png}  % ← ファイル名
  \caption{図のキャプション}
  \label{fig:example}
\end{figure}
```

`width=0.9\linewidth` は「段の幅の 90%」という意味です。
図は段の上端か下端に自動で置かれるので、書いた場所とずれることがあります。
本文では `図~\ref{fig:example}` のように書くと「図 1」の番号が入ります。

### 表と数式

見本の PDF の「図表」「数式」の節に書き方があります。
`main.tex` の該当部分をコピーして書き換えるのが簡単です。

## 5. 文献を引用する

文献は 2 か所に書きます。

1. **`sample.bib`**：引用する文献のデータ（著者・発表年・表題など）
2. **`main.tex`**：本文中の引用したい位置に `\citet{キー}` または `\citep{キー}`

文献リストは、本文で引用した文献だけが自動で作られ、要項の順序と書式で並びます。

### 文献データを書く

`sample.bib` を開き、見本の文献を参考に自分の文献を書き加えます。
例：

```bibtex
@book{gibson1979,
  author    = {Gibson, J. J.},
  year      = {1979},
  title     = {The Ecological Approach to Visual Perception},
  location  = {Boston},
  publisher = {Houghton Mifflin},
}
```

1 行目の `gibson1979` が **キー** で、本文で引用するときに使う名前です。
「著者の姓＋発表年」のように、ほかと重ならない名前を自分で付けます。

日本語の文献には `langid = {japanese}` を付けます。

```bibtex
@book{saeki1990,
  editor    = {佐伯, 胖 and 佐々木, 正人},
  year      = {1990},
  title     = {アクティブ・マインド},
  location  = {東京},
  publisher = {東京大学出版会},
  langid    = {japanese},
  sortname  = {Saeki, Yutaka and Sasaki, Masato},
}
```

- 著者は「姓, 名」の形で書き、複数の著者は `and` でつなぎます。
- `sortname` に著者名のローマ字読みを書くと、欧文の文献と混ぜてアルファベット順の正しい位置に並びます。

詳しくは [参考文献の書き方](references.md) を見てください。

### 本文で引用する

| 書き方 | 出力 | 使いどころ |
| --- | --- | --- |
| `\citet{gibson1979}` | Gibson （1979） | 「〜によれば」のように文の一部にする |
| `\citep{saeki1990}` | （佐伯・佐々木, 1990） | 文末などに括弧で添える |
| `\citet[123]{gibson1979}` | Gibson （1979, p.123） | ページを示す |
| `\citep{saeki1990,gibson1979}` | （Gibson, 1979; 佐伯・佐々木, 1990） | 複数の文献をまとめて示す（文献リストの順に並ぶ） |

## 6. PDF をダウンロードする

右側の PDF の上にあるダウンロードのボタンを押すと、PDF を保存できます。
これが投稿原稿になります。

> [!TIP]
> 右上の **Share** から、指導教員や共著者を招待して同じ原稿を一緒に編集できます。

## 英語で書く場合

英語の論文には、見本 `main-en.tex` を使います（[完成見本の PDF](../latex/main-en.pdf)）。

1. 左上の **Menu** を開き、**Main document** を **main-en.tex** にする
2. **Recompile** を押すと、英語の見本の PDF が表示される
3. `main.tex` ではなく `main-en.tex` を書き換えていく

`main-en.tex` の先頭は `\documentclass[paper,english]{bunkajoho}` になっています。
`english` があると、種別・見出し・図表のキャプションが英語になり、引用の括弧が半角の ( ) になります。
副題は「―副題―」ではなく、表題の後にコロン（:）を付けた次の行に出ます。
書き方は `main.tex` と同じです。

## うまくいかないとき

Recompile してもうまくいかないときは、PDF の上に赤い印（エラー）や黄色い印（警告）が出ます。
クリックすると、問題のある行番号とメッセージが表示されます。
エラーがあっても PDF が出ることはありますが、そのままにせず直しましょう。

| 症状 | よくある原因と直し方 |
| --- | --- |
| 日本語が出ない、エラーが大量に出る | コンパイラが LuaLaTeX になっていない。**Menu** → **Compiler** を **LuaLaTeX** にする |
| 文の途中から後ろが消えた | 本文に半角の `%` を書いた。`\%` か全角の「％」にする |
| `Misplaced alignment tab character &` | 本文に半角の `&` を書いた。`\&` か全角の「＆」にする |
| `Missing $ inserted` | 本文に半角の `_` や `^` を書いた。`\_` にするか、URL なら `\url{...}` で囲む |
| `Runaway argument` や `Missing } inserted` | `{` と `}` の数が合っていない。直前に書き換えた箇所を見直す |
| 引用が **gibson1979** のようにキーのまま太字で出る | `sample.bib` にそのキーの文献がない。キーの綴りを確かめる |
| 文献リストに文献が出ない | 本文で `\citet` / `\citep` していない文献はリストに出ない |
| 図が出ない | 画像ファイルをアップロードしていないか、ファイル名が違う（大文字・小文字も区別される） |
| どうしても直らない | 直前に書き換えた部分を元に戻して Recompile し、どこが原因か絞り込む。画面上部の **History** から以前の状態に戻すこともできる |

ほかの質問は [よくある質問](faq.md) を見てください。

[← README に戻る](../README.md)
