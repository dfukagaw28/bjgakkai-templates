#!/usr/bin/env python3
"""学会事務局の Word テンプレートから pandoc 用の reference.docx を作る。

使い方:
    python3 pandoc/make-reference-docx.py 『文化情報学』テンプレート（横書）.docx docx/reference.docx

元のテンプレートのページ設定（A4・余白・本文2段組）、ヘッダ、フォント、テーマはそのまま使い、
pandoc が出力に使うスタイル（Title, Heading 1, Body Text など）を、テンプレートの
表題・要旨・見出しなどの書式に合わせて追加する。本文は空にする（pandoc は最後の
セクション設定だけを参照する）。
"""
import re
import sys
import zipfile

# テンプレートの書式（単位: w:sz は半ポイント、長さは twip = 1/20 pt）
GOTHIC = '<w:rFonts w:ascii="Times New Roman" w:eastAsia="ＭＳ ゴシック" w:hAnsi="Times New Roman" w:cs="Times New Roman"/>'
TIMES = '<w:rFonts w:ascii="Times New Roman" w:hAnsi="Times New Roman" w:cs="Times New Roman"/>'


def sz(halfpoints):
    return f'<w:sz w:val="{halfpoints}"/><w:szCs w:val="{halfpoints}"/>'


def pstyle(style_id, name, ppr="", rpr="", based_on="a", next_id=None, extra=""):
    nxt = f'<w:next w:val="{next_id}"/>' if next_id else ""
    return (
        f'<w:style w:type="paragraph" w:customStyle="1" w:styleId="{style_id}">'
        f'<w:name w:val="{name}"/><w:basedOn w:val="{based_on}"/>{nxt}<w:qFormat/>{extra}'
        f"<w:pPr>{ppr}</w:pPr><w:rPr>{rpr}</w:rPr></w:style>"
    )


def cstyle(style_id, name, rpr):
    return (
        f'<w:style w:type="character" w:customStyle="1" w:styleId="{style_id}">'
        f'<w:name w:val="{name}"/><w:rPr>{rpr}</w:rPr></w:style>'
    )


def heading(level):
    return pstyle(
        f"Heading{level}",
        f"heading {level}",
        ppr=(
            '<w:keepNext/><w:spacing w:before="0" w:afterLines="50" w:after="144"/>'
            f'<w:ind w:leftChars="92" w:left="183"/><w:outlineLvl w:val="{level - 1}"/>'
        ),
        rpr=GOTHIC + sz(18),
        next_id="FirstParagraph",
    )


STYLES = [
    # 本文（段落頭1字下げ）
    pstyle("BodyText", "Body Text", ppr='<w:ind w:firstLineChars="100" w:firstLine="180"/>'),
    pstyle("FirstParagraph", "First Paragraph", based_on="BodyText", next_id="BodyText"),
    pstyle("Compact", "Compact", ppr='<w:ind w:firstLineChars="0" w:firstLine="0"/>', based_on="BodyText"),
    # 別行数式（中央、式番号は右端のタブ位置）と、数式の後に続く文（字下げなし）
    pstyle(
        "Equation",
        "Equation",
        ppr='<w:tabs><w:tab w:val="center" w:pos="2150"/><w:tab w:val="right" w:pos="4300"/></w:tabs><w:spacing w:before="60" w:after="60"/><w:ind w:firstLineChars="0" w:firstLine="0"/>',
        based_on="BodyText",
    ),
    pstyle("BodyTextContinued", "Body Text Continued", ppr='<w:ind w:firstLineChars="0" w:firstLine="0"/>', based_on="BodyText"),
    # タイトル部（1段組のセクション）
    # 種別ラベル: 10.5pt ゴシック、下に版面幅の水平線
    pstyle(
        "PaperType",
        "Paper Type",
        ppr='<w:pBdr><w:bottom w:val="single" w:sz="6" w:space="1" w:color="auto"/></w:pBdr><w:jc w:val="left"/>',
        rpr=GOTHIC + sz(21),
    ),
    # 表題: 16.5pt ゴシック、中央、前に 43.2pt
    pstyle("Title", "Title", ppr='<w:spacing w:before="864" w:after="0"/><w:jc w:val="center"/>', rpr=GOTHIC + sz(33)),
    # 副題: 14pt、中央、後に 43.2pt
    pstyle("Subtitle", "Subtitle", ppr='<w:spacing w:before="0" w:after="864"/><w:jc w:val="center"/>', rpr=sz(28)),
    # 著者名: 10.5pt、右寄せ（右端から約2字内側）
    pstyle("Author", "Author", ppr='<w:ind w:rightChars="228" w:right="422"/><w:jc w:val="right"/>', rpr=TIMES + sz(21)),
    # 要旨: 8.5pt、左右約 23pt 字下げ、段落頭1字下げ、前後に 28.8pt
    pstyle(
        "Abstract",
        "Abstract",
        ppr=(
            '<w:spacing w:beforeLines="200" w:before="576" w:afterLines="200" w:after="576"/>'
            '<w:ind w:left="463" w:right="463" w:firstLineChars="100" w:firstLine="170"/><w:jc w:val="both"/>'
        ),
        rpr=TIMES + sz(17),
    ),
    # 見出し: 本文と同じ 9pt のゴシック、1字下げ、後に半行
    heading(1),
    heading(2),
    heading(3),
    # 文献リスト: ぶら下げ2字
    pstyle("Bibliography", "Bibliography", ppr='<w:ind w:left="360" w:hanging="360"/>'),
    # 図表
    pstyle("Figure", "Figure", ppr='<w:jc w:val="center"/>'),
    pstyle("CaptionedFigure", "Captioned Figure", ppr='<w:keepNext/><w:jc w:val="center"/>'),
    pstyle("Caption", "Caption", ppr='<w:spacing w:before="60" w:after="120"/><w:jc w:val="center"/>'),
    pstyle("ImageCaption", "Image Caption", ppr='<w:spacing w:before="60" w:after="120"/><w:jc w:val="center"/>', based_on="Caption"),
    pstyle("TableCaption", "Table Caption", ppr='<w:keepNext/><w:spacing w:before="120" w:after="60"/><w:jc w:val="center"/>', based_on="Caption"),
    # 脚注: 8pt
    pstyle("FootnoteText", "Footnote Text", ppr='<w:ind w:left="180" w:hanging="180"/>', rpr=sz(16)),
    cstyle("FootnoteReference", "Footnote Reference", '<w:vertAlign w:val="superscript"/>'),
]


def main(src, dst):
    with zipfile.ZipFile(src) as zin:
        files = {name: zin.read(name) for name in zin.namelist()}

    # スタイルの追加（同じ名前のスタイルが既にあれば差し替える）
    styles = files["word/styles.xml"].decode("utf-8")
    for st in STYLES:
        name = re.search(r'<w:name w:val="([^"]+)"/>', st).group(1)
        styles = re.sub(
            r'<w:style [^>]*>(?:(?!</w:style>).)*<w:name w:val="' + re.escape(name) + r'"/>.*?</w:style>',
            "",
            styles,
            flags=re.S | re.I,
        )
        styles = styles.replace("</w:styles>", st + "</w:styles>")
    files["word/styles.xml"] = styles.encode("utf-8")

    # 本文を空にし、最後のセクション設定（本文2段組）だけを残す
    doc = files["word/document.xml"].decode("utf-8")
    body_sectpr = re.search(r"<w:sectPr(?: [^>]*)?>(?:(?!<w:sectPr).)*?</w:sectPr>\s*</w:body>", doc, re.S)
    sectpr = body_sectpr.group(0).replace("</w:body>", "").strip()
    doc = re.sub(r"<w:body>.*</w:body>", "<w:body>" + sectpr + "</w:body>", doc, flags=re.S)
    files["word/document.xml"] = doc.encode("utf-8")

    # 作成者・最終更新者を消す（元のテンプレートの作成者名を配布物に残さない）
    core = files["docProps/core.xml"].decode("utf-8")
    core = re.sub(r"<dc:creator>[^<]*</dc:creator>", "<dc:creator></dc:creator>", core)
    core = re.sub(r"<cp:lastModifiedBy>[^<]*</cp:lastModifiedBy>", "<cp:lastModifiedBy></cp:lastModifiedBy>", core)
    files["docProps/core.xml"] = core.encode("utf-8")

    with zipfile.ZipFile(dst, "w", zipfile.ZIP_DEFLATED) as zout:
        for name, data in files.items():
            zout.writestr(name, data)


if __name__ == "__main__":
    if len(sys.argv) != 3:
        sys.exit(__doc__)
    main(sys.argv[1], sys.argv[2])
