
""""""" getting vimdiff to work.. it needs bash for to do the diff
" why cant it use diff in the VIMRUMTIME folder?

if has('win32')
    let $SHELL="bash"
endif
    
if ! empty($NVIM) && has('win32')
" if has('win32')
    " Makes bash open in the working directory
    let $CHERE_INVOKING=1

    " Default path for Cygwin 64-bit, change accordingly
    set shell=C:\cygwin64\bin\bash.exe
    " let $SHELL=expand('C:\cygwin64\bin\bash.exe')


    " Without --login, Cygwin won't mount some directories such as /usr/bin/
    " set shellcmdflag=--login\ -c

    " Default value is (, but bash needs "
    set shellxquote=\"

    " Paths will use / instead of \
    set shellslash
endif


""""""""""" find files and populate the quickfix list
fun! FindFiles(filename, regFlag)
	let error_file = tempname()
	if a:regFlag
		silent exe '!find . -iregex "'.a:filename.'" | xargs file | sed "s/:/:1:/" > '.error_file
	else
		silent exe '!find . -iname "'.a:filename.'" | xargs file | sed "s/:/:1:/" > '.error_file
	endif

	set errorformat=%f:%l:%m
	exe "cfile ". error_file
	copen
	call delete(error_file)
endfun

command! -nargs=1 FindFile call FindFiles(<q-args>, 0)
command! -nargs=1 FindFileR call FindFiles(<q-args>, 1)


""""""""""""""" thoughtbot settings
" bind K to grep word under cursor
" nnoremap <Leader>g :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind \ (backward slash) to grep shortcut
" command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
" nnoremap \ :Ag<SPACE>


""""""""""""""""""" Change font size
if has('nvim')
	nnoremap <C-Up> :execute 'GuiFont! '.substitute( GuiFont, ':h\zs\d\+', '\=eval(submatch(0)+1)', '' )<CR>
	nnoremap <C-Down> :execute 'GuiFont! '.substitute( GuiFont, ':h\zs\d\+', '\=eval(submatch(0)-1)', '' )<CR>
else
	nnoremap <C-Up> :silent! let &guifont = substitute(
		\ &guifont,
		\ ':h\zs\d\+',
		\ '\=eval(submatch(0)+1)',
		\ '')<CR>
	nnoremap <C-Down> :silent! let &guifont = substitute(
		\ &guifont,
		\ ':h\zs\d\+',
		\ '\=eval(submatch(0)-1)',
		\ '')<CR>
endif

" still not working to change neovim font size
function! ChangeFontSize(size)
	let font_size_string = substitute(GuiFont, ':h\zs\d\+', '\=eval(submatch(0)+1)', "")
	execute('GuiFont '.font_size_string)
endfunction


""""""""""""""" buffer selecting with tab complete

function! BufSel(pattern)
	let bufcount = bufnr("$")
	let currbufnr = 1
	let nummatches = 0
	let firstmatchingbufnr = 0
	while currbufnr <= bufcount
		if(bufexists(currbufnr))
			let currbufname = bufname(currbufnr)
			if(match(currbufname, a:pattern) > -1)
				echo currbufnr . ": ". bufname(currbufnrm
				let nummatches += 1
				let firstmatchingbufnr = currbufnr
			endif
		endif
		let currbufnr = currbufnr + 1
	endwhile
	if(nummatches == 1)
		execute ":buffer ". firstmatchingbufnr
	elseif(nummatches > 1)
		let desiredbufnr = input("Enter buffer number: ")
		if(strlen(desiredbufnr) != 0)
			execute ":buffer ". desiredbufnr
		endif
	else
		echo "No matching buffers"
	endif
endfunction


"Bind the BufSel() function to a user-command
command! -nargs=1 Bs :call BufSel("<args>")

" " allowing tab to be used in the commandline to compelte buffers and filenames
" set wildchar=<Tab> wildmenu wildmode=full

""""" neovim?

" " Write history on idle, for sharing among different sessions
" autocmd MyAutoCmd CursorHold * if exists(':rshada') | rshada | wshada | endif

" Search and use environments specifically made for Neovim.

" if isdirectory($VARPATH.'/venv/neovim3')
" 	let g:python3_host_prog = $VARPATH.'/venv3/neovim3/Scripts/python.exe'
" endif

command! Bigger  :let &GuiFont = substitute(&GuiFont, '\d\+$', '\=submatch(0)+1', '')
command! Smaller :let &GuiFont = substitute(&GuiFont, '\d\+$', '\=submatch(0)-1', '')


" vim: set ts=2 sw=2 tw=80 noet :
