%% bunkajoho.cls
%% 同志社大学文化情報学会 紀要「文化情報学」向け LaTeX クラスファイル（非公式・叩き台）
%%
%% 依存: LuaLaTeX, jlreq, luatexja-preset, biblatex (biber)
%% 使い方: \documentclass[paper]{bunkajoho}   % 研究論文（既定）
%%         \documentclass[note]{bunkajoho}    % 研究ノート
%%         \documentclass[material]{bunkajoho}% 資料紹介
%%         \documentclass[review]{bunkajoho}  % 書評
%%         \documentclass[english]{bunkajoho} % 英語論文（見出し等を英語に）
%%
%% 執筆要項（2022年12月7日改訂）
%%   https://www.bunkajoho.org/journal/jnl_yoko.html
%% に基づいて作成。版面・タイトルページ・見出しの体裁は、学会事務局の Word テンプレート
%% 『文化情報学』テンプレート（横書）.docx（2024年10月更新）に合わせている。
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{bunkajoho}[2026/09/29 v0.1 Bunka Joho (Doshisha) journal class (unofficial draft)]

\RequirePackage{iftex}
\ifLuaTeX\else
  \ClassError{bunkajoho}{This class requires LuaLaTeX}{Compile with lualatex (or latexmk -lualatex).}
\fi

%% ---------------------------------------------------------------
%% クラスオプション
%% ---------------------------------------------------------------
\RequirePackage{xkeyval}
\newcommand*\bj@type{paper}
\newif\ifbj@english\bj@englishfalse
\newif\ifbj@draft\bj@draftfalse
\DeclareOptionX{paper}{\renewcommand*\bj@type{paper}}
\DeclareOptionX{note}{\renewcommand*\bj@type{note}}
\DeclareOptionX{material}{\renewcommand*\bj@type{material}}
\DeclareOptionX{review}{\renewcommand*\bj@type{review}}
\DeclareOptionX{english}{\bj@englishtrue}
\DeclareOptionX{draft}{\bj@drafttrue}
\DeclareOptionX*{\PassOptionsToClass{\CurrentOption}{jlreq}}
\ProcessOptionsX\relax

%% ---------------------------------------------------------------
%% 基本レイアウト（Word テンプレートに準拠）
%%   A4, 本文 9pt, 行送り 14.4pt, 2段組（24字×49行×2段）
%%   余白 天 33mm / 地 約15mm / 左右 約25mm, 段間 2字（≒15pt）
%%   要項: 研究論文は刷り上がり20ページ・約30,000字以内
%% ---------------------------------------------------------------
\LoadClass[
  paper=a4,
  twocolumn,
  fontsize=9pt,
  jafontsize=9pt,
  baselineskip=14.4pt,
  line_length=24zw,    % 1段の字数（2段組では段ごとの長さ）
  column_gap=2zw,
  number_of_lines=49,
  head_space=33mm,
  gutter=25mm,
]{jlreq}

\RequirePackage[haranoaji]{luatexja-preset}
\RequirePackage{amsmath,amssymb}
\RequirePackage{graphicx}
\RequirePackage{booktabs}
\RequirePackage{caption}
\RequirePackage{url}

%% ---------------------------------------------------------------
%% 言語依存の文字列
%% ---------------------------------------------------------------
\newcommand*\bj@typename{}
\ifbj@english
  \def\bj@set@typename{%
    \ifx\bj@type\bj@t@paper    \renewcommand*\bj@typename{Research Paper}\fi
    \ifx\bj@type\bj@t@note     \renewcommand*\bj@typename{Research Note}\fi
    \ifx\bj@type\bj@t@material \renewcommand*\bj@typename{Material Introduction}\fi
    \ifx\bj@type\bj@t@review   \renewcommand*\bj@typename{Book Review}\fi}
  \newcommand*\bj@abstractname{Abstract}
  \newcommand*\bj@keywordsname{Keywords:}
  \newcommand*\bj@acknowledgmentsname{Acknowledgments}
  \newcommand*\bj@appendixname{Appendix}
  \newcommand*\bj@refname{References}
  \renewcommand*\figurename{Figure}
  \renewcommand*\tablename{Table}
  \captionsetup{labelsep=period}
\else
  \def\bj@set@typename{%
    \ifx\bj@type\bj@t@paper    \renewcommand*\bj@typename{研究論文}\fi
    \ifx\bj@type\bj@t@note     \renewcommand*\bj@typename{研究ノート}\fi
    \ifx\bj@type\bj@t@material \renewcommand*\bj@typename{資料紹介}\fi
    \ifx\bj@type\bj@t@review   \renewcommand*\bj@typename{書評}\fi}
  \newcommand*\bj@abstractname{要旨}
  \newcommand*\bj@keywordsname{キーワード：}
  \newcommand*\bj@acknowledgmentsname{謝辞}
  \newcommand*\bj@appendixname{付録}
  \newcommand*\bj@refname{文献}
  \renewcommand*\figurename{図}
  \renewcommand*\tablename{表}
  \captionsetup{labelsep=quad}   % 「図1　キャプション」
\fi
\def\bj@t@paper{paper}\def\bj@t@note{note}\def\bj@t@material{material}\def\bj@t@review{review}
\bj@set@typename

\ifbj@draft
  \RequirePackage[firstpage]{draftwatermark}
  \SetWatermarkText{DRAFT}\SetWatermarkScale{4}\SetWatermarkLightness{0.9}
\fi

%% ---------------------------------------------------------------
%% 見出し（節番号は 1, 2.3, 3.4.2 形式。要項 5.）
%%   Word テンプレートに合わせ、本文と同サイズのゴシック（太字なし）・1字下げ。
%%   節番号は「1.」、項以下は「1.1」「1.1.1」。
%% ---------------------------------------------------------------
\setcounter{secnumdepth}{3}
\jlreqsetup{
  caption_font=\normalfont,
  caption_label_font=\bfseries,
}
\RenewBlockHeading{section}{1}{font=\normalsize\sffamily\gtfamily, indent=1\zw, lines=1, before_space=0.5\baselineskip, after_space=0.5\baselineskip, label_format={\thesection.}}
\RenewBlockHeading{subsection}{2}{font=\normalsize\sffamily\gtfamily, indent=1\zw, lines=1, before_space=0.25\baselineskip, after_space=0.25\baselineskip, label_format={\thesubsection}}
\RenewBlockHeading{subsubsection}{3}{font=\normalsize\sffamily\gtfamily, indent=1\zw, lines=1, before_space=0.25\baselineskip, after_space=0.25\baselineskip, label_format={\thesubsubsection}}

%% 番号なし見出し（謝辞・文献・付録）
\newcommand*\bj@unnumberedhead[1]{\section*{#1}\addcontentsline{toc}{section}{#1}}
\newenvironment{acknowledgments}{\bj@unnumberedhead{\bj@acknowledgmentsname}}{}
\renewcommand\appendix{%
  \setcounter{section}{0}\setcounter{subsection}{0}%
  \renewcommand\thesection{\bj@appendixname\Alph{section}}%
  \ifbj@english\renewcommand\thesection{\Alph{section}}\fi
}

%% ---------------------------------------------------------------
%% 柱・ページ番号（なし。ページ番号は事務局が付ける）
%% ---------------------------------------------------------------
\pagestyle{empty}

%% ---------------------------------------------------------------
%% タイトルページ要素（要項 4.: タイトル・種別・著者名・アブストラクト）
%%   Word テンプレートにあるのは 種別・表題・副題・著者名・要旨 のみ。
%%   英文表題・英文著者名・所属・キーワードは任意（指定したときだけ出力）。
%% ---------------------------------------------------------------
\newcommand*\bj@title{}\newcommand*\bj@subtitle{}
\newcommand*\bj@authors{}\newcommand*\bj@affiliation{}
\newcommand*\bj@etitle{}\newcommand*\bj@eauthors{}
\newcommand*\bj@keywords{}
\renewcommand*\title[1]{\renewcommand*\bj@title{#1}}
\newcommand*\subtitle[1]{\renewcommand*\bj@subtitle{#1}}
\renewcommand*\author[1]{\renewcommand*\bj@authors{#1}}
\newcommand*\affiliation[1]{\renewcommand*\bj@affiliation{#1}}
\newcommand*\englishtitle[1]{\renewcommand*\bj@etitle{#1}}
\newcommand*\englishauthor[1]{\renewcommand*\bj@eauthors{#1}}
\newcommand*\keywords[1]{\renewcommand*\bj@keywords{#1}}

%% 要旨は環境として蓄える（和文・英文いずれでも可。両方も可）
\newcommand*\bj@abstractbody{}\newcommand*\bj@eabstractbody{}
\RenewDocumentEnvironment{abstract}{+b}{\gdef\bj@abstractbody{#1}}{}
\NewDocumentEnvironment{englishabstract}{+b}{\gdef\bj@eabstractbody{#1}}{}

%% 要旨ブロック（8.5pt, 左右 23pt 字下げ, 段落頭1字下げ, 見出しなし）
\newcommand\bj@abstractblock[1]{%
  \begin{list}{}{\leftmargin=23pt\rightmargin=23pt\topsep=0pt\partopsep=0pt\parsep=0pt}%
    \fontsize{8.5pt}{13pt}\selectfont
    \setlength\listparindent{1\zw}\setlength\itemindent{1\zw}%
    \item\relax #1
  \end{list}}

%% タイトル部は2段組の上に1段で組む
\newcommand\bj@maketitle{%
  \begingroup
  \setlength\parindent{0pt}%
  % 種別ラベル（10.5pt ゴシック, 左寄せ）
  {\fontsize{10.5pt}{14.4pt}\selectfont\sffamily\gtfamily\bj@typename\par}
  \vspace{43.2pt}%
  \begin{center}
    % 表題（16.5pt ゴシック, 太字なし）
    {\fontsize{16.5pt}{24pt}\selectfont\sffamily\gtfamily\bj@title\par}
    % 副題（14pt 明朝, ―副題―）
    \ifx\bj@subtitle\@empty\else
      \vspace{0.5\baselineskip}{\fontsize{14pt}{20pt}\selectfont ―\bj@subtitle―\par}\fi
    \ifx\bj@etitle\@empty\else
      \vspace{0.5\baselineskip}{\fontsize{12pt}{18pt}\selectfont\bj@etitle\par}\fi
  \end{center}
  \vspace{43.2pt}%
  % 著者名（10.5pt, 右寄せ, 右端から2字内側）
  {\raggedleft\fontsize{10.5pt}{15pt}\selectfont
    \bj@authors\hspace*{2\zw}\par
    \ifx\bj@eauthors\@empty\else\bj@eauthors\hspace*{2\zw}\par\fi
    \ifx\bj@affiliation\@empty\else{\fontsize{8.5pt}{13pt}\selectfont\bj@affiliation\hspace*{2\zw}\par}\fi}
  \vspace{28.8pt}%
  % 要旨
  \ifx\bj@abstractbody\@empty\else\bj@abstractblock{\bj@abstractbody}\fi
  \ifx\bj@eabstractbody\@empty\else
    \ifx\bj@abstractbody\@empty\else\vspace{0.5\baselineskip}\fi
    \bj@abstractblock{\bj@eabstractbody}\fi
  \ifx\bj@keywords\@empty\else
    \vspace{0.5\baselineskip}%
    \bj@abstractblock{\hspace*{-1\zw}\bj@keywordsname\bj@keywords}\fi
  \vspace{28.8pt}%
  \endgroup}

\renewcommand\maketitle{%
  \twocolumn[\bj@maketitle]%
  \thispagestyle{empty}}

%% ---------------------------------------------------------------
%% 数式（別行立て・通し番号。要項 5.）
%% ---------------------------------------------------------------
\numberwithin{equation}{section}
\renewcommand\theequation{\arabic{equation}}   % 通し番号（節ごとにリセットしない）
\@removefromreset{equation}{section}

%% ---------------------------------------------------------------
%% 参照文献（要項 7.: 著者年方式、リスト見出し「文献」、番号なし）
%% ---------------------------------------------------------------
\RequirePackage[
  backend=biber,
  bibstyle=bunkajoho,
  citestyle=bunkajoho,
  sorting=nyt,
  maxcitenames=2, mincitenames=1,
  maxbibnames=99,
  uniquename=false, uniquelist=false,
  dashed=false,
  autolang=none,
  language=english,
]{biblatex}
\DefineBibliographyStrings{english}{
  references = {\bj@refname},
}
\defbibheading{bibliography}[\bj@refname]{\bj@unnumberedhead{#1}}

%% ---------------------------------------------------------------
%% その他
%% ---------------------------------------------------------------
\RequirePackage[hidelinks]{hyperref}
\endinput
