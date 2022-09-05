if v:true || !get(g:, 'loaded_localvimrc', v:false)
  finish
endif

""""""""""""" Localvimrc
let g:localvimrc_enable = 1
let g:localvimrc_ask = 0
let g:localvimrc_sandbox = 0
let g:localvimrc_reverse = 0
let g:localvimrc_event = [ "VimEnter", "BufRead", "BufWrite"]
let g:localvimrc_name = [".vimrc", "$PROJECTCONFIG/settings.vim", "$HOME/.settings.vim", "$VIMPATH/local/settings.vim"]
" let g:localvimrc_name = [$PROJECT."/.vimrc", $PROJECTCONFIG."/settings.vim", $HOME."/.settings.vim", $VIMPATH."/local/settings.vim"]
" let g:localvimrc_name = ["$VIMPATH/local/settings.vim", "$PROJECT/.vimrc",  "$PROJECTCONFIG/settings.vim",  "$HOME/.settings.vim"]
" let g:localvimrc_name = ["$PROJECT/.vimrc", "$PROJECTCONFIG/settings.vim", "$HOME/.settings.vim"]
