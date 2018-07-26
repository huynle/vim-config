" Default settings for vim-tests
let g:test#strategy = {
  \ 'nearest': 'neomake',
  \ 'file': 'neomake',
  \ 'suit': 'neomake',
  \}

let g:test#python#runner = 'venv/bin/pytest'

" let g:test#python#pytest#options = {
"   \ 'nearest': '-s --pdb',
"   \}
