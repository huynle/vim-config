" if v:true
"   finish
" end


if executable("rg")
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
elseif executable("ag")
  set grepprg=ag\ --vimgrep\ $*
  set grepformat=%f:%l:%c:%m
endif

" if !get(g:, 'loaded_telescope', v:false) && !get(g:, 'loaded_fzf', v:false)
if !get(g:, 'loaded_telescope', v:false)

  " vnoremap <leader>fg y:execute " grep -srnw --binary-files=without-match --exclude-dir=.git --exclude-from=exclude.list . -e " . expand("<cword>") . " " <bar> cwindow<CR>

  " " bind K to grep word under cursor
  " nnoremap gr :grep <cword> *<CR>
  " nnoremap Gr :grep <cword> %:p:h/*<CR>
  " nnoremap gR :grep '\b<cword>\b' *<CR>
  " nnoremap GR :grep '\b<cword>\b' %:p:h/*<CR>

  " vnoremap <leader>fg :grep <SID>GetVisualSelection() %:p:h/*<CR>
  " vnoremap <leader>fg y:grep "<c-r>"" %<CR> 
  " vnoremap <leader>fg y:grep "<c-r>"" %:p:h/*<CR> 

  " "!" prevent jumping to quickfix list
  vnoremap <silent><leader>fg y:grep! "<c-r>""<CR> 
endif
