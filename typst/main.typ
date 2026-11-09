// main.typ — 紀要「文化情報学」Typst テンプレート 使用例兼説明書
//
// このファイルを書き換えて原稿を作ります。
// 「//」から行末まではコメント（PDF には出ません）。

#import "bunkajoho.typ": *

#show: bunkajoho.with(
  // 種別: "paper"（研究論文）/ "note"（研究ノート）/ "material"（資料紹介）/ "review"（書評）
  type: "paper",
  // 表題・副題・著者名
  title: [紀要「文化情報学」Typst テンプレートの使い方],
  subtitle: [執筆要項に基づくテンプレートと文献スタイル],   // 副題がなければこの行を消す
  authors: [同志社 太郎・文化 花子],                         // 複数の著者は「・」で区切る
  // 要旨（和文・英文いずれでもよい）
  abstract: [
    本稿は、同志社大学文化情報学会紀要『文化情報学』の執筆要項（2022 年 12 月 7 日改訂）に基づいて作成した Typst テンプレートの使い方を示すものである。
    本文そのものが使用例となっており、タイトルページの構成、節番号、図表、数式、脚注、参照文献の書き方を順に説明する。
    このファイル（main.typ）を開き、PDF と見比べながら書き換えていけば原稿になる。
  ],
)

// ---------------------------------------------------------------
// 本文
// ---------------------------------------------------------------
= はじめに

執筆要項では、掲載論文は LaTeX または Microsoft Word で作成し、編集委員会が用意したスタイルファイルを用いることとされている。
本テンプレートは、LaTeX 版と同じ体裁の原稿を Typst で作るための叩き台である。
この PDF は main.typ から作られており、main.typ を書き換えることで原稿を作成できる。

ファイルの先頭にある `type: "paper"` の `paper` を書き換えると、第 1 ページ左上の種別ラベルが変わる。
`note` は研究ノート、`material` は資料紹介、`review` は書評になる。
表題・副題・著者名・要旨は、それぞれ `title:`、`subtitle:`、`authors:`、`abstract:` の後の `[ ]` の中に書く。

第 1 ページには、要項 4. のとおり、タイトル・種別・著者名・アブストラクトが置かれる。
ページ番号は事務局が付けるため、投稿原稿には付けない。

段落を改めるには、空行を 1 行入れる。
ソースの中で改行しただけでは段落は変わらない。

= 本文の書き方

== 節と項

本文は節から構成し、各節には 1、2.3、3.4.2 のように番号を付ける（要項 5.）。
Typst では行頭に `=`（節）、`==`（項）、`===`（目）を書き、空白に続けて見出しを書くと、番号は自動で付く。

=== 表記上の注意

日本語で執筆する場合、句読点は「、」と「。」を用いる。
専門用語は原則として日本語で表記し、必要なら初出時のみ欧文を丸括弧内に併記する。
たとえば「アフォーダンス（affordance）」のように書く。
略語は初出時に正式名を記し、続けて丸括弧内に略語を示す。
たとえば「大規模言語モデル（Large Language Model; LLM）」とする。

=== 特別な意味をもつ文字

半角の `* _ # $ @ < > [ ] \ /` などの文字は Typst の命令に使われるため、そのままでは本文に出ないことがある。
本文に「\#」や「\*」を出すには、`\#`、`\*` のように前に `\` を付ける。
全角の「＃」「＊」はそのまま書いてよい。

== 数式

数式は別行に記し、末尾に通し番号を付ける。
別行の数式は `$ ... $` のように、`$` の内側の前後に空白を入れて書く。
$ H(X) = -sum_(i=1)^n p(x_i) log_2 p(x_i) $ <eq:entropy>
本文中に埋め込む場合には、`$a/b$` のように空白を入れずに `$` で囲み、
$a slash b$、$exp(x slash y)$、$delta x slash delta t$ のような記法を用いる。
Typst では `/` は分数になるので、斜線は `slash` と書く。

式の後に `<eq:mi>` のように名前を付けておくと、
`@eq:mi` と書いて「@eq:mi」のように番号を参照できる。
式を追加・削除しても番号は自動で付け直される。
$ I(X; Y) = H(X) - H(X | Y) $ <eq:mi>

== 注

注はなるべく用いない#footnote[止むを得ず使用する場合は、このように書く。刷り上がりではすべて脚注となる。]。
注は `#footnote[注の内容]` と書く。

= 図表

図表には「図 1」「表 1」のように通し番号を付け、キャプションは原則として日本語で書く（要項 6.）。
@fig:example と @tab:example に例を示す。
図表にも `<fig:example>` のように名前を付け、本文では `@fig:example` のように参照する。
図表は段の上端に配置されるため、ソースに書いた位置とずれることがある。

査読用原稿では図表を本文中に埋め込んで提出し、採択後の最終原稿では図の相当部分を空白にして充分な解像度のデータを別途提出する（要項 4.）。
他の文献から転載する場合は、著作権者の了解を得たうえで出典を明記する。

// 図: 画像ファイル（PNG, JPEG, SVG）をこのファイルと同じ場所に置き、ファイル名を書く。
//   width: 90% は「段の幅の 90%」
#figure(
  image("figure1.png", width: 90%),
  caption: [図の例],
  placement: top,
) <fig:example>

// 表: columns は列の数、align は各列の揃え（left 左, center 中央, right 右）。
//   セルは [ ] で 1 つずつ書く。table.hline() は横線。キャプションは表の上に出る。
#figure(
  table(
    columns: 3,
    align: (left, right, right),
    stroke: none,
    table.hline(stroke: 0.8pt),
    [項目], [度数], [割合（%）],
    table.hline(stroke: 0.5pt),
    [研究論文], [12], [60.0],
    [研究ノート], [5], [25.0],
    [書評], [3], [15.0],
    table.hline(stroke: 0.8pt),
  ),
  caption: [表の例],
  placement: top,
) <tab:example>

2 段にまたがる大きな図表は、`figure` に `scope: "parent"` を加える（@tab:cite がその例）。
この場合、幅の `100%` は 2 段分の幅になる。

= 参照文献

== 本文中での引用

本文中で文献を参照する際は、著者の姓の後に発表年を西暦で記す（要項 7.）。
Typst では `@キー` または `#cite(<キー>, form: "prose")` と書くと、著者名と発表年が要項の形式で自動的に出力される。
キーは文献データ（sample.yml）で各文献に付けた名前である。
@tab:cite に要項の例と対応する書き方を示す。

#figure(
  {
    set text(size: 8.5pt)
    table(
      columns: 2,
      align: left,
      stroke: none,
      table.hline(stroke: 0.8pt),
      [書き方], [出力],
      table.hline(stroke: 0.5pt),
      raw("#cite(<gibson1979>, form: \"prose\")"), cite(<gibson1979>, form: "prose"),
      raw("@saeki1990"), [@saeki1990],
      raw("#cite(<haugeland1987>, form: \"prose\", supplement: [p.123])"), cite(<haugeland1987>, form: "prose", supplement: [p.123]),
      raw("Simon（#cite(<simon1973>, form: \"year\"), #cite(<simon1981>, form: \"year\")）"), [Simon（#cite(<simon1973>, form: "year"), #cite(<simon1981>, form: "year")）],
      raw("@simon1973 @simon1981"), [@simon1973 @simon1981],
      raw("#cite(<cohen1990a>, form: \"prose\")"), cite(<cohen1990a>, form: "prose"),
      raw("@cohen1990a @cohen1990b"), [@cohen1990a @cohen1990b],
      raw("@anzai1992 @joshi1981 @minsky1975 @minsky1986"), [@anzai1992 @joshi1981 @minsky1975 @minsky1986],
      table.hline(stroke: 0.8pt),
    )
  },
  caption: [引用の書き方と出力],
  placement: top,
  scope: "parent",
) <tab:cite>

文章の一部として読む場合は #cite(<gibson1979>, form: "prose") によれば……のように `form: "prose"` を使い、
そうでない場合は……が提唱されている@saeki1990 のように `@キー` を使う。
ページを示すには、@tab:cite の 3 行目のように `supplement:` を加える。
複数の文献を引用するには `@キー` を続けて書く。
ただし Typst では、同じ著者の複数の文献も「（Simon, 1973; 1981）」のように「;」で区切られる。
要項どおり「Simon（1973, 1981）」としたい場合は、@tab:cite の 4 行目のように書く。
ただし `form: "year"` では、同じ著者・同じ年の文献を区別する「1986a」「1986b」の a, b が付かない。

== 文献データの書き方

引用する文献は、sample.yml のような YAML ファイル（Hayagriva 形式）にまとめて書く。
たとえば雑誌論文は次のように書く。

#{
  set text(size: 9pt)
  ```
  miller1956:
    type: article
    author: Miller, G. A.
    date: 1956
    title: The Magical Number ...
    page-range: 81-97
    parent:
      type: periodical
      title: Psychological Review
      volume: 63
      issue: 1
  ```
}

1 行目の `miller1956` がキーである。
和文文献には `language: ja` を付け、著者は `["佐伯, 胖", "佐々木, 正人"]` のように「姓, 名」を並べて書く。
並び順はキーで決まるので、欧文文献と混ぜて正しい位置に並ぶよう、キーはローマ字（姓＋年）にする。
書籍・論文集・翻訳書などの書き方は sample.yml の例を参照のこと。

== 文献リスト

文献リストは、「文献」という見出しのもとに、ファイルの末尾近くの `#bibliography` の位置に出力される。
本文中で引用した文献だけが載り、欧文と和文を区別せず、第 1 著者の姓のアルファベット順に並び、番号は付かない。
以下は要項に挙げられた例をすべて引用したものである：
#cite(<miller1956>, form: "prose")、#cite(<cohen1985>, form: "prose")、@minsky1986 @minsky1986b、#cite(<saeki1990>, form: "prose")、
#cite(<minsky1975>, form: "prose")、#cite(<perrault1990b>, form: "prose")、#cite(<rosenschein1987>, form: "prose")、#cite(<devins1981>, form: "prose")。

= おわりに

本テンプレートは非公式の叩き台である。
判型・字詰め・フォントサイズなどは、刊行された論文の組版に合わせている。

// 謝辞（不要なら消す）
#acknowledgments[
  謝辞は本文の後、文献の前に置く。
  謝辞は `#acknowledgments[...]` の中に書く。
]

// 文献リスト
#bibliography("sample.yml")

// 付録（不要なら #show: appendix 以下を消す）
#show: appendix

= 付録の例

付録は文献の後に置く。
`#show: appendix` の後の節は「付録 A」のような番号になる。
