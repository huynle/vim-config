
" Key-mappings
"---------------------------------------------------------

" Non-standard {{{
" ------------

" Window-control prefix
nnoremap  [Window]   <Nop>
nmap      s [Window]

" Fix keybind name for Ctrl+Spacebar
map <Nul> <C-Space>
map! <Nul> <C-Space>

" refresh vimrc
nnoremap <F2> :source $VIMRC<CR>

" Disable arrow movement, resize splits instead.
if get(g:, 'elite_mode')
	nnoremap <Up>    :resize +2<CR>
	nnoremap <Down>  :resize -2<CR>
	nnoremap <Left>  :vertical resize +2<CR>
	nnoremap <Right> :vertical resize -2<CR>
endif

" Double leader key for toggling visual-line mode
nmap <silent> <Leader><Leader> V
vmap <Leader><Leader> " Change current word in a repeatable manner
nnoremap cn *``cgn
nnoremap cN *``cgN

" Change selected word in a repeatable manner
vnoremap <expr> cn "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgn"
vnoremap <expr> cN "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgN"

nnoremap cp yap<S-}>p
nnoremap <leader>a =ip

" xnoremap p  "0p
" nnoremap x "_x

" Toggle fold
nnoremap <CR> za

" Focus the current fold by closing all others
nnoremap <S-z> zMza

" Use backspace key for matchit.vim
nmap <BS> %
xmap <BS> %

nmap <Tab>  <C-w>w
nmap <S-Tab>  <C-w>W

" Use to exit insert mode for Neovim terminal and get into normal mode
if has('nvim')
  tmap <C-o> <C-\><C-n>
end

"}}}
" Global niceties {{{
" ---------------

" Start an external command with a single bang
nnoremap ! :!

" Allow misspellings
cnoreabbrev qw wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd

" Start new line from any cursor position
inoremap <S-Return> <C-o>o

" Quick substitute within selected area
xnoremap s :s//g<Left><Left>

nnoremap zl z5l
nnoremap zh z5h

" Improve scroll, credits: https://gijhub.com/Shougo
nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
	\ 'zt' : (winline() == 1) ? 'zb' : 'zz'
noremap <expr> <C-f> max([winheight(0) - 2, 1])
	\ ."\<C-d>".(line('w$') >= line('$') ? "L" : "M")
noremap <expr> <C-b> max([winheight(0) - 2, 1])
	\ ."\<C-u>".(line('w0') <= 1 ? "H" : "M")
noremap <expr> <C-e> (line("w$") >= line('$') ? "j" : "3\<C-e>")
noremap <expr> <C-y> (line("w0") <= 1         ? "k" : "3\<C-y>")

" Window control
nnoremap <C-q> <C-w>
nnoremap <C-x> <C-w>x
nnoremap <silent><C-w>z :vert resize<CR>:resize<CR>:normal! ze<CR>

" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Use tab for indenting in visual mode
vnoremap <Tab> >gv|
vnoremap <S-Tab> <gv
nnoremap > >>_
nnoremap < <<_

" Select last paste
nnoremap <expr> gp '`['.strpart(getregtype(), 0, 1).'`]'

" Navigation in command line
cnoremap <C-j> <Left>
cnoremap <C-k> <Right>
cnoremap <C-h> <Home>
cnoremap <C-l> <End>
cnoremap <C-f> <Right>
cnoremap <C-b> <Left>
cnoremap <C-d> <C-w>

" Switch history search pairs, matching my bash shell
cnoremap <C-p>  <Up>
cnoremap <C-n>  <Down>
cnoremap <Up>   <C-p>
cnoremap <Down> <C-n>

" }}}
" File operations {{{
" ---------------

" When pressing <leader>cd switch to the directory of the open buffer
map <Leader>cd :lcd %:p:h<CR>:pwd<CR>

" Fast saving
nnoremap <silent><Leader>w :write<CR>
vnoremap <silent><Leader>w <Esc>:write<CR>
nnoremap <silent><C-s> :<C-u>write<CR>
vnoremap <silent><C-s> :<C-u>write<CR>
cnoremap <silent><C-s> :<C-u>write<CR>

" Save a file with sudo
" http://forrst.com/posts/Use_w_to_sudo_write_a_file_with_Vim-uAN
cmap W!! w !sudo tee % >/dev/null

" }}}
" Editor UI {{{
" ---------

" I like to :quit with 'q', shrug.
nnoremap <silent> q :<C-u>:quit<CR>

" adding saving session by using current working directory of the project
nnoremap <silent> <C-q> :execute 'SessionSave' fnamemodify(resolve(getcwd()), ':p:gs?/?_?')<CR>:wqa!<CR>

autocmd MyAutoCmd FileType man nnoremap <silent><buffer> q :<C-u>:quit<CR>

" Macros
nnoremap Q q
nnoremap gQ @q

" " exit insert, dd line, enter insert
" " inoremap <c-d> <esc>ddi
" noremap H ^
" noremap L g_

" getting out of insert mode fast!
imap jk <Esc>

" delete whole word in insert mode
inoremap <c-h> <c-w>

" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Wrapped lines goes down/up to next row, rather than next line in file.
" provide hjkl movements in Insert mode via the <Alt> modifier key
inoremap <A-j> <C-o>b
inoremap <A-h> <C-o><Left>
inoremap <A-l> <C-o><Right>
inoremap <A-k> <C-o>w

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>


" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Show highlight names under cursor
nmap <silent> gh :echo 'hi<'.synIDattr(synID(line('.'), col('.'), 1), 'name')
	\.'> trans<'.synIDattr(synID(line('.'), col('.'), 0), 'name').'> lo<'
	\.synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name').'>'<CR>

" Toggle editor visuals
nmap <silent> <Leader>tos :setlocal spell!<cr>
nmap <silent> <Leader>ton :setlocal nonumber!<CR>
nmap <silent> <Leader>tol :setlocal nolist!<CR>
nmap <silent> <Leader>toh :nohlsearch<CR>
nmap <silent> <Leader>tow :setlocal wrap! breakindent!<CR>

" Tabs
nnoremap <silent> g0 :<C-u>tabfirst<CR>
nnoremap <silent> g$ :<C-u>tablast<CR>
nnoremap <silent> gr :<C-u>tabprevious<CR>
nnoremap <silent> <S-l> :<C-U>tabnext<CR>
nnoremap <silent> <S-h> :<C-U>tabprevious<CR>
nnoremap <silent> <C-Tab> :<C-U>tabnext<CR>
nnoremap <silent> <C-S-Tab> :<C-U>tabprevious<CR>
" Uses g:lasttab set on TabLeave in MyAutoCmd
let g:lasttab = 1
nmap <silent> \\ :execute 'tabn '.g:lasttab<CR>

" Go to definition using cTags
" map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" nnoremap <C-|> :<C-U>vsp <CR>:exec("tag ".expand("<cword>"))<CR>
" nnoremap <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <silent> g\ :vsplit <CR>:exec("tag ".expand("<cword>"))<CR>
nnoremap <silent> g- :split <CR>:exec("tag ".expand("<cword>"))<CR>

" }}}
" Totally Custom {{{
" --------------

" Remove spaces at the end of lines
nnoremap <silent> ,<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>

" C-r: Easier search and replace
xnoremap <C-r> :<C-u>call <SID>get_selection('/')<CR>:%s/\V<C-R>=@/<CR>//gc<Left><Left><Left>

" Returns visually selected text
function! s:get_selection(cmdtype) "{{{
	let temp = @s
	normal! gv"sy
	let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
	let @s = temp
endfunction "}}}

" Background dark/light toggle and contrasts
nnoremap <silent><Leader>bg :<C-u>call <SID>toggle_background()<CR>
nmap <silent> b- :<c-u>call <SID>toggle_contrast(-v:count1)<cr>
nmap <silent> b= :<c-u>call <SID>toggle_contrast(+v:count1)<cr>

function! s:toggle_background()
	if ! exists('g:colors_name')
		echomsg 'No colorscheme set'
		return
	endif
	let l:scheme = g:colors_name

	if l:scheme =~# 'dark' || l:scheme =~# 'light'
		" Rotate between different theme backgrounds
		execute 'colorscheme' (l:scheme =~# 'dark'
					\ ? substitute(l:scheme, 'dark', 'light', '')
					\ : substitute(l:scheme, 'light', 'dark', ''))
	else
		execute 'set background='.(&background ==# 'dark' ? 'light' : 'dark')
		if ! exists('g:colors_name')
			execute 'colorscheme' l:scheme
			echomsg 'The colorscheme `'.l:scheme
				\ .'` doesn''t have background variants!'
		else
			echo 'Set colorscheme to '.&background.' mode'
		endif
	endif
endfunction

function! s:toggle_contrast(delta)
	let l:scheme = ''
	if g:colors_name =~# 'solarized8'
		let l:schemes = map(['_low', '_flat', '', '_high'],
			\ '"solarized8_".(&background).v:val')
		let l:contrast = ((a:delta + index(l:schemes, g:colors_name)) % 4 + 4) % 4
		let l:scheme = l:schemes[l:contrast]
	endif
	if l:scheme !=# ''
		execute 'colorscheme' l:scheme
	endif
endfunction

" Location list movement
nmap <Leader>j :lnext<CR>
nmap <Leader>k :lprev<CR>

" Duplicate lines
nnoremap <Leader>d m`YP``
vnoremap <Leader>d YPgv

" Source line and selection in vim
vnoremap <Leader>S y:execute @@<CR>:echo 'Sourced selection.'<CR>
nnoremap <Leader>S ^vg_y:execute @@<CR>:echo 'Sourced line.'<CR>

" Yank buffer's absolute path to X11 clipboard
nnoremap <Leader>y :let @+=expand("%")<CR>:echo 'Relative path copied to clipboard.'<CR>
nnoremap <Leader>Y :let @+=expand("%:p")<CR>:echo 'Absolute path copied to clipboard.'<CR>

" Drag current line/s vertically and auto-indent
vnoremap mk :m-2<CR>gv=gv
vnoremap mj :m'>+<CR>gv=gv
noremap  mk :m-2<CR>
noremap  mj :m+<CR>

" Last session management shortcuts
" nmap <Leader>se :<C-u>SessionSave last<CR>
nmap <silent> <Leader>se :<C-u>execute 'SessionSave' fnamemodify(resolve(getcwd()), ':p:gs?/?_?')<CR>
nmap <silent> <Leader>os :<C-u>execute 'source '.g:session_directory.'/'.fnamemodify(resolve(getcwd()), ':p:gs?/?_?').'.vim'<CR>


if has('mac')
	" Open the macOS dictionary on current word
	nmap <Leader>? :!open dict://<cword><CR><CR>

	" Use Marked for real-time Markdown preview
	if executable('/Applications/Marked 2.app/Contents/MacOS/Marked 2')
		autocmd MyAutoCmd FileType markdown
			\ nmap <buffer><Leader>P :silent !open -a Marked\ 2.app '%:p'<CR>
	endif

	" Use Dash on Mac, for context help
	if executable('/Applications/Dash.app/Contents/MacOS/Dash')
		autocmd MyAutoCmd FileType ansible,go,php,css,less,html,markdown
			\ nmap <silent><buffer> K :!open -g dash://"<C-R>=split(&ft, '\.')[0]<CR>:<cword>"&<CR><CR>
		autocmd MyAutoCmd FileType javascript,javascript.jsx,sql,ruby,conf,sh
			\ nmap <silent><buffer> K :!open -g dash://"<cword>"&<CR><CR>
	endif

" Use Zeal on Linux for context help
elseif executable('zeal')
	autocmd MyAutoCmd FileType ansible,go,php,css,less,html,markdown
		\ nmap <silent><buffer> K :!zeal --query "<C-R>=split(&ft, '\.')[0]<CR>:<cword>"&<CR><CR>
	autocmd MyAutoCmd FileType javascript,javascript.jsx,sql,ruby,conf,sh
		\ nmap <silent><buffer> K :!zeal --query "<cword>"&<CR><CR>
endif

" }}}
" Display diff from last save {{{
command! DiffOrig vert new | setlocal bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" }}}
" Append modeline to EOF {{{
nnoremap <silent> <Leader>ml :call <SID>append_modeline()<CR>

" Append modeline after last line in buffer
" See: http://vim.wikia.com/wiki/Modeline_magic
function! s:append_modeline() "{{{
	let l:modeline = printf(' vim: set ts=%d sw=%d tw=%d %set :',
				\ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
	let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
	call append(line('$'), l:modeline)
endfunction "}}}
" }}}
" s: Windows and buffers {{{

nnoremap <silent> [Window]g  :<C-u>split<CR>
nnoremap <silent> [Window]v  :<C-u>vsplit<CR>
nnoremap <silent> [Window]t  :tabnew<CR>
nnoremap <silent> [Window]o  :<C-u>only<CR>
nnoremap <silent> [Window]b  :b#<CR>
nnoremap <silent> [Window]c  :close<CR>
nnoremap <silent> [Window]x  :<C-u>call <SID>BufferEmpty()<CR>

" Split current buffer, go to previous window and previous buffer
nnoremap <silent> [Window]sg :split<CR>:wincmd p<CR>:e#<CR>
nnoremap <silent> [Window]sv :vsplit<CR>:wincmd p<CR>:e#<CR>
" nnoremap <silent> [Window]st :vsplit<CR>:wincmd p<CR>:e#<CR>


function! WipeHiddenBuffers()
	let tpbl=[]
	call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
	for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
		silent execute 'bwipeout' buf
	endfor
endfunction

function! s:BufferEmpty() " {{{
	let l:current = bufnr('%')
	if ! getbufvar(l:current, '&modified')
		enew
		silent! execute 'bdelete '.l:current
	endif
endfunction " }}}

function! s:SweepBuffers() " {{{
	let bufs = range(1, bufnr('$'))
	let hidden = filter(bufs, 'buflisted(v:val) && !bufloaded(v:val)')
	if ! empty(hidden)
		execute 'silent bdelete' join(hidden)
	endif
endfunction " }}}
" }}}
" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
