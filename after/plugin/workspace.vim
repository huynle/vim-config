function! g:LoadPluginScript ()
    echo "Project env setup complete."
endfunction

autocmd VimEnter * call LoadPluginScript()
let g:workspace_loaded = 1