%% The MIT License (MIT)
%%
%% Copyright (c) 2015 Daniil Belyakov
%%
%% Permission is hereby granted, free of charge, to any person obtaining a copy
%% of this software and associated documentation files (the "Software"), to deal
%% in the Software without restriction, including without limitation the rights
%% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
%% copies of the Software, and to permit persons to whom the Software is
%% furnished to do so, subject to the following conditions:
%%
%% The above copyright notice and this permission notice shall be included in all
%% copies or substantial portions of the Software.
%%
%% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
%% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
%% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
%% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
%% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
%% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
%% SOFTWARE.
\ProvidesClass{mcdowellcv}[2015/12/15 v1.1.0 McDowell CV class]

% Set up the fonts according to options
\def\mainfontsize{11pt}
\def\mainfontface{Times New Roman}

\DeclareOption{calibri}{%
  \def\mainfontface{Calibri}
}

\ProcessOptions\relax

% Set font size and paper type
\LoadClass[letterpaper,\mainfontsize]{article} 

% Set document margins
\usepackage[left=0.75in,top=0.6in,right=0.75in,bottom=0.6in]{geometry} 

% Set font face
\usepackage{fontspec}

% Remove paragraph indentation
\usepackage[parfill]{parskip} 

% Required for boldface (\bf and \bfseries) tabular columns
\usepackage{array} 

% Required for ifthenelse statements
\usepackage{etoolbox} 
\usepackage{fancyhdr}

\usepackage[hidelinks]{hyperref}

% Suppress page numbers
\pagestyle{empty} 
\pagestyle{fancy}

% Flexible tables
\usepackage{tabu}

% For custom margins
\usepackage{changepage}

\usepackage{multicol}

\usepackage{lastpage}

\usepackage{ifthen}

% To customize lists
\usepackage{enumitem}
% Remove left margin from lists, suppress vertical item separation and set top 
% separation to a negative value to suppress a single parskip before lists
\setlist{leftmargin=*, noitemsep, topsep=-1\parskip}

% For spcaed small caps
\usepackage{microtype}

\usepackage{needspace}

% \hyphenpenalty=10000
% \exhyphenpenalty=10000

\DeclareMicrotypeSet*{smallcapsi} { 
	encoding = {OT1,T1,T2A,LY1,OT4,QX,T5,TS1,EU1,EU2},
	shape    = {sc*,si,scit}
}

%--------------------------------------------------------------------------------
%                                    Constants                                  -
%--------------------------------------------------------------------------------
\def\afterheaderspace{3pt}
\def\beforesectionheaderspace{4.75pt}
\def\sectionheadermargin{6pt}
\def\aftersectionheaderspace{-4pt}
\def\sectionheaderhrlueheight{0.5pt}
\def\aftersinglelinesubsectionheaderspace{-6pt}
\def\afterdoublelinesubsectionheaderspace{0pt}
\def\aftermultilinesubsectionheaderspace{-6pt}
\def\afteremptysubsectionheaderspace{3pt}
\def\subsectionmargin{9pt}
\def\aftersubsectionspace{3pt}


\newcommand{\MONTH}{%
  \ifcase\the\month
  \or January% 1
  \or February% 2
  \or March% 3
  \or April% 4
  \or May% 5
  \or June% 6
  \or July% 7
  \or August% 8
  \or September% 9
  \or October% 10
  \or November% 11
  \or December% 12
  \fi}

%--------------------------------------------------------------------------------
%                            Header Setup and Printing                          -
%--------------------------------------------------------------------------------

% Address
\makeatletter

\newcommand\address[1]{\def\@address{#1}}
\address{}

\newcommand\printaddress{
	\small{\@address}
}

\makeatother

% Name
\makeatletter

\newcommand\name[1]{\def\@name{#1}}
\name{}

\newcommand\printname{
	\textbf{\LARGE\textls[110]{\textsc{\@name}}}
}

\makeatother

% Contacts
\makeatletter

\newcommand\contacts[1]{\def\@contacts{#1}}
\contacts{}

\newcommand\printcontacts{
	\small{\@contacts}
}

\makeatother

\makeatletter
\newcommand\makeheader{
	\begin{center}
		\begin{tabu} to 1\textwidth { X[l,m] X[2,c,m] X[r,m] }
			\printaddress & \printname & \printcontacts \\
		\end{tabu}	
	\end{center}
	\vspace*{\afterheaderspace}
}
\makeatother

%--------------------------------------------------------------------------------
%                            Sections and Subsections                           -
%--------------------------------------------------------------------------------

% Print a section header
\makeatletter
\newenvironment{cvsection}[1]{
  \needspace{5\baselineskip}
	\vspace*{\beforesectionheaderspace}
	% Set text margins to equal \tabcolsep (6pt by default)
	\begin{adjustwidth}{\sectionheadermargin}{\sectionheadermargin}
		\textsc{\textbf{#1}}
	\end{adjustwidth}
	\smallskip
	\hrule height \sectionheaderhrlueheight
	\vspace*{\aftersectionheaderspace}
}{}
\makeatother

% Print a subsection
\makeatletter
% Define toggles checking if titles were defined
\newtoggle{lefttitledefined}
\newtoggle{centertitledefined}
\newtoggle{righttitledefined}


\newenvironment{cvsubsection}[4][1]{
	\notblank{#2}{\toggletrue{lefttitledefined}}{}
	\notblank{#3}{\toggletrue{centertitledefined}}{}
	\notblank{#4}{\toggletrue{righttitledefined}}{}
	\ifboolexpr{togl {lefttitledefined} or togl {centertitledefined} or togl {righttitledefined}}{
		\begin{tabu} to 1\textwidth { X[l,p] X[c,p] X[r,p] }
			\textbf{#2} & \textbf{#3} & \textbf{#4} \\
		\end{tabu}
		% Add space according to the specidied number of lines
		\ifnumcomp{#1}{=}{1}{\vspace*{\aftersinglelinesubsectionheaderspace}}{
			\ifnumcomp{#1}{=}{2}{\vspace*{\afterdoublelinesubsectionheaderspace}}{
				\vspace*{\aftermultilinesubsectionheaderspace}
			}
		}
	}{
		\vspace*{\afteremptysubsectionheaderspace}
	}
	\togglefalse{lefttitledefined}
	\togglefalse{centertitledefined}
	\togglefalse{righttitledefined}
	\begin{adjustwidth}{\subsectionmargin}{\subsectionmargin}
}
{
	\end{adjustwidth}
	\vspace*{\aftersubsectionspace}
}
\makeatother

% Print a job entry
\makeatletter

% Define an environment for the main job entry
\newenvironment{jobentry}[2]{%
		\needspace{5\baselineskip}
    \begin{center}
    \textbf{#1} \\ \textit{#2}\\[0.25em]
    \end{center}
}{%
    \par\vspace{.5em}
}


\newlist{jobpositions}{itemize}{1}
\setlist[jobpositions]{label={}, left=0pt, labelsep=0pt, itemsep=-0.0em, topsep=0pt, partopsep=0pt, parsep=0pt}

% Position entry with itemize
\newcommand{\jobposition}[2]{%
    \item \makebox[\linewidth][s]{#1 \hfill #2}
}

% Job description
\newcommand{\jobdescription}[1]{%
    % \noindent\textbf{Summary}\\
    {#1}
    \vspace{0.1em}
}

% Job responsibilities
\newenvironment{jobresponsibilities}{
		\begin{raggedright}
    \noindent\textbf{Responsibilities}
    \begin{itemize}
}{%
    \end{itemize}
    \end{raggedright}
    \vspace{0.3em}
}

% Notable projects
\newenvironment{jobprojects}{
		\begin{raggedright}
    \noindent\textbf{Notable Projects}
    \begin{itemize}
}{%
    \end{itemize}
    \end{raggedright}
    \vspace{0.3em}
}
\makeatother
\fancyhead{} % Clear header
\renewcommand{\headrulewidth}{0pt}
\fancyfoot{} % Clear footer
\thispagestyle{empty}
\fancyfoot[C]{Page \thepage\ of \pageref{LastPage}}
\newcommand{\customfooter}{
		\setlength{\footskip}{1em}
		\fancyfoot[C]{
			{\footnotesize \quad Ben Virgilio - VERSIONTAGPLACEHOLDER - \MONTH \ \the\year
				\\ \href{https://github.com/nebriv/resume}{Built from GitHub - https://github.com/nebriv/resume}
				\\ Page \thepage\ of \pageref{LastPage}
			}
		}
} 