augroup PluginEvents
  " clear group first, then everything else can be loaded
  autocmd!

augroup END

" if exists('g:loaded_oscyank')
"   autocmd PluginEvents TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif
" endif
