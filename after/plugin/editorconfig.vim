if !get(g:, 'loaded_EditorConfig', v:false)
  finish
endif

let g:editorconfig_verbose = 1
let g:editorconfig_blacklist = {
  \ 'filetype': ['git.*', 'help', 'lsp-.*', 'any-jump', 'gina-.*'],
  \ 'pattern': ['\.un~$']
  \ }

