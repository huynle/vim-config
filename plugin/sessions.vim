
" Session Management
" ---

"" Session management shortcuts
nmap <silent> <Leader>se :<C-u>SessionSaveCwd<CR>
nmap <silent> <Leader>os :<C-u>SessionLoadCwd<CR>
nnoremap <silent> <Leader>zz :<C-u>SessionSaveCwd<CR>:wqa!<CR>
" autocmd VimEnter * SessionLoadCwd

let g:session_directory = $VARPATH.'/session'

" Save and persist session
command! -nargs=? -complete=customlist,<SID>session_complete SessionSave
	\ call s:session_save(<q-args>)

" Load and persist session
command! -nargs=? -complete=customlist,<SID>session_complete SessionLoad
	\ call s:session_load(<q-args>)

" Save session on quit if one is loaded
augroup sessionsave
	autocmd!
	" If session is loaded, write session file on quit
	autocmd VimLeavePre *
		\ if ! empty(v:this_session) && ! exists('g:SessionLoad')
		\ |   execute 'mksession! '.fnameescape(v:this_session)
		\ | endif
augroup END

function! s:session_save(name) abort
	if ! isdirectory(g:session_directory)
		call mkdir(g:session_directory, 'p')
	endif
	let file_name = empty(a:name) ? badge#project() : a:name
	let file_path = g:session_directory.'/'.file_name.'.vim'
	execute 'mksession! '.fnameescape(file_path)
	let v:this_session = file_path

	echohl MoreMsg
	echo 'Session `'.file_name.'` is now persistent'
	echohl None
endfunction

function! s:session_load(name) abort
	let file_path = g:session_directory.'/'.a:name.'.vim'

	if ! empty(v:this_session) && ! exists('g:SessionLoad')
		\ |   execute 'mksession! '.fnameescape(v:this_session)
		\ | endif

	noautocmd silent! %bwipeout!
	execute 'silent! source '.file_path
endfunction

function! s:session_load_cwd()
	let file_path = g:session_directory.'/'.fnamemodify(resolve(getcwd()), ':p:gs?[\\/:-]?_?').'.vim'
	if filereadable(file_path)
		execute 'source '.file_path
	else
		echo 'Previous session not available to load.'
	endif
endfunction

function! s:session_save_cwd()
	execute 'SessionSave '.fnamemodify(resolve(getcwd()), ':p:gs?[\\/:-]?_?')
endfunction

function! s:session_complete(A, C, P)
	return map(
		\ split(glob(g:session_directory.'/*.vim'), '\n'),
		\ "fnamemodify(v:val, ':t:r')"
		\ )
endfunction

command! SessionLoadCwd call s:session_load_cwd()
command! SessionSaveCwd call s:session_save_cwd()

" vim: set ts=2 sw=2 tw=80 noet :
