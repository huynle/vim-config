""" should be general settings that we can use to create a vim minimal setting
"" make some sane defaults to run vim without plugins
"" used for editing files on servers

" Release keymappings for other purposes
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>
nnoremap ;        <Nop>
xnoremap ;        <Nop>

set mouse=nv                 " Disable mouse in command-line mode
set modeline                 " automatically setting options from modelines
set lazyredraw
set report=0                 " Don't report on line changes
set noerrorbells             " Trigger bell on error
set novisualbell             " Use visual bell instead of beeping
set hidden                   " hide buffers when abandoned instead of unload
set fileformats=unix,dos,mac " Use Unix as the standard file type
set magic                    " For regular expressions turn magic on
set path=.,**                " Directories to search when using gf
set virtualedit=block        " Position cursor anywhere in visual block
set synmaxcol=2500           " Don't syntax highlight long lines
set formatoptions=1jcroql    " Don't auto-wrap text
set tags=./tags;
" set exrc
" set secure

" What to save for views and sessions
set viewoptions=folds,cursor,curdir,slash,unix
" set sessionoptions=blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal
set sessionoptions=curdir,help,tabpages,winsize,folds,winpos



" Tabs and Indents {{{
" ----------------
set textwidth=120   " Text width maximum chars before wrapping
set expandtab       " expand tabs to spaces.
set tabstop=2       " The number of spaces a tab is
set softtabstop=2   " While performing editing operations
set shiftwidth=2    " Number of spaces to use in auto(indent)
set smarttab        " Tab insert blanks according to 'shiftwidth'
set autoindent      " Use same indenting on new lines
set smartindent     " Smart autoindenting on new lines
set shiftround      " Round indent to multiple of 'shiftwidth'
set breakindentopt=shift:2 "
set breakindentopt+=min:20

" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
set smartindent				" configure tabwidth and insert spaces instead of tabs
set expandtab        	" expand tabs to spaces
set t_Co=256
set number 		" highlight matching braces
set relativenumber
set showmatch
set comments=sl:/*,mb:\ *,elx:\ */ " intelligent comments

" }}}
" Timing {{{
" ------
set timeout
set ttimeout
set updatetime=100 " Idle time to write swap and trigger CursorHold
set timeoutlen=200  " Time out on mappings

" Time out on key codes
set ttimeoutlen=50
set redrawtime=1500

" }}}
" Searching {{{
" ---------
set ignorecase      " Search ignoring case
set smartcase       " Keep case when searching with *
set infercase       " Adjust case in insert completion mode
set incsearch       " Incremental search
set hlsearch        " Highlight search results
set wrapscan        " Searches wrap around the end of the file
set showmatch       " Jump to matching bracket
set matchtime=1     " Tenths of a second to show the matching paren
set cpoptions-=m    " showmatch will wait 0.5s or until a char is typed
set grepformat=%f:%l:%c:%m
" }}}

" Behavior {{{
" --------
set nowrap                      " No wrap by default
set linebreak                   " Break long lines at 'breakat'
set breakat=\ \	;:,!?           " Long lines break chars
set nostartofline               " Cursor in same column for few commands
set whichwrap+=h,l,<,>,[,],~    " Move to following line on certain keys
set splitbelow
set splitright                  " Splits open bottom right
set switchbuf=useopen,usetab    " Jump to the first open window in any tab
set backspace=indent,eol,start  " Intuitive backspacing in insert mode
" set diffopt=filler,iwhite,internal,algorithm:patience 
set diffopt=filler,iwhite  " Diff mode: show fillers, ignore white
set showfulltag                 " Show tag and tidy search in completion


set undofile
set noswapfile
set nobackup
set directory=$DATAPATH/swap//,$DATAPATH,~/tmp,/var/tmp,/tmp
set undodir=$DATAPATH/undo//,$DATAPATH,~/tmp,/var/tmp,/tmp
set backupdir=$DATAPATH/backup/,$DATAPATH,~/tmp,/var/tmp,/tmp
set viewdir=$DATAPATH/view/
set nospell
set spellfile=$VIMPATH/spell/en.utf-8.add


set completeopt=menuone,noselect
if has('patch-7.4.775')
	set completeopt+=noinsert
endif

if exists('+inccommand')
	set inccommand=nosplit
endif

" }}}

" Editor UI Appearance {{{
" --------------------
set noshowmode          " Don't show mode in cmd window
set shortmess=aoOTIcF   " Shorten messages and don't show intro
set scrolloff=2         " Keep at least 2 lines above/below
set sidescrolloff=5     " Keep at least 5 lines left/right
set number							" Show line numbers
set noruler             " Disable default status ruler
set list                " Show hidden characters

set showtabline=2       " Always show the tabs line
set winwidth=30         " Minimum width for active window
set winheight=1         " Minimum height for active window
set pumheight=15        " Pop-up menu's line height
set helpheight=12       " Minimum help window height
set previewheight=12    " Completion preview height

set noshowcmd           " Don't show command in status line
set cmdheight=1         " Height of the command line
set cmdwinheight=5      " Command-line lines
set noequalalways       " Don't resize windows on split or close
set laststatus=2        " Always show a status line
set display=lastline
set foldenable
set foldlevelstart=99
" set keymodel=startsel
set signcolumn=yes

set showbreak="↳  "
set listchars=tab:»·,nbsp:+,trail:·,extends:→,precedes:←


" Wildmenu {{{
" --------
if has('wildmenu')
  set nowildmenu
  set wildmode=list:longest,full
  set wildoptions=tagfile
  set wildignorecase
  set wildignore+=.git,.hg,.svn,.stversions,*.pyc,*.spl,*.o,*.out,*~,%*
  set wildignore+=*.jpg,*.jpeg,*.png,*.gif,*.zip,**/tmp/**,*.DS_Store
  set wildignore+=**/node_modules/**,**/bower_modules/**,*/.sass-cache/*
  set wildignore+=application/vendor/**,**/vendor/ckeditor/**,media/vendor/**
  set wildignore+=__pycache__,*.egg-info

  set wildignore+=*.sw?                            " Vim swap files
  set wildignore+=*.bak,*.?~,*.??~,*.???~,*.~      " Backup files
  set wildignore+=*.luac                           " Lua byte code
  set wildignore+=*.jar                            " java archives
  set wildignore+=*.pyc                            " Python byte code
  set wildignore+=*.stats                          " Pylint stats

  set wildignore+=node_modules
  set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,*.beam
  set wildignore+=*.jpg,*.jpeg,*.gif,*.png,*.gif,*.psd,*.ico
  set wildignore+=.sass-cache,.DS_Store,.bundle
  set wildignore+=.coffee.js
  set wildignore+=*.rbc,*.scssc,*.sassc
  set wildignore+=*/spec/dummy/*
  set wildignore+=*/tmp/*
  set wildignore+=.idea
endif



" Fast cliboard setup for macOS
if has('mac') && executable('pbcopy') && has('vim_starting')
	let g:clipboard = {
		\   'name': 'macOS-clipboard',
		\   'copy': {
		\      '+': 'pbcopy',
		\      '*': 'pbcopy',
		\    },
		\   'paste': {
		\      '+': 'pbpaste',
		\      '*': 'pbpaste',
		\   },
		\   'cache_enabled': 0,
		\ }
endif

if has('clipboard') && has('vim_starting')
	set clipboard& clipboard+=unnamedplus
" 	" set clipboard& clipboard^=unnamed,unnamedplus
endif


let g:loaded_gzip = 1
let g:loaded_tar = 1
let g:loaded_tarPlugin = 1
let g:loaded_zip = 1
let g:loaded_zipPlugin = 1
let g:loaded_getscript = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_vimball = 1
let g:loaded_vimballPlugin = 1
let g:loaded_matchit = 1
let g:loaded_matchparen = 1
let g:loaded_2html_plugin = 1
let g:loaded_logiPat = 1
let g:loaded_rrhelper = 1



if has('nvim')
  " live substitution withs plit
  set inccommand=split
  " set inccommand=nosplit

  set jumpoptions=stack
  set pumblend=10
  set winblend=10
endif


