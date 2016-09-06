%Latex Class to generate resume
%By: Daniel Kurniawan

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[2016/07/11 My custom resume class]

\LoadClass[11pt]{article}

%Section
\RequirePackage{titlesec}

%Margin and paper size
\RequirePackage{geometry}
\geometry{
letterpaper,
top=0.7in,
bottom=0.7in,
left=0.7in,
right=0.7in}

%Package for control statement
\RequirePackage{xifthen}

%%%%%%%%%%%%%%
%FORMATTING
%%%%%%%%%%%%%

%San serif font: Helvetica
\RequirePackage{helvet}

%Serif font: 
\RequirePackage{lmodern}


%USE CLASS OPTION TO CHANGE FONT
%\renewcommand{\familydefault}{\sfdefault}
\newcommand{\sffont}{\renewcommand{\familydefault}{\sfdefault}}
\newcommand{\rmfont}{\renewcommand{\familydefault}{\rmdefault}}

\DeclareOption{sans}{\sffont}
\DeclareOption{roman}{\rmfont}
\ProcessOptions\relax


%Section Formatting
\titleformat{\section}
%format: large (\large),  bold (\bf), capital (\uppercase), left aligned (\raggedright),    
{\large\bfseries\raggedright\uppercase} 
%label: (nothing)                            
{}
%sep: (nothing)
{0pt}
%before -code: (nothing)                    
{}  
%after-code: horizontal line  
[\titlerule]
%spacing: left: 0pt, before: normal skip, after: 1ex
\titlespacing{\section}{0pt}{\baselineskip}{1ex}

%SubSection Formatting
\titleformat{\subsection}
%format:  bold (\bf), left aligned (\raggedright),    
{\bfseries\raggedright} 
%label: (nothing)                            
{}
%sep: (nothing)
{0pt}
%before -code: (nothing)                    
{}  
%after-code:  
[]
%spacing: left: 0pt, before: 1ex, after: 1ex
\titlespacing{\subsection}{0pt}{1ex}{0ex}

%Custom Subsection with date (for work and school)	
\newcommand{\datedsubsection}[2]{%
  \subsection{#1 \hfill \normalfont{#2}}%
}

%Subsubsection formatting
%run-in subsubsection
\titleformat{\subsubsection}[runin] 
%format:  bold (\bf), left aligned (\raggedright),    
{\bfseries\raggedright} 
%label: (nothing)                            
{}
%sep: (nothing)
{0pt}
%before -code: (nothing)                    
{}  
%after-code:, somehow i cannot add other space  
[\thinspace]
%spacing: left: 0pt, before: 1ex, after: 1ex
\titlespacing{\subsubsection}{0pt}{1ex}{0ex}

%Item Formatting
\RequirePackage{enumitem}
\renewcommand{\labelitemi}{\small$\bullet$} 

%No Indent
\setlength\parindent{0pt}

%No Spacing
\setlength\parskip{0pt}

%No page numbering
\pagenumbering{gobble}


% Preamble command
\newcommand{\name}[1]{\def\@name{#1}}
\newcommand{\address}[1]{\def\@address{#1}}
\newcommand{\firstcontact}[1]{\def\@firstcontact{#1}}
\newcommand{\secondcontact}[1]{\def\@secondcontact{#1}}
\newcommand{\thirdcontact}[1]{\def\@thirdcontact{#1}}

%%%%%%%%%%%%%%%%%%
%ENVIRONMENT
%%%%%%%%%%%%%%%%%%

% CONTACT INFO: [Name, Address, Contact 1, (Optional, leave blank) Contact 2, (Optional, leave blank) Contact 3]

\newcommand{\contactInfo}{

\begin{center}
\Huge{\@name} \\ 
\vspace{0.2ex} \footnotesize{\@address} \\
\footnotesize{\@firstcontact}
\ifdefined\@secondcontact
	{$\cdot$} \footnotesize{\@secondcontact}
	\ifdefined\@thirdcontact	
		{$\cdot$} \footnotesize{\@thirdcontact}
	\fi
\fi
\end{center}

}

\AtBeginDocument{\contactInfo}

%OBJECTIVE:
\newenvironment{objective}{\section{Objective}}{}

%EDUCATION:
%%educationitem: [School, Grad Date, Major, GPA (out of 4.00)]
\newenvironment{education}{
	\section{Education}
	\newenvironment{educationitem}[4]{
	
		%optional GPA
		\ifthenelse{\equal{##4}{}}{	
			\datedsubsection{##1}{##2}
			##3
		}{
			\datedsubsection{##1}{##2}
			##3 \\ GPA: ##4 / 4.00
		}
	
	}{}
}{}

%WORK EXPERIENCE:
%%workitem: [Position, Date, Employer, Location]
%%%workdesc (command like item in itemize)
\newenvironment{work}{
	\section{Work Experience}
	\newenvironment{workitem}[4]{
		\datedsubsection{##1}{##2} 
		\emph{##3} \hfill \emph{##4}
		\begin{itemize}[noitemsep, topsep=0pt]
		
	\newcommand{\workdesc}{\item}	
	
	}{ \end{itemize} }
}{}

%SKILLS:
\RequirePackage{tabularx}
\newenvironment{skills}{
	\section{Skills}
	\tabularx{\textwidth}{XXXXX}
}{\endtabularx}


%OTHER CATEGORY: [category title]
\newenvironment{other}[1]{
	\section{#1}
	\newenvironment{otheritem}[1]{
		\subsubsection{##1:}
	}{}
}{}
