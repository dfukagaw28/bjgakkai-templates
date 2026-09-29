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
%% に基づいて作成。判型・字詰め等は要項に明記がないため暫定値。
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
%% 基本レイアウト（暫定値: A4, 10pt, 38字×40行 ≒ 1,500字/頁）
%%   要項: 研究論文は刷り上がり20ページ・約30,000字以内
%% ---------------------------------------------------------------
\LoadClass[
  paper=a4,
  fontsize=10pt,
  jafontsize=10pt,
  line_length=38zw,
  number_of_lines=40,
  head_space=25mm,
  gutter=25mm,
  headfoot_verticalposition=1.5zw,
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
%% ---------------------------------------------------------------
\setcounter{secnumdepth}{3}
\jlreqsetup{
  caption_font=\normalfont,
  caption_label_font=\bfseries,
}
\RenewBlockHeading{section}{1}{font=\Large\bfseries\sffamily, lines=2, before_space=1\baselineskip, after_space=0.5\baselineskip, label_format={\thesection}, subtitle_font=\normalsize}
\RenewBlockHeading{subsection}{2}{font=\large\bfseries\sffamily, lines=1.5, before_space=0.75\baselineskip, after_space=0.25\baselineskip, label_format={\thesubsection}}
\RenewBlockHeading{subsubsection}{3}{font=\normalsize\bfseries\sffamily, lines=1, before_space=0.5\baselineskip, after_space=0pt, label_format={\thesubsubsection}}

%% 番号なし見出し（謝辞・文献・付録）
\newcommand*\bj@unnumberedhead[1]{\section*{#1}\addcontentsline{toc}{section}{#1}}
\newenvironment{acknowledgments}{\bj@unnumberedhead{\bj@acknowledgmentsname}}{}
\renewcommand\appendix{%
  \setcounter{section}{0}\setcounter{subsection}{0}%
  \renewcommand\thesection{\bj@appendixname\Alph{section}}%
  \ifbj@english\renewcommand\thesection{\Alph{section}}\fi
}

%% ---------------------------------------------------------------
%% ページ番号（第1ページから通し番号。要項 4.）
%% ---------------------------------------------------------------
\ModifyPageStyle{plain}{nombre_position=bottom-center, running_head_position=top-right}
\pagestyle{plain}
\newcommand*\runninghead[1]{\def\bj@runninghead{#1}}
\runninghead{}
\ModifyPageStyle{plain}{odd_running_head={\bj@runninghead}, even_running_head={\bj@runninghead}}

%% ---------------------------------------------------------------
%% タイトルページ要素（要項 4.: タイトル・種別・著者名・アブストラクト）
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

\renewcommand\maketitle{%
  \thispagestyle{plain}%
  \begingroup
  \setlength\parindent{0pt}%
  % 種別ラベル
  {\sffamily\small\bj@typename\par}
  \vspace{1.5\baselineskip}
  % 表題
  \begin{center}
    {\LARGE\bfseries\sffamily\bj@title\par}
    \ifx\bj@subtitle\@empty\else\vspace{0.3\baselineskip}{\large\bfseries\sffamily ---\,\bj@subtitle\,---\par}\fi
    \ifx\bj@etitle\@empty\else\vspace{0.5\baselineskip}{\large\bj@etitle\par}\fi
    \vspace{1\baselineskip}
    {\large\bj@authors\par}
    \ifx\bj@affiliation\@empty\else{\small\bj@affiliation\par}\fi
    \ifx\bj@eauthors\@empty\else\vspace{0.2\baselineskip}{\normalsize\bj@eauthors\par}\fi
  \end{center}
  \vspace{1\baselineskip}
  % 要旨
  \ifx\bj@abstractbody\@empty\else
    \begin{list}{}{\leftmargin=2\zw\rightmargin=2\zw\itemindent=0pt\listparindent=1\zw\parsep=0pt}
      \item\relax{\bfseries\bj@abstractname}\par\nobreak
      \small\bj@abstractbody
    \end{list}
  \fi
  \ifx\bj@eabstractbody\@empty\else
    \begin{list}{}{\leftmargin=2\zw\rightmargin=2\zw\itemindent=0pt\listparindent=1\zw\parsep=0pt}
      \item\relax{\bfseries Abstract}\par\nobreak
      \small\bj@eabstractbody
    \end{list}
  \fi
  \ifx\bj@keywords\@empty\else
    \vspace{0.5\baselineskip}
    {\small\hspace{2\zw}\textbf{\bj@keywordsname}\bj@keywords\par}
  \fi
  \vspace{1.5\baselineskip}
  \endgroup
}

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
