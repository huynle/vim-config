function! g:LoadPluginScript ()
    echo "got here to after VimEnter"
endfunction

augroup plugin_initialize
    autocmd!
    autocmd VimEnter * call LoadPluginScript()
    " foo bar
augroup
