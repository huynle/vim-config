" Write history on idle, for sharing among different sessions
" autocmd MyAutoCmd CursorHold * if exists(':rshada') | rshada | wshada | endif

" Search and use environments specifically made for Neovim.

if has('win16') || has('win32') || has('win64')
	if isdirectory(expand('$VARPATH/venv3/neovim3'))
		let g:python3_host_prog = expand('$VARPATH/venv3/neovim3/Scripts/python.exe')
		let g:python_host_prog = expand('$VARPATH/venv3/neovim3/Scripts/python.exe')
	endif

	" if isdirectory(expand('$VARPATH/venv3/neovim2'))
	" 	let g:python_host_prog = expand('$VARPATH/venv3/neovim2/Scripts/python.exe')
	" endif
else
	if isdirectory($VARPATH.'/venv/neovim3')
		let g:python3_host_prog = $VARPATH.'/venv/neovim3/bin/python'
	endif
	
	if isdirectory($VARPATH.'/venv/neovim2')
		let g:python_host_prog = $VARPATH.'/venv/neovim2/bin/python'
	endif
endif