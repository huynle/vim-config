let s:tag_ESP='None'

function! SetupEnvironment(LIB_PATH, ...)
	" echom a:name
	" echom $VIMPATH.'/tags/'
	" echom a:LIB_PATH
	" execute 'let l:TAG_PATH=$'.a:LIB_PATH
	" echom l:TAG_PATH
	" let l:TAG_PATH=substitute(a:LIB_PATH, ",\\=[^,]", "_", "")
	" echom l:TAG_PATH

	let l:FINAL_PATH=$VARPATH.'/tags/'.a:LIB_PATH.'.tags'
	execute "let l:PATH_EVAL=$".a:LIB_PATH
	echom "PATH EVAL TO: $".l:PATH_EVAL

	let l:tag_str="!ctags -a -f ".l:FINAL_PATH." `find ".l:PATH_EVAL." "
	" echom a:000
	let l:first = 1
	for l:i in a:000
		" echom l:i
		if l:first
			let l:tag_str=join([l:tag_str,'-name '.l:i], ' ')
			let l:first = 0
		else
			let l:tag_str=join([l:tag_str,'-o -name '.l:i], ' ')
		endif
	endfor
	let l:tag_str=join([l:tag_str, "`"], '')
	" echom l:tag_str
	execute l:tag_str
	execute "set tags+=".l:FINAL_PATH

	" echom a:0
	" echom a:1
	" echo a:000
  " let l:path = expand('%:p')
  " if l:path =~ '/home/user/projects/Project1'
  "   setlocal expandtab smarttab textwidth=0
  "   if &filetype == 'yaml'
  "     setlocal tabstop=2 shiftwidth=2
  "   else
  "     setlocal tabstop=4 shiftwidth=4
  "   endif
  " elseif l:path =~ '/home/user/projects'
  "   setlocal tabstop=4 shiftwidth=4 noexpandtab
  " endif
endfunction
" autocmd! BufReadPost,BufNewFile * call SetupEnvironment()

command! -nargs=+ SetEnv call SetupEnvironment(<f-args>)


" vim: set foldmethod=marker ts=2 sw=2 tw=80 noet :
