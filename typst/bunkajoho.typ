// bunkajoho.typ
// 同志社大学文化情報学会 紀要「文化情報学」向け Typst テンプレート（非公式・叩き台）
//
// 使い方（main.typ の先頭）:
//   #import "bunkajoho.typ": *
//   #show: bunkajoho.with(type: "paper", title: [...], authors: [...], abstract: [...])
//
// 執筆要項（2022年12月7日改訂） https://www.bunkajoho.org/journal/jnl_yoko.html
// に基づき、LaTeX 版（latex/bunkajoho.cls）と同じ体裁になるようにしている。
//   A4, 本文 10pt, 行送り 14.6pt, 2段組（22字×46行×2段）, 段間 22.5pt
//   左右の余白 66.4pt, 1行目のベースラインは紙面上端から約 110pt

// ---------------------------------------------------------------
// フォント
//   和文は Noto Serif / Sans CJK JP（typst.app で使える。パソコンで使う場合はインストールが必要）。
// ---------------------------------------------------------------
#let serif-fonts = ("New Computer Modern", "Noto Serif CJK JP")
#let sans-fonts = ("Noto Sans CJK JP",)
#let mono-fonts = ("DejaVu Sans Mono", "Noto Sans Mono CJK JP")

// ---------------------------------------------------------------
// 寸法（単位 bp = 1/72 inch）
// ---------------------------------------------------------------
#let fs = 10pt              // 本文の文字サイズ
#let pitch = 14.6pt         // 行送り
#let asc = 0.88             // 行の高さのうちベースラインより上の割合
#let gap = pitch - fs       // 行と行のすき間
#let text-width = 462.5pt   // 版面の幅（22字 × 2段 + 段間 22.5pt）
#let side = (595.276pt - text-width) / 2
#let head-space = 101.1pt
#let body-height = 45 * pitch + fs   // 46行分
#let bottom-space = 841.89pt - head-space - body-height - 0.5pt

// 行送りの整数倍の高さを占めるブロック（本文の行位置を揃える）
#let grid-block(lines, before: 0, body) = block(
  above: gap + before * pitch,
  below: gap,
  height: lines * pitch - gap,
  width: 100%,
  breakable: false,
  sticky: true,
  align(horizon, body),
)

// ---------------------------------------------------------------
// 言語依存の文字列
// ---------------------------------------------------------------
#let strings = (
  ja: (
    paper: "研究論文", note: "研究ノート", material: "資料紹介", review: "書評",
    acknowledgments: "謝辞", references: "文献", appendix: "付録",
    figure: "図", table: "表", equation: "式",
  ),
  en: (
    paper: "Research Paper", note: "Research Note", material: "Material Introduction", review: "Book Review",
    acknowledgments: "Acknowledgments", references: "References", appendix: "Appendix",
    figure: "Figure", table: "Table", equation: "Equation",
  ),
)
#let lang-state = state("bj-lang", "ja")
#let str-of(key) = context strings.at(lang-state.get()).at(key)

// 見出しの直後かどうか（節見出しの直後の項見出しの前には空行を入れない）
#let after-heading = state("bj-after-heading", false)

// ---------------------------------------------------------------
// タイトル部（種別・表題・副題・著者名・要旨）
//   位置は LaTeX 版と同じ（種別ラベルのベースラインからの距離）
// ---------------------------------------------------------------
#let title-block(type-name, title, subtitle, authors, abstract, english) = context {
  let head(size, body) = text(font: sans-fonts, size: size, body)
  let base0 = asc * fs   // 種別ラベルのベースライン（ブロック上端から）

  // 表題・副題
  let title-box = block(width: text-width, {
    set align(center)
    set par(leading: 28.3pt - 16pt, justify: false)
    head(16pt, title + if english and subtitle != none [:])
    if subtitle != none {
      v(9.8pt, weak: false)
      set par(leading: 17pt - 12pt)
      head(12pt, if english { subtitle } else [―#subtitle―])
    }
  })
  let title-h = measure(title-box).height
  let title-top = base0 + 53.5pt - title-h / 2
  let title-bottom = title-top + title-h

  // 著者名（右寄せ, 右端から 20pt 内側）
  let author-box = block(width: text-width, {
    set align(right)
    set par(leading: 17pt - 12pt, justify: false)
    pad(right: 20pt, head(12pt, authors))
  })
  let author-h = measure(author-box).height
  let author-base = calc.max(title-bottom + 24pt + asc * 12pt, base0 + 128.5pt)
  let author-top = author-base - asc * 12pt
  let author-bottom = author-top + author-h

  // 要旨（9pt, 行送り 12pt, 左右 20pt 字下げ, 段落頭1字下げ）
  let abstract-box = if abstract != none {
    block(width: text-width, pad(x: 20pt, {
      set text(size: 9pt)
      set par(leading: 12pt - 9pt, spacing: 12pt - 9pt, justify: true,
        first-line-indent: (amount: if english { 0pt } else { 1em }, all: true))
      abstract
    }))
  }
  let end = author-bottom
  let abstract-top = none
  if abstract-box != none {
    let abstract-base = calc.max(author-bottom + 20pt + asc * 9pt, author-base + 56pt)
    abstract-top = abstract-base - asc * 9pt
    end = abstract-top + measure(abstract-box).height
  }

  // 本文 1 行目のベースラインまで 34pt 以上空け、高さを行送りの整数倍に切り上げる
  let height = calc.ceil((end + 34pt - base0) / pitch) * pitch

  block(width: 100%, height: height, {
    place(top + left, dy: 0pt, head(fs, type-name))
    place(top + left, dy: base0 + 4pt, line(length: 100%, stroke: 0.75pt))
    place(top + left, dy: title-top, title-box)
    place(top + left, dy: author-top, author-box)
    if abstract-box != none { place(top + left, dy: abstract-top, abstract-box) }
  })
}

// ---------------------------------------------------------------
// 謝辞・付録
// ---------------------------------------------------------------
// 謝辞: #acknowledgments[...]
#let acknowledgments(body) = {
  heading(level: 1, numbering: none, outlined: false, str-of("acknowledgments"))
  body
}

// 付録: #show: appendix の後の節は「付録 A.」（英語は「Appendix A.」）
#let appendix(body) = {
  counter(heading).update(0)
  set heading(numbering: (..n) => {
    let n = n.pos()
    let lang = lang-state.get()
    let a = numbering("A", n.first())
    if n.len() == 1 {
      if lang == "en" [Appendix #a.] else [付録#a.]
    } else {
      a + "." + n.slice(1).map(str).join(".")
    }
  })
  body
}

// ---------------------------------------------------------------
// 本体
// ---------------------------------------------------------------
#let bunkajoho(
  type: "paper",       // "paper"（研究論文）/ "note"（研究ノート）/ "material"（資料紹介）/ "review"（書評）
  english: false,      // 英語論文なら true
  title: none,
  subtitle: none,
  authors: none,
  abstract: none,
  body,
) = {
  let lang = if english { "en" } else { "ja" }
  let s = strings.at(lang)

  set document(title: title)
  set page(
    paper: "a4",
    margin: (top: head-space, bottom: bottom-space, x: side),
    columns: 2,
    numbering: none,   // ページ番号は事務局が付ける
  )
  set columns(gutter: 22.5pt)

  // 本文
  set text(
    font: serif-fonts, size: fs, lang: lang,
    top-edge: asc * fs, bottom-edge: -(1 - asc) * fs,
  )
  set par(
    leading: gap, spacing: gap, justify: true,
    first-line-indent: (amount: 1em, all: true),
  )
  show raw: set text(font: mono-fonts, size: 9pt)
  show raw.where(block: true): set par(justify: false, first-line-indent: 0pt)
  show raw.where(block: true): it => block(above: gap, below: gap, it)
  show heading: set text(font: sans-fonts, weight: "regular")
  show strong: set text(font: sans-fonts, weight: "regular")
  set footnote.entry(separator: line(length: 30%, stroke: 0.4pt))
  show footnote.entry: set text(size: 8.5pt)
  show footnote.entry: set par(leading: 13pt - 8.5pt, first-line-indent: 0pt)
  set list(indent: 1em)
  set enum(indent: 1em)

  // 段落が来たら「見出しの直後」ではなくなる
  show par: it => { after-heading.update(false); it }

  // 見出し
  //   節: 11.5pt, 2行取り（前に1行空ける）, 番号「1.」
  //   項: 10pt, 1行取り（前に1行空ける。節見出しの直後は空けない）, 番号「1.1」
  //   目: 10pt, 1行取り, 番号「1.1.1」
  //   番号なし（謝辞・文献）: 項と同じ
  set heading(numbering: (..n) => {
    let n = n.pos()
    if n.len() == 1 { str(n.first()) + "." } else { n.map(str).join(".") }
  })
  show heading: it => context {
    let label = if it.numbering != none { counter(heading).display(it.numbering) + h(1em) }
    if it.numbering == none or it.level >= 2 {
      // 項・目・番号なし見出し
      let before = if it.level == 3 and it.numbering != none { 0 } else if after-heading.get() { 0 } else { 1 }
      grid-block(1, before: before, text(size: fs, label + it.body))
    } else {
      grid-block(2, before: 1, text(size: 11.5pt, label + it.body))
    }
    after-heading.update(true)
  }

  // 図表（キャプション 9pt ゴシック。「図1　キャプション」/「Figure 1. Caption」）
  set figure(gap: 6pt)
  show figure.where(kind: image): set figure(supplement: s.figure)
  show figure.where(kind: table): set figure(supplement: s.table)
  show figure.where(kind: table): set figure.caption(position: top)
  show figure.caption: it => {
    set text(font: sans-fonts, size: 9pt)
    set par(leading: 13pt - 9pt, first-line-indent: 0pt)
    let num = context it.counter.display(it.numbering)
    if english [#it.supplement #num. #it.body] else [#it.supplement#num#h(1em)#it.body]
  }
  show figure: set block(above: gap + pitch / 2, below: gap + pitch / 2)
  show table: set text(size: fs)
  show table: set par(justify: false, first-line-indent: 0pt)

  // 数式（通し番号）
  set math.equation(numbering: "(1)", supplement: s.equation)
  show math.equation.where(block: true): set block(above: gap + pitch / 2, below: gap + pitch / 2)

  // 参照文献（著者年方式, 見出し「文献」, 9pt, 行送り 13pt, ぶら下げ 18pt）
  set bibliography(style: "bunkajoho.csl", title: s.references)
  show bibliography: set text(size: 9pt)
  show bibliography: set par(leading: 13pt - 9pt, spacing: 13pt - 9pt, hanging-indent: 18pt, first-line-indent: 0pt)
  // 英語論文では本文中引用の括弧を半角にする
  show cite: it => {
    if english { show "（": "("; show "）": ")"; it } else { it }
  }

  lang-state.update(lang)

  // タイトル部（2段にまたがる）
  place(top, scope: "parent", float: true, clearance: 0pt,
    title-block(s.at(type), title, subtitle, authors, abstract, english))

  body
}
