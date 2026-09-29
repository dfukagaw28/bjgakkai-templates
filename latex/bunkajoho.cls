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
%% に基づいて作成。版面・タイトルページ・見出しの体裁は、刊行された論文 PDF（InDesign 組版）の
%% 実測値に合わせている（タイトル部の構成は学会事務局の Word テンプレートも参照）。
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
%% 基本レイアウト（刊行版の組版に準拠）
%%   寸法は刊行版 PDF の実測値（単位 bp = 1/72 inch）
%%   A4, 本文 10bp, 行送り 14.6bp, 2段組（22字×46行×2段）, 段間 22.5bp
%%   左右の余白 66.3bp（≒23.4mm）, 1行目のベースラインは紙面上端から約 110bp
%%   ※ 学会事務局の Word テンプレート（9bp・22字詰め）は刊行版の字詰めに合わせたもの
%%   要項: 研究論文は刷り上がり20ページ・約30,000字以内
%% ---------------------------------------------------------------
\LoadClass[
  paper=a4,
  twocolumn,
  fontsize=10bp,
  jafontsize=10bp,
  baselineskip=14.6bp,
  line_length=22zw,    % 1段の字数（2段組では段ごとの長さ）
  column_gap=22.5bp,
  number_of_lines=46,
  head_space=101.1bp,
  gutter=66.3bp,
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
%%   刊行版に合わせ、ゴシック（太字なし）・字下げなし。
%%   節: 11.5bp, 2行取り（段の途中では前に1行空ける）, 番号は「1.」
%%   項以下: 10bp, 1行取り（前に1行空ける）, 番号は「1.1」「1.1.1」
%% ---------------------------------------------------------------
\setcounter{secnumdepth}{3}
\newcommand*\bj@headfont{\sffamily\gtfamily}
\RenewBlockHeading{section}{1}{font={\fontsize{11.5bp}{15.9bp}\selectfont\bj@headfont}, lines=2, before_lines=1, after_lines=0, label_format={\thesection.}}
\RenewBlockHeading{subsection}{2}{font={\normalsize\bj@headfont}, lines=1, before_lines=1, after_lines=0, label_format={\thesubsection}}
\RenewBlockHeading{subsubsection}{3}{font={\normalsize\bj@headfont}, lines=1, before_lines=0, after_lines=0, label_format={\thesubsubsection}}
%% 見出しが続く場合: 項以下の前の空行は入れない（刊行版では節見出しの次の行に項見出しが来る）
\SetBlockHeadingSpaces{
  {_section{*},_subsection{lines=1}}
  {_section{*},_subsection{lines=1},_subsubsection{lines=1}}
  {_subsection{*},_subsubsection{lines=1}}
}

%% 図表キャプション（9bp ゴシック）
\DeclareCaptionFont{bjcaption}{\fontsize{9bp}{13bp}\selectfont\bj@headfont}
\captionsetup{font=bjcaption, labelfont=bjcaption}

%% 脚注（8.5bp）
\renewcommand\footnotesize{\fontsize{8.5bp}{13bp}\selectfont}

%% 番号なし見出し（謝辞・文献・付録）
%%   刊行版の「引用文献」「附録」見出しに合わせ、項と同じ 10bp で組む
\newcommand*\bj@unnumberedhead[1]{\subsection*{#1}\addcontentsline{toc}{section}{#1}}
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
%%   刊行版・Word テンプレートに合わせ、種別・表題・副題・著者名・要旨 のみを置く。
%% ---------------------------------------------------------------
\newcommand*\bj@title{}\newcommand*\bj@subtitle{}
\newcommand*\bj@authors{}
\renewcommand*\title[1]{\renewcommand*\bj@title{#1}}
\newcommand*\subtitle[1]{\renewcommand*\bj@subtitle{#1}}
\renewcommand*\author[1]{\renewcommand*\bj@authors{#1}}

%% 要旨は環境として蓄える（和文・英文いずれでも可）
\newcommand*\bj@abstractbody{}
\RenewDocumentEnvironment{abstract}{+b}{\gdef\bj@abstractbody{#1}}{}

%% タイトル部（刊行版の1ページ目に準拠。位置は種別ラベルのベースラインからの距離）
%%   種別ラベル 10bp ゴシック（本文1行目と同じ高さ）＋ 版面幅の水平線
%%   表題 16bp ゴシック（行送り 28.3bp）・副題 12bp ゴシック「―副題―」: 中心を +53.5bp に置く
%%   著者名 12bp ゴシック, 右寄せ（右端から 20bp 内側）: ベースライン +128.5bp
%%   要旨 9bp, 行送り 12bp, 左右 20bp 字下げ, 段落頭1字下げ, 見出しなし: 1行目を著者名の 56bp 下に置く
%%   本文はタイトル部の後、少なくとも 34bp 空けて始める（行送りの整数倍に切り上げ）
\newdimen\bj@pos   % 直前に置いたものの下端（種別ラベルのベースラインからの距離）
\newcommand\bj@placeat[2]{% #1: ボックス #2 の上端を置く位置
  \@tempdima=\dimexpr#1\relax
  \kern\dimexpr\@tempdima-\bj@pos\relax
  \global\bj@pos=\dimexpr\@tempdima+\ht#2+\dp#2\relax
  \box#2}
\newcommand\bj@placebase[2]{% #1: ボックス #2 の1行目のベースラインの位置（#2 は \vtop）
  \bj@placeat{#1-\ht#2}{#2}}
\newcommand*\bj@normalskip{\lineskiplimit\z@\lineskip 1pt\relax}% \offinterlineskip を打ち消す
\newcommand*\bj@abstractwidth{\dimexpr\textwidth-40bp\relax}

\newcommand\bj@maketitle{%
  \begingroup
  \offinterlineskip
  \setlength\parindent{0pt}%
  % 種別ラベル
  % 種別ラベル（ベースラインを本文1行目と揃える）
  \setbox\z@\hbox{\fontsize{10bp}{14.6bp}\selectfont\bj@headfont\bj@typename}%
  \kern\dimexpr\topskip-\ht\z@\relax
  \global\bj@pos=\dp\z@ \box\z@
  % 水平線（ラベルのベースラインの 4bp 下）
  \kern\dimexpr4pt-\bj@pos\relax\hrule height 0.75pt
  \global\bj@pos=4.75bp
  % 表題・副題
  \setbox\@tempboxa\vbox{\hsize\textwidth\centering\bj@normalskip
    {\fontsize{16bp}{28.3bp}\selectfont\bj@headfont\bj@title\par}%
    \ifx\bj@subtitle\@empty\else
      \vskip 9.8bp{\fontsize{12bp}{17bp}\selectfont\bj@headfont ―\bj@subtitle―\par}\fi}%
  \bj@placeat{53.5bp-(\ht\@tempboxa+\dp\@tempboxa)/2}{\@tempboxa}%
  % 著者名
  \setbox\@tempboxa\vtop{\hsize\textwidth\raggedleft\bj@normalskip
    {\fontsize{12bp}{17bp}\selectfont\bj@headfont\bj@authors\hspace*{20bp}\par}}%
  \@tempdimb=\dimexpr\bj@pos+24bp+\ht\@tempboxa\relax
  \ifdim\@tempdimb<128.5bp\@tempdimb=128.5bp\fi
  \edef\bj@authorbase{\the\@tempdimb}%
  \bj@placebase{\@tempdimb}{\@tempboxa}%
  % 要旨
  \setbox\@tempboxa\vtop{\bj@normalskip
    \ifx\bj@abstractbody\@empty\else
      \bj@abstractpar{\bj@abstractbody}\fi}%
  \ifdim\dimexpr\ht\@tempboxa+\dp\@tempboxa\relax>\z@
    \@tempdimb=\dimexpr\bj@pos+20bp+\ht\@tempboxa\relax
    \ifdim\@tempdimb<\dimexpr\bj@authorbase+56bp\relax\@tempdimb=\dimexpr\bj@authorbase+56bp\relax\fi
    \bj@placebase{\@tempdimb}{\@tempboxa}%
  \fi
  % 本文までの空き（本文1行目のベースラインまで 34bp 以上）
  \kern\dimexpr34pt-\topskip\relax
  \endgroup}

%% 要旨の段落（9bp, 行送り 12bp, 左右 20bp 字下げ, 段落頭1字下げ）
\newcommand\bj@abstractpar[1]{%
  \moveright 20bp\vtop{\hsize\bj@abstractwidth
    \fontsize{9bp}{12bp}\selectfont
    \parindent 1\zw #1\par}}

%% タイトル部の高さを行送りの整数倍に切り上げ、本文の行位置を揃える
\newcommand\bj@gridtitle{%
  \setbox\@tempboxa\vbox{\bj@maketitle}%
  \@tempdima=\dimexpr\ht\@tempboxa+\dp\@tempboxa\relax
  \@tempcnta=\numexpr\@tempdima/\baselineskip\relax
  \ifdim\@tempcnta\baselineskip<\@tempdima\advance\@tempcnta\@ne\fi
  \vbox to \@tempcnta\baselineskip{\unvbox\@tempboxa\vfil}}

\renewcommand\maketitle{%
  \twocolumn[\bj@gridtitle]%
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
%% 本文中引用の括弧: 和文論文は全角（ ）、英語論文は半角 ( )（bunkajoho.cbx）
\ifbj@english\newcommand*\bjciteopen{(}\newcommand*\bjciteclose{)}\fi
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
%% 文献リスト: 9bp, 行送り 13bp, ぶら下げ 2字（18bp）
\renewcommand*{\bibfont}{\fontsize{9bp}{13bp}\selectfont}
\setlength{\bibhang}{18bp}

%% ---------------------------------------------------------------
%% その他
%% ---------------------------------------------------------------
\RequirePackage[hidelinks]{hyperref}
\endinput
