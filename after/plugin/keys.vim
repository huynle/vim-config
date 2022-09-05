"""""""""""" Commentary
xmap <Leader>v  <Plug>Commentary
nmap <Leader>v  <Plug>CommentaryLine
xmap gc  <Plug>Commentary
nmap gc  <Plug>Commentary
omap gc  <Plug>Commentary
nmap gcc <Plug>CommentaryLine
nmap cgc <Plug>ChangeCommentary
nmap gcu <Plug>Commentary


"""""""""""" accelerated motion
" nmap <silent> j <Plug>(accelerated_jk_gj)
" nmap <silent> k <Plug>(accelerated_jk_gk)

" """""" ultisnips
" let g:UltiSnipsExpandTrigger = '<C-l>'
" let g:UltiSnipsListSnippets = ''
" let g:UltiSnipsJumpForwardTrigger = '<C-f>'
" let g:UltiSnipsJumpBackwardTrigger = '<C-b>'


" """""" Quickhl
" nmap <LocalLeader>, <Plug>(quickhl-manual-this)
" xmap <LocalLeader>, <Plug>(quickhl-manual-this)

" """""" Junegun/vim-peekaboo
" nnoremap <buffer> <silent> " :<c-u>call peekaboo#peek(v:count1, 'quote',  0)<cr>
" xnoremap <buffer> <silent> " :<c-u>call peekaboo#peek(v:count1, 'quote',  1)<cr>
" nnoremap <buffer> <silent> @ :<c-u>call peekaboo#peek(v:count1, 'replay', 0)<cr>
" inoremap <buffer> <silent> <c-r> <c-o>:call peekaboo#peek(1, 'ctrl-r',  0)<cr>


" Vim-Plug
if !has('nvim')
nnoremap <buffer> <silent> <leader>pi :<c-u>PlugInstall<cr>
nnoremap <buffer> <silent> <leader>pp :<c-u>PlugUpdate<cr>
nnoremap <buffer> <silent> <leader>ps :<c-u>PlugStatus<cr>
endif
