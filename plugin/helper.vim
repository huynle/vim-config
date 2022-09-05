" Returns the directory of the first file in `argv` or `cwd` if it's empty
function FindSessionDirectory() abort
  if len(argv()) > 0
    return fnamemodify(argv()[0], ':p:h')
  endif
  return getcwd()
endfunction!

let g:session_default_name = FindSessionDirectory()



" store this in ~/.vim/plugin/Newscratch.vim
function! Newscratch(file)
    execute '85vnew '.a:file
    setlocal buftype=nofile
    setlocal bufhidden=hide
    setlocal noswapfile
endfunction

command! -nargs=1 ScratchFile call Newscratch(<f-args>)

