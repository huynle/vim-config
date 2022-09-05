let g:mapleader="\<Space>"
let g:maplocalleader=';'

"---- vim-plug setup  ----
let vimplug_exists=expand('$HOME/.config/vim/autoload/plug.vim')
if has('win32')&&!has('win64')
  let curl_exists=expand('C:\Windows\Sysnative\curl.exe')
else
  let curl_exists=expand('curl')
endif

if !filereadable(vimplug_exists)
  if !executable(curl_exists)
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!"curl_exists" -fLo " . shellescape(vimplug_exists) . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif
"-------- end vim-plug setup ----



" Vim Initialization
" " ------------------
let $VIMPATH=expand('$HOME/.vim')
let $VIMLOCAL=expand('$HOME/.vim/local')
let $DATAPATH=expand('$HOME/.local/share/vim')

" Identify the machine first for custom configurations
" using vim regex expression - http://vimdoc.sourceforge.net/htmldoc/eval.html#expr4
if $HOST =~ "jedi*"
	let $MACHINE="jedi"
elseif $HOST =~ "etbc*"
	let $MACHINE="etbc"
else
	let $MACHINE=""
end

function! s:source_config(path)
  " execute printf("silent !echo sourcing %s", a:path)
	execute 'source ' . fnameescape($VIMPATH.'/hle/'.a:path)
endfunction

command! -nargs=1 SourceConfig call s:source_config(<args>)

" let g:python_host_prog = expand('$DATAPATH/venv/neovim/bin/python')
" let g:python3_host_prog = expand('$DATAPATH/venv/neovim/bin/python3')
" let g:python3_host_prog = expand('python3')

" Python interpreter settings
function! s:main()
	if has('vim_starting')
		if has('nvim')
			" Try using pyenv virtualenv called 'neovim'
			let l:virtualenv = ''

			if ! empty($PYENV_ROOT)
				let l:virtualenv = expand('$PYENV_ROOT/versions/neovim/bin/python')
			endif

			if empty(l:virtualenv) || ! filereadable(l:virtualenv)
				" Fallback to old virtualenv location
				let l:virtualenv = expand('$DATAPATH/venv/neovim/bin/python')
			endif

			if filereadable(l:virtualenv)
				let g:python3_host_prog = l:virtualenv
			endif

		elseif has('pythonx')
			if has('python3')
				set pyxversion=3
			elseif has('python')
				set pyxversion=2
			endif
		endif
	endif
endfunction

call s:main()

" Vim Directories {{{
" ---------------
if ! isdirectory(expand($DATAPATH))
	" Create missing dirs i.e. cache/{undo,backup}
	call mkdir(expand('$DATAPATH/undo'), 'p')
	call mkdir(expand('$DATAPATH/backup'), 'p')
	call mkdir(expand('$VIMPATH/spell'), 'p')
	call mkdir(expand('$DATAPATH/syntax'), 'p')
	call mkdir(expand('$DATAPATH/view'), 'p')
endif


""""
let $PROJECT=getcwd()
let $ROOT_MARKER ='.vim'
let $PROJECTCONFIG=$PROJECT.'/'.$ROOT_MARKER
let $PLUGGED=expand('$VIMPATH/plugged')


" Always source these
SourceConfig "globals.vim"
SourceConfig 'plugins.vim'
