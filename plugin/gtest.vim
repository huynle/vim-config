function! s:GetTestFilterFromLine()
  " let l:lines = getreg("-")
  echomsg "GOT HERE"
  " echomsg "heyyy ".l:lines
  " let l:ms = matchlist(a:line, '^\(TEST\S*\)\s*(\s*\(\S\{-1,}\),\s*\(\S\{-1,}\)\s*).*$')

  " if l:ms[1] == 'TEST_P'
  "     return '*/' . l:ms[2] . '.' . l:ms[3] . '/*'
  " else
  "     return l:ms[2] . '.' . l:ms[3]
  " endif
endfunction


" select everything in a function and save it to register
command! GetTestName normal vip"-y call s:GetTestFilterFromLine()
