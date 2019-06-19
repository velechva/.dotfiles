# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/flex/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

export LS_COLORS="ow=0;38;2;102;217;239:di=0;38;2;102;217;239:*~=0;38;2;122;112;112:mi=0;38;2;0;0;0;48;2;255;74;68:no=0:ln=0;38;2;249;38;114:so=0;38;2;0;0;0;48;2;249;38;114:pi=0;38;2;0;0;0;48;2;102;217;239:fi=0:ex=1;38;2;249;38;114:or=0;38;2;0;0;0;48;2;255;74;68:*.o=0;38;2;122;112;112:*.c=0;38;2;0;255;135:*.m=0;38;2;0;255;135:*.d=0;38;2;0;255;135:*.t=0;38;2;0;255;135:*.h=0;38;2;0;255;135:*.a=1;38;2;249;38;114:*.z=4;38;2;249;38;114:*.r=0;38;2;0;255;135:*.p=0;38;2;0;255;135:*.rs=0;38;2;0;255;135:*.vb=0;38;2;0;255;135:*.pl=0;38;2;0;255;135:*.hh=0;38;2;0;255;135:*.el=0;38;2;0;255;135:*css=0;38;2;0;255;135:*.pm=0;38;2;0;255;135:*.so=1;38;2;249;38;114:*.xz=4;38;2;249;38;114:*.fs=0;38;2;0;255;135:*.md=0;38;2;226;209;57:*.kt=0;38;2;0;255;135:*.rm=0;38;2;253;151;31:*.js=0;38;2;0;255;135:*.di=0;38;2;0;255;135:*.cp=0;38;2;0;255;135:*.bz=4;38;2;249;38;114:*.sh=0;38;2;0;255;135:*.gz=4;38;2;249;38;114:*.go=0;38;2;0;255;135:*.cc=0;38;2;0;255;135:*.hi=0;38;2;122;112;112:*.lo=0;38;2;122;112;112:*.pp=0;38;2;0;255;135:*.7z=4;38;2;249;38;114:*.la=0;38;2;122;112;112:*.nb=0;38;2;0;255;135:*.gv=0;38;2;0;255;135:*.hs=0;38;2;0;255;135:*.ko=1;38;2;249;38;114:*.ml=0;38;2;0;255;135:*.as=0;38;2;0;255;135:*.cs=0;38;2;0;255;135:*.jl=0;38;2;0;255;135:*.rb=0;38;2;0;255;135:*.ui=0;38;2;166;226;46:*.mn=0;38;2;0;255;135:*.ts=0;38;2;0;255;135:*.py=0;38;2;0;255;135:*.ps=0;38;2;230;219;116:*.cr=0;38;2;0;255;135:*.ex=0;38;2;0;255;135:*.dox=0;38;2;166;226;46:*.deb=4;38;2;249;38;114:*.xcf=0;38;2;253;151;31:*.kex=0;38;2;230;219;116:*.bst=0;38;2;166;226;46:*TODO=1:*.wmv=0;38;2;253;151;31:*.fnt=0;38;2;253;151;31:*.pro=0;38;2;166;226;46:*.fon=0;38;2;253;151;31:*.mov=0;38;2;253;151;31:*.sxi=0;38;2;230;219;116:*.tsx=0;38;2;0;255;135:*.jpg=0;38;2;253;151;31:*.zip=4;38;2;249;38;114:*.fls=0;38;2;122;112;112:*.asa=0;38;2;0;255;135:*.pod=0;38;2;0;255;135:*.jar=4;38;2;249;38;114:*.kts=0;38;2;0;255;135:*.exe=1;38;2;249;38;114:*.tgz=4;38;2;249;38;114:*.aif=0;38;2;253;151;31:*.inl=0;38;2;0;255;135:*.vob=0;38;2;253;151;31:*.yml=0;38;2;166;226;46:*.pgm=0;38;2;253;151;31:*.aux=0;38;2;122;112;112:*.pid=0;38;2;122;112;112:*.img=4;38;2;249;38;114:*.ogg=0;38;2;253;151;31:*.wma=0;38;2;253;151;31:*.xmp=0;38;2;166;226;46:*.avi=0;38;2;253;151;31:*.ps1=0;38;2;0;255;135:*.csv=0;38;2;226;209;57:*.tmp=0;38;2;122;112;112:*.out=0;38;2;122;112;112:*.lua=0;38;2;0;255;135:*.tbz=4;38;2;249;38;114:*.ppt=0;38;2;230;219;116:*.zsh=0;38;2;0;255;135:*.blg=0;38;2;122;112;112:*.mid=0;38;2;253;151;31:*.otf=0;38;2;253;151;31:*.rar=4;38;2;249;38;114:*.vcd=4;38;2;249;38;114:*.toc=0;38;2;122;112;112:*.ltx=0;38;2;0;255;135:*.ods=0;38;2;230;219;116:*.sty=0;38;2;122;112;112:*.bsh=0;38;2;0;255;135:*.rpm=4;38;2;249;38;114:*.vim=0;38;2;0;255;135:*.swf=0;38;2;253;151;31:*.dmg=4;38;2;249;38;114:*.gvy=0;38;2;0;255;135:*.bat=1;38;2;249;38;114:*.bak=0;38;2;122;112;112:*.wav=0;38;2;253;151;31:*.log=0;38;2;122;112;112:*.bib=0;38;2;166;226;46:*.pbm=0;38;2;253;151;31:*.xlr=0;38;2;230;219;116:*.pas=0;38;2;0;255;135:*.ttf=0;38;2;253;151;31:*.mpg=0;38;2;253;151;31:*.ics=0;38;2;230;219;116:*.idx=0;38;2;122;112;112:*.dot=0;38;2;0;255;135:*.pps=0;38;2;230;219;116:*.doc=0;38;2;230;219;116:*.pyc=0;38;2;122;112;112:*hgrc=0;38;2;166;226;46:*.sxw=0;38;2;230;219;116:*.cpp=0;38;2;0;255;135:*.bmp=0;38;2;253;151;31:*.tar=4;38;2;249;38;114:*.mkv=0;38;2;253;151;31:*.elm=0;38;2;0;255;135:*.ilg=0;38;2;122;112;112:*.bag=4;38;2;249;38;114:*.rtf=0;38;2;230;219;116:*.fsi=0;38;2;0;255;135:*.m4v=0;38;2;253;151;31:*.tcl=0;38;2;0;255;135:*.php=0;38;2;0;255;135:*.nix=0;38;2;166;226;46:*.cfg=0;38;2;166;226;46:*.odp=0;38;2;230;219;116:*.fsx=0;38;2;0;255;135:*.clj=0;38;2;0;255;135:*.h++=0;38;2;0;255;135:*.flv=0;38;2;253;151;31:*.git=0;38;2;122;112;112:*.pdf=0;38;2;230;219;116:*.cxx=0;38;2;0;255;135:*.ind=0;38;2;122;112;112:*.bz2=4;38;2;249;38;114:*.gif=0;38;2;253;151;31:*.bin=4;38;2;249;38;114:*.svg=0;38;2;253;151;31:*.txt=0;38;2;226;209;57:*.mli=0;38;2;0;255;135:*.pkg=4;38;2;249;38;114:*.iso=4;38;2;249;38;114:*.sbt=0;38;2;0;255;135:*.com=1;38;2;249;38;114:*.cgi=0;38;2;0;255;135:*.mp4=0;38;2;253;151;31:*.png=0;38;2;253;151;31:*.csx=0;38;2;0;255;135:*.erl=0;38;2;0;255;135:*.odt=0;38;2;230;219;116:*.tif=0;38;2;253;151;31:*.hpp=0;38;2;0;255;135:*.xls=0;38;2;230;219;116:*.sql=0;38;2;0;255;135:*.tml=0;38;2;166;226;46:*.swp=0;38;2;122;112;112:*.dll=1;38;2;249;38;114:*.awk=0;38;2;0;255;135:*.epp=0;38;2;0;255;135:*.apk=4;38;2;249;38;114:*.bbl=0;38;2;122;112;112:*.xml=0;38;2;226;209;57:*.ico=0;38;2;253;151;31:*.dpr=0;38;2;0;255;135:*.hxx=0;38;2;0;255;135:*.ini=0;38;2;166;226;46:*.c++=0;38;2;0;255;135:*.bcf=0;38;2;122;112;112:*.arj=4;38;2;249;38;114:*.ppm=0;38;2;253;151;31:*.mp3=0;38;2;253;151;31:*.htm=0;38;2;226;209;57:*.htc=0;38;2;0;255;135:*.ipp=0;38;2;0;255;135:*.exs=0;38;2;0;255;135:*.rst=0;38;2;226;209;57:*.tex=0;38;2;0;255;135:*.jpeg=0;38;2;253;151;31:*.bash=0;38;2;0;255;135:*.lisp=0;38;2;0;255;135:*.lock=0;38;2;122;112;112:*.flac=0;38;2;253;151;31:*.toml=0;38;2;166;226;46:*.tbz2=4;38;2;249;38;114:*.dart=0;38;2;0;255;135:*.mpeg=0;38;2;253;151;31:*.less=0;38;2;0;255;135:*.pptx=0;38;2;230;219;116:*.fish=0;38;2;0;255;135:*.json=0;38;2;166;226;46:*.diff=0;38;2;0;255;135:*.rlib=0;38;2;122;112;112:*.orig=0;38;2;122;112;112:*.docx=0;38;2;230;219;116:*.conf=0;38;2;166;226;46:*.make=0;38;2;166;226;46:*.hgrc=0;38;2;166;226;46:*.xlsx=0;38;2;230;219;116:*.h264=0;38;2;253;151;31:*.yaml=0;38;2;166;226;46:*.psm1=0;38;2;0;255;135:*.psd1=0;38;2;0;255;135:*.html=0;38;2;226;209;57:*.epub=0;38;2;230;219;116:*.purs=0;38;2;0;255;135:*.java=0;38;2;0;255;135:*.toast=4;38;2;249;38;114:*.shtml=0;38;2;226;209;57:*README=0;38;2;0;0;0;48;2;230;219;116:*.scala=0;38;2;0;255;135:*.mdown=0;38;2;226;209;57:*.patch=0;38;2;0;255;135:*.dyn_o=0;38;2;122;112;112:*.cabal=0;38;2;0;255;135:*.swift=0;38;2;0;255;135:*.xhtml=0;38;2;226;209;57:*passwd=0;38;2;166;226;46:*.cache=0;38;2;122;112;112:*.class=0;38;2;122;112;112:*.cmake=0;38;2;166;226;46:*shadow=0;38;2;166;226;46:*.ipynb=0;38;2;0;255;135:*.groovy=0;38;2;0;255;135:*.dyn_hi=0;38;2;122;112;112:*INSTALL=0;38;2;0;0;0;48;2;230;219;116:*.flake8=0;38;2;166;226;46:*COPYING=0;38;2;182;182;182:*.matlab=0;38;2;0;255;135:*.ignore=0;38;2;166;226;46:*.config=0;38;2;166;226;46:*TODO.md=1:*.gradle=0;38;2;0;255;135:*LICENSE=0;38;2;182;182;182:*Makefile=0;38;2;166;226;46:*.desktop=0;38;2;166;226;46:*Doxyfile=0;38;2;166;226;46:*.gemspec=0;38;2;166;226;46:*TODO.txt=1:*setup.py=0;38;2;166;226;46:*.kdevelop=0;38;2;166;226;46:*.fdignore=0;38;2;166;226;46:*README.md=0;38;2;0;0;0;48;2;230;219;116:*configure=0;38;2;166;226;46:*.rgignore=0;38;2;166;226;46:*.cmake.in=0;38;2;166;226;46:*COPYRIGHT=0;38;2;182;182;182:*.markdown=0;38;2;226;209;57:*.gitconfig=0;38;2;166;226;46:*README.txt=0;38;2;0;0;0;48;2;230;219;116:*.scons_opt=0;38;2;122;112;112:*INSTALL.md=0;38;2;0;0;0;48;2;230;219;116:*Dockerfile=0;38;2;166;226;46:*SConstruct=0;38;2;166;226;46:*.gitignore=0;38;2;166;226;46:*SConscript=0;38;2;166;226;46:*CODEOWNERS=0;38;2;166;226;46:*Makefile.am=0;38;2;166;226;46:*.synctex.gz=0;38;2;122;112;112:*MANIFEST.in=0;38;2;166;226;46:*Makefile.in=0;38;2;122;112;112:*.gitmodules=0;38;2;166;226;46:*.travis.yml=0;38;2;230;219;116:*LICENSE-MIT=0;38;2;182;182;182:*.fdb_latexmk=0;38;2;122;112;112:*appveyor.yml=0;38;2;230;219;116:*CONTRIBUTORS=0;38;2;0;0;0;48;2;230;219;116:*configure.ac=0;38;2;166;226;46:*.applescript=0;38;2;0;255;135:*.clang-format=0;38;2;166;226;46:*.gitattributes=0;38;2;166;226;46:*CMakeCache.txt=0;38;2;122;112;112:*INSTALL.md.txt=0;38;2;0;0;0;48;2;230;219;116:*LICENSE-APACHE=0;38;2;182;182;182:*CMakeLists.txt=0;38;2;166;226;46:*CONTRIBUTORS.md=0;38;2;0;0;0;48;2;230;219;116:*CONTRIBUTORS.txt=0;38;2;0;0;0;48;2;230;219;116:*requirements.txt=0;38;2;166;226;46:*.sconsign.dblite=0;38;2;122;112;112:*package-lock.json=0;38;2;122;112;112"
