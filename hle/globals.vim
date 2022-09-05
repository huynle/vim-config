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

