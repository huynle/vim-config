" COLORSCHEME NAME

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif


" inspiration from here: https://arslan.io/2021/02/15/automatic-dark-mode-for-terminal-applications/
let g:themefile = $DATAPATH.'theme.txt'

" -- the stealth style
let g:material_lualine_style = 'stealth'

" default theme
let g:default_theme_1 = 'material'
let g:default_theme_2 = 'material'

" default background - 1
let g:default_bg_1 = 'dark'
let g:default_bg_2 = 'light'

" default theme - 1
let g:default_material_style_1 = "darker"
let g:default_material_style_2 = "lighter"

function! SetColors()
  if has ("nvim")
    execute printf("let g:material_style='%s'", (filereadable(g:themefile) ? readfile(g:themefile)[0] : g:default_material_style_1))
    execute printf("colorscheme %s", filereadable(g:themefile) ? readfile(g:themefile)[1] : g:default_theme_1)
    execute printf("set background=%s",(filereadable(g:themefile) ? readfile(g:themefile)[2] : g:default_bg_1))
    highlight LineNr guifg=#004a87
    highlight Visual guifg=LightBlue guibg=#004a87
    " highlight Pmenu  ctermbg=gray guibg=gray
    " highlight Normal guibg=NONE ctermbg=NONE
  else
    " execute printf("let g:material_theme_style='%s'", (filereadable(g:themefile) ? readfile(g:themefile)[0] : g:default_material_style_1))
    execute printf("colorscheme %s", filereadable(g:themefile) ? readfile(g:themefile)[1] : g:default_theme_1)
    " execute printf("set background=%s",(filereadable(g:themefile) ? readfile(g:themefile)[2] : g:default_bg_1))
    " highlight LineNr guifg=#004a87
    " highlight Visual guifg=LightBlue guibg=#004a87
    " highlight Pmenu  ctermbg=gray guibg=gray
    " highlight Pmenu ctermbg=gray
    highlight LineNr guifg=#004a87
    highlight Visual guifg=LightBlue guibg=#004a87
  endif
endfunction

function! ToggleBg()
  if &background ==? 'dark'
    call writefile([g:default_material_style_2, g:default_theme_2, g:default_bg_2], g:themefile)
    call SetColors()
  else
    call writefile([g:default_material_style_1, g:default_theme_1, g:default_bg_1], g:themefile)
    call SetColors()
  endif
endfunction

command! ToggleBackground call ToggleBg()

nnoremap <silent><Leader>tb :<C-u>call ToggleBg()<CR>:execute printf("!bash -c togglebg")<CR>


augroup theming
  autocmd!
  " autocmd VimEnter * if filereadable(g:themefile) | call SetColors() | else | call SetColors() | endif
  autocmd VimEnter * call SetColors()
augroup END

if has("nvim")
  autocmd theming Signal SIGUSR1 call SetColors()
endif
