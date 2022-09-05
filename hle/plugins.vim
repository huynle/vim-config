""" PLUGINS START """"

" ############ PLUG
call plug#begin($PLUGGED)

" ==========================================
" # Interface
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
" easy movement
Plug 'tpope/vim-unimpaired'
" for commenting
Plug 'tpope/vim-commentary'
" Substitution on crack
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-scriptease'

Plug 'haya14busa/incsearch.vim'
Plug 'easymotion/vim-easymotion'
" A little better asterisk searching
Plug 'haya14busa/vim-asterisk'
" move real fast
Plug 'rhysd/accelerated-jk'
" show indent lines.. for those huge nested for loops
Plug 'Yggdroot/indentLine'
" find start/end of function, parens..
Plug 'andymass/vim-matchup'
" yank across ssh/terminals
Plug 'ojroques/vim-oscyank'
" underline current word
Plug 'itchyny/vim-cursorword'
Plug 'szw/vim-maximizer'
" some tab
Plug 'pacha/vem-tabline'
" getting the editor setup just right for filetype
Plug 'editorconfig/editorconfig-vim'

" for tmux to move around with hjkl
Plug 'christoomey/vim-tmux-navigator'

" fuzzy searcher
Plug 'ctrlpvim/ctrlp.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" peek at your registers
Plug 'junegunn/vim-peekaboo'
" get your stuff aligned
Plug 'junegunn/vim-easy-align'

" File tree explorer
Plug 'lambdalisue/fern.vim'
Plug 'preservim/nerdtree'

" ==========================================
" # Dev Environment
Plug 'tpope/vim-dotenv'
Plug 'xolox/vim-misc' | Plug 'xolox/vim-session'
" Loading custom VIMrc per project
Plug 'huynle/vim-localvimrc'
" for async testing and building
Plug 'tpope/vim-dispatch'
" gitting stuff
Plug 'tpope/vim-fugitive'
" for ctag tagging
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'
" tagbar for all the tags and lsp
Plug 'liuchengxu/vista.vim'



" ==========================================
" Lanuage specifics
" C++ 
Plug 'octol/vim-cpp-enhanced-highlight', { 'for': 'cpp'}
Plug 'derekwyatt/vim-fswitch', { 'for': 'cpp'}



" ==========================================
" all your testing needs
Plug 'vim-test/vim-test'

" ===================================
" formatting
Plug 'Chiel92/vim-autoformat'


" ==========================================
" Completion
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
" automatic installation of language servers
Plug 'prabirshrestha/vim-lsp' | Plug 'mattn/vim-lsp-settings' 
Plug 'prabirshrestha/asyncomplete-tags.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'

if has('python3')
	" Plug 'SirVer/ultisnips'
	Plug 'honza/vim-snippets' | Plug 'SirVer/ultisnips' | Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
end

" For Linting
" Plug 'neomake/neomake'

" For Debuggin
"
if has('python3')
	Plug 'puremourning/vimspector'
end
" autocmd! User vimspector source $VIMPATH/config/plugins/vimspector.vim
" autocmd! User vimspector SourceConfig "plugins/vimspector.vim"



" ==========================================
" Theming
Plug 'kaicataldo/material.vim', { 'branch': 'main' }

call plug#end()

""" PLUGINS END """"

" SourceConfig "configs/easymotion.vim"
" SourceConfig "configs/autoformat.vim"
" SourceConfig "configs/asyncomplete.vim"
" SourceConfig "configs/vim-lsp.vim"
" SourceConfig "configs/vim-lsp-settings.vim"
" SourceConfig "configs/vimspector.vim"

" SourceConfig "configs/vim-test.vim"
" vim: set ts=2 sw=2 tw=80 noet :
