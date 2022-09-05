if !get(g:, 'loaded_dispatch', v:false)
  finish
endif

" some CMake convenience functions
function! CMakeConfigure()
    Dispatch mkdir -p build
    Dispatch cmake --configure -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -S .
    Dispatch ln -s build/compile_commands.json ./compile_commands.json
endfunction
nnoremap <F7> :call CMakeConfigure()<CR>

function! CMakeClean()
    Dispatch cmake --build build --target clean
endfunction
nnoremap <F6> :call CMakeClean()<CR>

" nnoremap <F5> :Make<CR>
