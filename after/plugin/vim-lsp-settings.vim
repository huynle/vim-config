if v:false || has('nvim')
  finish
end

" let g:lsp_settings_global_settings_dir=expand('$VIMPATH/override/vim-lsp-settings' )

let g:lsp_settings_root_markers = ['.vim', '.git', '.git/']

if $MACHINE == "jedi" || $MACHINE == "etbc"
  let g:jedi_cmd = expand("~/.vscode/extensions/ms-python.python-2021.12.1559732655/pythonFiles/lib/jedilsp/bin/jedi-language-server")
  let g:clangd_cmd = expand("~/tools/llvm/bin/clangd")
  let g:lsp_settings = {
  \  'jedi-language-server': {
  \    'cmd': [g:jedi_cmd],
  \  },
  \  'clangd': {'cmd': [g:clangd_cmd]},
  \}
else
  " echo "Setup your own lsp!"
endif


