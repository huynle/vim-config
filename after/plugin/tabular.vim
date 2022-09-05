if !exists('g:tabular_loaded')
  finish
endif

" AddTabularPattern! nvar /nvarchar(\w*)/l1r0
" AddTabularPattern! f_comma /^[^,]*\zs,/
" AddTabularPattern! f_colon /^[^:]*\zs:/
" AddTabularPattern! f_equal /^[^=]*\zs=/
" AddTabularPattern! f_quote /^[^"]*\zs"/l1r0

"" for plugin specific configurations 
if exists(":Tabularize")
  nmap <Leader>a= :Tabularize /=<CR>
  vmap <Leader>a= :Tabularize /=<CR>
  nmap <Leader>a: :Tabularize /:\zs<CR>
  vmap <Leader>a: :Tabularize /:\zs<CR>
  nmap <Leader>a/ :Tabularize /\/\/<CR>
  vmap <Leader>a/ :Tabularize /\/\/<CR>
endif



" """""""""""" Easy-align
" " Start interactive EasyAlign in visual mode (e.g. vipga)
" xmap ga <Plug>(EasyAlign)
" " " Start interactive EasyAlign for a motion/text object (e.g. gaip)
" nmap ga <Plug>(EasyAlign)
