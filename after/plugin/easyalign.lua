if not pcall(require, "vim-easy-align") then
  return
end

vim.cmd[[
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" Align GitHub-flavored Markdown tables
augroup aligning
  au!
  au FileType markdown vmap <localleader><Bslash> :EasyAlign*<bar><CR>
augroup end
]]
