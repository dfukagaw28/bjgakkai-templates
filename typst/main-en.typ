// main-en.typ — 紀要「文化情報学」Typst テンプレート 英語論文の使用例
//
// 英語で書く場合は、main.typ ではなくこのファイルを書き換えて原稿を作ります。
// 「//」から行末まではコメント（PDF には出ません）。

#import "bunkajoho.typ": *

#show: bunkajoho.with(
  // 種別: "paper"（Research Paper）/ "note"（Research Note）/ "material"（Material Introduction）/ "review"（Book Review）
  type: "paper",
  english: true,   // 英語論文（消さない）
  // 表題・副題・著者名
  title: [How to Use the Typst Template for English Papers],
  subtitle: [A Template and Bibliography Style Based on the Submission Guidelines],   // 副題がなければこの行を消す
  authors: [Taro Doshisha and Hanako Bunka],
  // 要旨
  abstract: [
    This paper describes how to use the Typst template for papers written in English for the _Journal of Culture and Information Science_ (『文化情報学』).
    The template is based on the submission guidelines revised on 7 December 2022.
    The text itself serves as an example: it explains the title block, section numbering, figures and tables, equations, footnotes, and references in turn.
    Open this file (main-en.typ), compare it with the PDF, and rewrite it to produce your manuscript.
  ],
)

// ---------------------------------------------------------------
// 本文
// ---------------------------------------------------------------
= Introduction

The submission guidelines require that papers be prepared with LaTeX or Microsoft Word using the style files provided by the editorial committee.
This template is an unofficial draft for producing manuscripts in the same format with Typst.
This PDF is produced from main-en.typ, and you can write your manuscript by rewriting that file.
For matters not covered by the guidelines, papers in English follow the _Publication Manual_ of the American Psychological Association (APA).

The line `english: true` switches the type label, headings, captions, and citation parentheses to English.
Replace `paper` in `type: "paper"` to change the type label at the top left of the first page.
Use `note` for a research note, `material` for a material introduction, and `review` for a book review.
Write the title, subtitle, authors, and abstract inside the `[ ]` after `title:`, `subtitle:`, `authors:`, and `abstract:`.

The first page contains the title, type, authors, and abstract.
Do not add page numbers; the office adds them.

To start a new paragraph, leave a blank line.
A line break in the source alone does not start a new paragraph.

= Writing the Text

== Sections and Subsections

The text is divided into sections numbered as 1, 2.3, and 3.4.2.
In Typst, start a line with `=`, `==`, or `===` followed by a space and the heading; the numbers are added automatically.

=== Notation

Spell out an abbreviation at its first occurrence, followed by the abbreviation in parentheses, as in "Large Language Model (LLM)."
Straight quotation marks `"` in the source are printed as curly quotation marks.

=== Special Characters

Characters such as `* _ # $ @ < > [ ] \ /` are used for Typst commands and may not appear in the text as they are.
To print "\#" or "\*," put a backslash before them, as in `\#` and `\*`.

== Equations

Display equations on separate lines and number them consecutively.
Write a displayed equation as `$ ... $`, with spaces inside the dollar signs.
$ H(X) = -sum_(i=1)^n p(x_i) log_2 p(x_i) $ <eq:entropy>
For equations within a sentence, write them without the spaces, as in `$a/b$`, to obtain $a slash b$, $exp(x slash y)$, or $delta x slash delta t$.
In Typst, `/` makes a fraction, so write `slash` for a slash.

If you name an equation with `<eq:mi>` after it, you can refer to its number by writing `@eq:mi`, which gives "@eq:mi."
The numbers are updated automatically when you add or remove equations.
$ I(X; Y) = H(X) - H(X | Y) $ <eq:mi>

== Notes

Avoid notes as far as possible.#footnote[If a note is unavoidable, write it like this. All notes are printed as footnotes.]
Write a note as `#footnote[...]`.

= Figures and Tables

Number figures and tables consecutively, as in "Figure 1" and "Table 1."
@fig:example and @tab:example show examples.
Name figures and tables with a label such as `<fig:example>` as well, and refer to them in the text as `@fig:example`.
Figures and tables are placed at the top of a column, so they may not appear where you wrote them in the source.

Embed figures and tables in the text of the manuscript submitted for review.
In the final manuscript after acceptance, leave the space for each figure blank and submit the figure data separately at a sufficient resolution.
When reproducing a figure or table from another source, obtain permission from the copyright holder in advance and cite the source.

// 図: 画像ファイル（PNG, JPEG, SVG）をこのファイルと同じ場所に置き、ファイル名を書く。
//   width: 90% は「段の幅の 90%」
#figure(
  image("figure1.png", width: 90%),
  caption: [An example figure],
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
    [Type], [Count], [Percent],
    table.hline(stroke: 0.5pt),
    [Research paper], [12], [60.0],
    [Research note], [5], [25.0],
    [Book review], [3], [15.0],
    table.hline(stroke: 0.8pt),
  ),
  caption: [An example table],
  placement: top,
) <tab:example>

For a large figure or table spanning both columns, add `scope: "parent"` to the `figure` (@tab:cite is an example).
In this case, the width `100%` is the width of both columns.

= References

== Citations in the Text

When citing a work in the text, give the author's surname followed by the year of publication.
In Typst, write `@key` or `#cite(<key>, form: "prose")`, and the author and year are printed automatically in the required format.
The key is the name given to each work in the bibliography data (sample.yml).
@tab:cite shows the examples in the guidelines and how to write them.

#figure(
  {
    set text(size: 8.5pt)
    table(
      columns: 2,
      align: left,
      stroke: none,
      table.hline(stroke: 0.8pt),
      [Source], [Output],
      table.hline(stroke: 0.5pt),
      raw("#cite(<gibson1979>, form: \"prose\")"), cite(<gibson1979>, form: "prose"),
      raw("@saeki1990"), [@saeki1990],
      raw("#cite(<haugeland1987>, form: \"prose\", supplement: [p.123])"), cite(<haugeland1987>, form: "prose", supplement: [p.123]),
      raw("Simon (#cite(<simon1973>, form: \"year\"), #cite(<simon1981>, form: \"year\"))"), [Simon (#cite(<simon1973>, form: "year"), #cite(<simon1981>, form: "year"))],
      raw("@simon1973 @simon1981"), [@simon1973 @simon1981],
      raw("#cite(<cohen1990a>, form: \"prose\")"), cite(<cohen1990a>, form: "prose"),
      raw("@cohen1990a @cohen1990b"), [@cohen1990a @cohen1990b],
      raw("@anzai1992 @joshi1981 @minsky1975 @minsky1986"), [@anzai1992 @joshi1981 @minsky1975 @minsky1986],
      table.hline(stroke: 0.8pt),
    )
  },
  caption: [How to write citations and their output],
  placement: top,
  scope: "parent",
) <tab:cite>

Use `form: "prose"` when the citation is part of the sentence, as in "according to #cite(<gibson1979>, form: "prose"), …," and `@key` otherwise, as in "… has been proposed @saeki1990."
To give a page, add `supplement:` as in the third row of @tab:cite.
To cite several works, write `@key` one after another.
Note that Typst separates works by the same author with a semicolon, as in "(Simon, 1973; 1981)."
To follow the guidelines and write "Simon (1973, 1981)," write it as in the fourth row of @tab:cite.
However, `form: "year"` does not add the letters that distinguish works by the same author in the same year, such as "1986a" and "1986b."

== Writing Bibliography Data

Collect the works you cite in a YAML file (Hayagriva format) such as sample.yml.
A journal article, for example, is written as follows.

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

The `miller1956` in the first line is the key.
Write authors as "Surname, Given names," listing several authors in `[ ]`.
For works in Japanese, add `language: ja`.
The works are sorted by key, so give works in Japanese a romanized key (surname and year) so that they are sorted correctly among works in English.
See sample.yml for books, edited volumes, and translations.

== Reference List

The reference list is printed under the heading "References" where `#bibliography` is written near the end of the file.
Only the works cited in the text are listed, sorted alphabetically by the first author's surname without numbers, regardless of language.
The following sentence cites all the examples in the guidelines:
#cite(<miller1956>, form: "prose"), #cite(<cohen1985>, form: "prose"), @minsky1986 @minsky1986b, #cite(<saeki1990>, form: "prose"), #cite(<minsky1975>, form: "prose"), #cite(<perrault1990b>, form: "prose"), #cite(<rosenschein1987>, form: "prose"), and #cite(<devins1981>, form: "prose").

= Conclusion

This template is an unofficial draft.
The page size, number of characters per line, font sizes, and so on follow the typesetting of published papers.

// 謝辞（不要なら消す）
#acknowledgments[
  Acknowledgments are placed after the text and before the references.
  Write them inside `#acknowledgments[...]`.
]

// 文献リスト
#bibliography("sample.yml")

// 付録（不要なら #show: appendix 以下を消す）
#show: appendix

= An Example Appendix

Appendices are placed after the references.
Sections after `#show: appendix` are numbered as "Appendix A."
