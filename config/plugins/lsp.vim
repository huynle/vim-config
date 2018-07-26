let g:LanguageClient_rootMarkers = ['.project']
" let g:LanguageClient_settingsPath = ".vscode/settings.json"
let g:LanguageClient_changeThrottle = 0.2
let g:LanguageClient_diagnosticsList = "Disabled"
let g:LanguageClient_selectionUI = "Quickfix"
let g:LanguageClient_serverCommands = {
  \ 'python': ['C:\Users\e367212\.cache\vim\venv3\neovim3\Scripts\pyls.exe'],
  \ 'cpp': ['/home/hle/.local/opt/cquery/build/release/bin/cquery',
  \ '--log-file=/tmp/cq.log',
  \ '--init={"cacheDirectory":"/home/hle/.cache/vim/cquery/"}'],
  \ }


nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> <F2> :<C-u>call LanguageClient#textDocument_rename()<CR>


nnoremap <silent> K :<C-u>call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gr :<C-u>call LanguageClient#textDocument_references()<CR>
nnoremap <silent> gd :<C-u>call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> gi :<C-u>call LanguageClient#textDocument_implementation()<CR>