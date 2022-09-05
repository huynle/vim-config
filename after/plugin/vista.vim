if !get(g:, 'loaded_vista', v:false)
  finish
endif

let g:vista#renderer#enable_icon = 1
let g:vista_disable_statusline = 1
let g:vista_highlight_whole_line = 1
let g:vista_default_executive = 'ctags'
let g:vista_echo_cursor_strategy = 'floating_win'
let g:vista_vimwiki_executive = 'markdown'

let g:vista_executive_for = {
  \ 'cpp': 'vim_lsp',
  \ 'python': 'vim_lsp',
  \ }
