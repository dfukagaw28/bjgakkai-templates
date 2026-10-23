# 参考文献の書き方

紀要『文化情報学』の [執筆要項](https://www.bunkajoho.org/journal/jnl_yoko.html) の「7. 参照文献」に沿った書き方をまとめます。
要項に書かれていないことは、日本語の論文では日本心理学会「[執筆・投稿の手びき（2022年版）](https://psych.or.jp/manual/)」の第 3 章・第 4 章、
英語の論文では APA（American Psychological Association）の *Publication Manual* に従うことになっています（要項 10.）。

- **Word で書く人**：本文中の引用も文献リストも、このページの例にならって自分で書きます。
- **LaTeX（Overleaf）で書く人**：文献のデータを bib ファイルに書き、本文で `\citet` / `\citep` を使うと、ここに示す形で自動的に出力されます。

## 1. 本文中での引用

著者の姓の後に、発表年を西暦で書きます。
括弧は全角の（ ）を使います（英語の論文では半角の ( )）。

| 場面 | 出力（Word ではこのとおりに書く） | LaTeX での書き方 |
| --- | --- | --- |
| 文の一部として読む | Gibson （1979） によれば…… | `\citet{gibson1979}` |
| 括弧で添える | ……が提唱されている（佐伯・佐々木, 1990） | `\citep{saeki1990}` |
| ページを示す | Haugeland （1987, p.123） | `\citet[123]{haugeland1987}` |
| 同じ著者の複数の文献 | Simon （1973, 1981） / （Simon, 1973, 1981） | `Simon \citep*{simon1973,simon1981}` / `\citep{simon1973,simon1981}` |
| 同じ著者・同じ年の文献 | Cohen & Levesque （1990a） / （Cohen & Levesque, 1990a, 1990b） | `\citet{cohen1990a}` / `\citep{cohen1990a,cohen1990b}` |
| 異なる著者の複数の文献 | （安西 他, 1992; Joshi et al., 1981; Minsky, 1975, 1986） | `\citep{anzai1992,joshi1981,minsky1975,minsky1986}` |

**決まりごと**

- 括弧で添えるときは、著者名と発表年の間をコンマで区切る：（佐伯・佐々木, 1990）
- 異なる著者の文献を 1 つの括弧に入れるときは、同じ著者ごとにまとめ、セミコロン（;）で区切る
- 同じ著者・同じ年の文献は、発表年の後に a、b … を付けて区別する（文献リストでも同じ記号を付ける）
- 著者が 2 人のとき：欧文は「Cohen & Levesque」、和文は「佐伯・佐々木」
- 著者が 3 人以上のとき：欧文は「Joshi et al.」、和文は「安西 他」（第 1 著者の姓の後に付ける）
- 和文の著者を文の一部として引用するときは、「佐伯・佐々木（1990）は……」のように姓と括弧の間を空けない

## 2. 文献リスト

本文の後（謝辞があればその後）に、見出し「文献」を付けて、本文中で引用した文献をすべて並べます。

- **番号は付けない**
- **欧文と和文を区別せず**、第 1 著者の姓名の **アルファベット順** に並べる。和文の文献はローマ字読みで並べる
- 同じ著者の文献は、発表年の順に並べる
- 本文中で発表年に a、b を付けた文献は、リストでも同じ記号を付ける
- 各文献は「著者の姓名、発表年、表題 …」の順に書く
- 雑誌名や会議名は略さない
- 洋書の書名と雑誌名は *イタリック*、雑誌の巻番号は **太字** にする
- 本文中で引用していない文献は載せない。リストに載せた文献は、必ず本文中で引用する

並び順の例（和文は「佐伯 = Saeki」として欧文の間に入る）：

> 安西 祐一郎・山田 太郎・鈴木 花子（1992）．……
> Cohen, P. R. & Levesque, H. J. (1985). ……
> Miller, G. A. (1956). ……
> Rosenschein, S. (1987). ……
> 佐伯 胖・佐々木 正人（編）（1990）．……
> Simon, H. A. (1973). ……

### 欧文と和文の違い

| | 欧文 | 和文 |
| --- | --- | --- |
| 著者名 | 姓, 名の頭文字.（Miller, G. A.） | 姓 名（佐伯 胖） |
| 著者の区切り | `, `、最後の著者の前は ` & ` | 「・」 |
| 発表年 | 半角 (1956) | 全角（1990） |
| 区切りの句読点 | 半角の「. 」 | 全角の「．」 |
| 書名 | *イタリック* | 『 』で囲む |
| 雑誌名 | *イタリック* | 『 』で囲む |
| 編者 | (Ed.) / (Eds.) | （編） |

## 3. 文献の種類別の書き方

それぞれ、**文献リストでの書き方** と、LaTeX で使う **bib ファイルでの書き方** を示します。
<sup>※</sup>の付いた例は、要項に例がないため、要項の例にならってこのテンプレートが出力する形です。

### 雑誌論文（定期刊行物の中の論文）

> Miller, G. A. (1956). The Magical Number Seven, Plus or Minus Two: Some Limits on Our Capacity for Processing Information. *Psychological Review*, **63**(1), 81–97.

「巻(号), 頁」の順で、巻番号を太字にします。

```bibtex
@article{miller1956,
  author       = {Miller, G. A.},
  year         = {1956},
  title        = {The Magical Number Seven, Plus or Minus Two: Some Limits on Our Capacity for Processing Information},
  journaltitle = {Psychological Review},
  volume       = {63},
  number       = {1},
  pages        = {81--97},
}
```

**和文の雑誌論文**

> 安西 祐一郎・山田 太郎・鈴木 花子（1992）．認知科学における知識表現の諸問題．『認知科学』．**1**（2）, 1–20．

要項の例（翻訳の併記：「『現代思想』．**6**（3）, 127–139.」）にならい、誌名を『 』で囲み、その後を「．」で区切ります。

```bibtex
@article{anzai1992,
  author       = {安西, 祐一郎 and 山田, 太郎 and 鈴木, 花子},
  year         = {1992},
  title        = {認知科学における知識表現の諸問題},
  journaltitle = {認知科学},
  volume       = {1},
  number       = {2},
  pages        = {1--20},
  langid       = {japanese},
  sortname     = {Anzai, Yuichiro and Yamada, Taro and Suzuki, Hanako},
}
```

### 会議録の中の論文

> Cohen, P. R. & Levesque, H. J. (1985). Speech Acts and Rationality. *Proceedings of the 23rd Annual Meeting of the Association for Computational Linguistics*, 49–60.

```bibtex
@inproceedings{cohen1985,
  author    = {Cohen, P. R. and Levesque, H. J.},
  year      = {1985},
  title     = {Speech Acts and Rationality},
  booktitle = {Proceedings of the 23rd Annual Meeting of the Association for Computational Linguistics},
  pages     = {49--60},
}
```

### 書籍

> Minsky, M. (1986). *Society of Mind*. New York: Simon and Schuster.

「出版地: 出版社」の順に書きます。

```bibtex
@book{minsky1986,
  author    = {Minsky, M.},
  year      = {1986},
  title     = {Society of Mind},
  location  = {New York},
  publisher = {{Simon and Schuster}},
}
```

出版社名に `and` が含まれるときは、`{{Simon and Schuster}}` のように二重の波括弧で囲みます（囲まないと 2 人の名前と見なされます）。

**和文の書籍**<sup>※</sup>

> 田中 一郎（2020）．『文化情報学入門』．京都: 同志社出版．

```bibtex
@book{tanaka2020,
  author    = {田中, 一郎},
  year      = {2020},
  title     = {文化情報学入門},
  location  = {京都},
  publisher = {同志社出版},
  langid    = {japanese},
  sortname  = {Tanaka, Ichiro},
}
```

**編集書（編者のある本）**

> 佐伯 胖・佐々木 正人（編）（1990）．『アクティブ・マインド』．東京: 東京大学出版会．

```bibtex
@collection{saeki1990,
  editor    = {佐伯, 胖 and 佐々木, 正人},
  year      = {1990},
  title     = {アクティブ・マインド},
  location  = {東京},
  publisher = {東京大学出版会},
  langid    = {japanese},
  sortname  = {Saeki, Yutaka and Sasaki, Masato},
}
```

### 編集書の中の論文（論文集の 1 章）

> Minsky, M. (1975). A Framework for Representing Knowledge. In P. Winston (Ed.), *Psychology of Computer Vision*. New York: McGraw-Hill.
>
> Perrault, C. R. (1990). An Application of Default Logic to Speech Act Theory. In P. R. Cohen, J. Morgan & M. E. Pollack (Eds.), *Intentions in Communication*, 161–185. Cambridge, MA: MIT Press.

編者の名前は「名の頭文字 姓」の順にし、編者が 1 人なら (Ed.)、複数なら (Eds.) を付けます。
章のページは書名の後に書きます。

```bibtex
@incollection{perrault1990,
  author    = {Perrault, C. R.},
  year      = {1990},
  title     = {An Application of Default Logic to Speech Act Theory},
  editor    = {Cohen, P. R. and Morgan, J. and Pollack, M. E.},
  booktitle = {Intentions in Communication},
  pages     = {161--185},
  location  = {Cambridge, MA},
  publisher = {MIT Press},
}
```

**和文の編集書の中の論文**<sup>※</sup>

> 山田 花子（2018）．デジタルアーカイブの現在．田中 一郎（編）, 『文化資源の情報学』, 45–67．東京: 文化書房．

```bibtex
@incollection{yamada2018,
  author    = {山田, 花子},
  year      = {2018},
  title     = {デジタルアーカイブの現在},
  editor    = {田中, 一郎},
  booktitle = {文化資源の情報学},
  pages     = {45--67},
  location  = {東京},
  publisher = {文化書房},
  langid    = {japanese},
  sortname  = {Yamada, Hanako},
}
```

### テクニカルレポート（報告書）

> Rosenschein, S. (1987). *Formal Theories of Knowledge in AI and Robotics*, Report No. CSLI-87-84. Stanford: Center for the Study of Language and Information, Stanford University.

```bibtex
@report{rosenschein1987,
  author      = {Rosenschein, S.},
  year        = {1987},
  title       = {Formal Theories of Knowledge in AI and Robotics},
  type        = {Report No.},
  number      = {CSLI-87-84},
  location    = {Stanford},
  institution = {{Center for the Study of Language and Information, Stanford University}},
}
```

### 学位論文

> Devins, G. M. (1981). *Helplessness, Depression, and Mood in Endstage Renal Disease*, Doctoral dissertation. Montreal: McGill University.

```bibtex
@thesis{devins1981,
  author      = {Devins, G. M.},
  year        = {1981},
  title       = {Helplessness, Depression, and Mood in Endstage Renal Disease},
  type        = {Doctoral dissertation},
  location    = {Montreal},
  institution = {McGill University},
}
```

**和文の学位論文**<sup>※</sup>

> 鈴木 次郎（2015）．『近世京都の出版文化』, 博士論文．同志社大学．

```bibtex
@thesis{suzuki2015,
  author      = {鈴木, 次郎},
  year        = {2015},
  title       = {近世京都の出版文化},
  type        = {博士論文},
  institution = {同志社大学},
  langid      = {japanese},
  sortname    = {Suzuki, Jiro},
}
```

### 翻訳書を併記する

原著の後に、翻訳書を丸括弧に入れて続けます。

> Minsky, M. (1986). *Society of Mind*. New York: Simon and Schuster.（安西 祐一郎 訳（1990）．『心の社会』．東京: 産業図書．）

bib ファイルでは、翻訳書の部分を `addendum` に書きます（丸括弧は自動で付きます）。

```bibtex
  addendum  = {安西 祐一郎 訳（1990）．『心の社会』．東京: 産業図書．},
```

### 要項に例がない文献（ウェブページなど）

ウェブページ、新聞記事、映像資料など、要項に例がない文献は、
日本心理学会「[執筆・投稿の手びき（2022年版）](https://psych.or.jp/manual/)」の第 3 章・第 4 章の書き方に従ってください。
LaTeX で自動的に出力できない書き方は、指導教員や編集委員会に相談してください。

## 4. bib ファイルを書くときの注意（LaTeX）

- **キー**（`@book{tanaka2020,` の `tanaka2020`）は、本文で引用するときの名前です。「姓＋発表年」をローマ字で付け、ほかの文献と重ならないようにします。同じ著者・同じ年の文献は `cohen1990a`、`cohen1990b` のようにします。
- **著者名** は「姓, 名」の形で書き、複数の著者は `and` でつなぎます：`{佐伯, 胖 and 佐々木, 正人}`
- **和文の文献** には、必ず次の 2 つを付けます。
  - `langid = {japanese}`：和文の書式（「・」『 』「．」など）に切り替わります
  - `sortname = {Saeki, Yutaka and Sasaki, Masato}`：著者名のローマ字読みです。欧文の文献と混ぜて正しい位置に並びます
- **欧文の文献** には `langid` を付けません。
- **ページの範囲** は `81--97` のようにハイフンを 2 つ続けます（出力は「81–97」）。

### 文献データを集めるには

[CiNii Research](https://cir.nii.ac.jp/) や [Google Scholar](https://scholar.google.com/) では、文献の情報を BibTeX 形式で取り出せます。
取り出したデータは、そのまま使わずに次の点を直してください。

- 和文の文献に `langid` と `sortname` を付け足す
- 著者名が「姓, 名」の形になっているか確かめる
- 雑誌名が略記されていないか確かめる（要項では略記しない）
- `journal` は `journaltitle` と同じ意味なので、そのままでよい

[← README に戻る](../README.md)
