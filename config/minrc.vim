
if &compatible
	set nocompatible
endif

" Set main configuration directory, and where cache is stored.
let $VIMPATH = fnamemodify(resolve(expand('<sfile>:p')), ':h:h')
let $VARPATH = expand(($XDG_CACHE_HOME ? $XDG_CACHE_HOME : '~/.cache').'/vim')
let $VIMRC = expand($VIMPATH.'/init.vim')

function! s:source_file(path, ...) abort
	let use_global = get(a:000, 0, ! has('vim_starting'))
	let abspath = resolve(expand($VIMPATH.'/config/'.a:path))
	if ! use_global
		execute 'source' fnameescape(abspath)
		return
	endif

	let content = map(readfile(abspath),
		\ "substitute(v:val, '^\\W*\\zsset\\ze\\W', 'setglobal', '')")
	let tempfile = tempname()
	try
		call writefile(content, tempfile)
		execute printf('source %s', fnameescape(tempfile))
	finally
		if filereadable(tempfile)
			call delete(tempfile)
		endif
	endtry
endfunction

" Set augroup
augroup MyAutoCmd
	autocmd!
	autocmd CursorHold *? syntax sync minlines=300
augroup END

" Initialize base requirements
if has('vim_starting')
	call s:source_file('init.vim')
	if has('nvim')
		" Neovim settings
		call s:source_file('neovim.vim')
	elseif ! has('gui_running') && ! has('win32') && ! has('win64')
		" Linux terminal settings
		call s:source_file('terminal.vim')
	endif
endif

" Loading configuration modules
call s:source_file('general.vim')
call s:source_file('filetype.vim')
call s:source_file('mappings.vim')
call s:source_file('theme.vim')

" Load user custom local settings
if filereadable(expand('$VIMPATH/config/local.vim'))
	call s:source_file('local.vim')
endif
set secure

" Netrw Explorer {{{
" ---------------------------------------------------------
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25
let g:netrw_list_hide='.*\.swp$'
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+,\(^\|\s\s\)ntuser\.\S\+'
let g:netrw_dirhistmax = 0

" UI elements {{{
" ---------------------------------------------------------
set showbreak=↪
set fillchars=vert:│,fold:─
set listchars=tab:\▏\ ,extends:⟫,precedes:⟪,nbsp:␣,trail:·

" vim: set ts=2 sw=2 tw=80 noet :
