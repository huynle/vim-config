" function! ToggleQuickFix()
"     if empty(filter(getwininfo(), 'v:val.quickfix'))
"         copen
"     else
"         cclose
"     endif
" endfunction

" nnoremap <silent> <leader>q :call ToggleQuickFix()<cr>

" function! GetBufferList()
"   redir =>buflist
"   silent! ls!
"   redir END
"   return buflist
" endfunction

" function! ToggleList(bufname, pfx)
"   let buflist = GetBufferList()
"   for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
"     if bufwinnr(bufnum) != -1
"       exec(a:pfx.'close')
"       return
"     endif
"   endfor
"   if a:pfx == 'l' && len(getloclist(0)) == 0
"       echohl ErrorMsg
"       echo "Location List is Empty."
"       return
"   endif
"   let winnr = winnr()
"   exec(a:pfx.'open')
"   if winnr() != winnr
"     wincmd p
"   endif
" endfunction

" nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
" nmap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>





"=================== general useful stuff

" }}}
" Search & Replace {{{
" ----------------

" TODO: clean up here
" " Repeat latest f, t, F or T
" nnoremap \ ;


" Returns visually selected text
function! s:get_selection() abort "{{{
	try
		let a_save = @a
		silent! normal! gv"ay
		return substitute(escape(@a, '\/'), '\n', '\\n', 'g')
	finally
		let @a = a_save
	endtry
endfunction "}}}

" }}}
" Command & History {{{
" -----------------

function ClearQuickfixList()
  call setqflist([])
endfunction

command! ClearQuickfixList call ClearQuickfixList()
nmap <leader>qc :ClearQuickfixList<cr>



" function! HeaderToggle()
"     let filename = expand("%:t")
"     if filename =~ ".cpp"
"         execute "e %:r.h"
"     else
"         execute "e %:r.cpp"
"     endif
" endfunction



" nnoremap <M-o> :call HeaderToggle()<cr>




function! s:window_empty_buffer()
	let l:current = bufnr('%')
	if ! getbufvar(l:current, '&modified')
		enew
		silent! execute 'bdelete '.l:current
	endif
endfunction


function! WipeHiddenBuffers()
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction

function! s:BufferEmpty()
  let l:current = bufnr('%')
  if ! getbufvar(l:current, '&modified')
    enew
    silent! execute 'bdelete '.l:current
  endif
endfunction

function! s:SweepBuffers()
  let bufs = range(1, bufnr('$'))
  let hidden = filter(bufs, 'buflisted(v:val) && !bufloaded(v:val)')
  if ! empty(hidden)
    execute 'silent bdelete' join(hidden)
  endif
endfunction

" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status =
    \ system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec 'edit ' . filenames[0]
  for filename in filenames[1:]
    exec 'sp ' . filename
  endfor
endfunction

function! ToggleConcealLevel()
    if &conceallevel
        setlocal conceallevel=0
    else
        setlocal conceallevel=2
    endif
endfunction

" insert timestamp"
" nmap <F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
" imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>
" or use ':r! date "+\%Y-\%m-\%d \%H:\%M:\%S"'
" or `:r! date`

" TODO: trying this out to log daily task
" function! Mylog(message, file)
"   new
"   setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
"   put=a:message
"   execute 'w >>' a:file
"   q
" endfun
" command! j call Mylog()
"
" Commands
"---------------------------------------------------------

" augroup MyAutoCmd
"   " clear group first, then everything else can be loaded
"   autocmd!
  
"   " you can also write it like the other autocmd below
"   autocmd BufRead,BufNewFile *.dr set filetype=python

"   """"" TAGs: Covered by gutentags
"   " autocmd BufWritePost *.cpp,*.h,*.c,*.py,*.vim call UpdateTags()
"   " autocmd BufWritePost *.cpp,*.h,*.c,*.py call UpdateCscope()
" augroup END


" Diff command credits: https://github.com/Shougo/shougo-s-github
" Display diff with the file.
command! -nargs=1 -complete=file Diff vertical diffsplit <args>
" Display diff from last save.
command! DiffOrig vert new | setlocal bt=nofile | r # | 0d_ | diffthis | wincmd p | diffthis
" Disable diff mode.
command! -nargs=0 Undiff setlocal nodiff noscrollbind wrap

" Functions
"---------------------------------------------------------

" Makes * and # work on visual mode too.
" See: http://github.com/nelstrom/vim-visual-star-search
function! VSetSearch(cmdtype) "{{{
  let temp = @s
  normal! gv"sy
  let @/ = substitute(escape(@s, '\'.a:cmdtype), '\n', '\\n', 'g')
  let @s = temp
endfunction "}}}

function! GetVisualSelection()
    " Why is this not a built-in Vim script function?!
    let [line_start, column_start] = getpos("'<")[1:2]
    let [line_end, column_end] = getpos("'>")[1:2]
    let lines = getline(line_start, line_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][: column_end - (&selection == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][column_start - 1:]
    return join(lines, "\n")
endfunction

" ===============================
" Append modeline after last line in buffer
" See: http://vim.wikia.com/wiki/Modeline_magic
function! s:append_modeline() "{{{
  let l:modeline = printf(' vim: set ts=%d sw=%d tw=%d %set :',
    \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
  let l:modeline = substitute(&commentstring, '%s', l:modeline, '')
  call append(line('$'), l:modeline)
endfunction

" Append modeline to EOF  -  "vim: set ts=4 sw=4 tw=0...
nnoremap <silent> <Leader>ml :call <SID>append_modeline()<CR>

" ===============================
" Toggle Verbose for vim debugging
nnoremap <silent><Leader>ddd :<C-u>call <SID>toggle_verbose()<CR>

let g:verbose_level = 9
function! s:toggle_verbose()
  if !&verbose
    execute "set verbosefile=".$DATAPATH.'/vim.log'
    execute "set verbose=".g:verbose_level
    echomsg "======== DEBUGGING STARTED ============"
    echomsg "Verbose set to ".g:verbose_level
  else
    echomsg "======== DEBUGGING STOPPED ============"
    set verbose=0
    set verbosefile=
  endif

endfunction

" function! ToggleQuickFix()
"     if empty(filter(getwininfo(), 'v:val.quickfix'))
"         copen
"     else
"         cclose
"     endif
" endfunction

" nnoremap <silent> <leader>q :call ToggleQuickFix()<cr>

" function! GetBufferList()
"   redir =>buflist
"   silent! ls!
"   redir END
"   return buflist
" endfunction

" function! ToggleList(bufname, pfx)
"   let buflist = GetBufferList()
"   for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
"     if bufwinnr(bufnum) != -1
"       exec(a:pfx.'close')
"       return
"     endif
"   endfor
"   if a:pfx == 'l' && len(getloclist(0)) == 0
"       echohl ErrorMsg
"       echo "Location List is Empty."
"       return
"   endif
"   let winnr = winnr()
"   exec(a:pfx.'open')
"   if winnr() != winnr
"     wincmd p
"   endif
" endfunction

" nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
" nmap <silent> <leader>q :call ToggleList("Quickfix List", 'c')<CR>





"=================== general useful stuff

" }}}
" Search & Replace {{{
" ----------------

" TODO: clean up here
" " Repeat latest f, t, F or T
" nnoremap \ ;


" Returns visually selected text
function! s:get_selection() abort "{{{
	try
		let a_save = @a
		silent! normal! gv"ay
		return substitute(escape(@a, '\/'), '\n', '\\n', 'g')
	finally
		let @a = a_save
	endtry
endfunction "}}}

" }}}
" Command & History {{{


function! s:window_empty_buffer()
	let l:current = bufnr('%')
	if ! getbufvar(l:current, '&modified')
		enew
		silent! execute 'bdelete '.l:current
	endif
endfunction


function! WipeHiddenBuffers()
  let tpbl=[]
  call map(range(1, tabpagenr('$')), 'extend(tpbl, tabpagebuflist(v:val))')
  for buf in filter(range(1, bufnr('$')), 'bufexists(v:val) && index(tpbl, v:val)==-1')
    silent execute 'bwipeout' buf
  endfor
endfunction

function! s:BufferEmpty()
  let l:current = bufnr('%')
  if ! getbufvar(l:current, '&modified')
    enew
    silent! execute 'bdelete '.l:current
  endif
endfunction

function! s:SweepBuffers()
  let bufs = range(1, bufnr('$'))
  let hidden = filter(bufs, 'buflisted(v:val) && !bufloaded(v:val)')
  if ! empty(hidden)
    execute 'silent bdelete' join(hidden)
  endif
endfunction


function! Expand(expr) abort
  return exists('*DotenvExpand') ? DotenvExpand(a:expr) : expand(a:expr)
endfunction

function! GetEnv(var) abort
  return exists('*DotenvGet') ? DotenvGet(a:var) : eval('$'.a:var)
endfunction

" OpenChangedFiles COMMAND
" Open a split for each dirty file in git
function! OpenChangedFiles()
  only " Close all windows, unless they're modified
  let status =
    \ system('git status -s | grep "^ \?\(M\|A\|UU\)" | sed "s/^.\{3\}//"')
  let filenames = split(status, "\n")
  exec 'edit ' . filenames[0]
  for filename in filenames[1:]
    exec 'sp ' . filename
  endfor
endfunction

function! ToggleConcealLevel()
    if &conceallevel
        setlocal conceallevel=0
    else
        setlocal conceallevel=2
    endif
endfunction

" insert timestamp"
" nmap <F3> i<C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR><Esc>
" imap <F3> <C-R>=strftime("%Y-%m-%d %a %I:%M %p")<CR>
" or use ':r! date "+\%Y-\%m-\%d \%H:\%M:\%S"'
" or `:r! date`

" TODO: trying this out to log daily task
" function! Mylog(message, file)
"   new
"   setlocal buftype=nofile bufhidden=hide noswapfile nobuflisted
"   put=a:message
"   execute 'w >>' a:file
"   q
" endfun
" command! j call Mylog()
"
