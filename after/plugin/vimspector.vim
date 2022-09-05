if !get(g:, 'loaded_vimpector', v:false)
  finish
end

let g:HUY = 4

let g:vimspector_enable_mappings = 'HUMAN'
let g:vimspector_base_dir=expand('$VIMPATH/local/vimspector-config' )

" Continue
" Stop
" Restart
" Pause
" ToggleBreakpoint
" ToggleConditionalBreakpoint
" AddFunctionBreakpoint
" StepOver
" StepInto
" StepOut
" RunToCursor
" nnoremap <silent> <leader>ds :call vimspector#Reset()<CR>
" nmap <leader>dd <Plug>VimspectorContinue
" nmap dc <Plug>VimspectorContinue

" " nmap d <Plug>VimspectorStop
" " nmap dS <Plug>VimspectorRestart
" nmap dP <Plug>VimspectorPause
" nmap db <Plug>VimspectorToggleBreakpoint
" nmap dB <Plug>VimspectorToggleConditionalBreakpoint
" nmap dbb <Plug>VimspectorAddFunctionBreakpoint
" nmap dn <Plug>VimspectorStepOver
" nmap ds <Plug>VimspectorStepInto
" nmap du <Plug>VimspectorStepOut
" " nmap d <Plug>VimspectorRunToCursor

" " nnoremap <silent> <F5> :call vimspector#Continue()<CR>
" nnoremap <silent> <leader>dd :call vimspector#Continue()<CR>
" nnoremap <silent> <leader>dn :call vimspector#StepOver()<CR>
" nnoremap <silent> <leader>ds :call vimspector#StepInto()<CR>
" nnoremap <silent> <leader>do :call vimspector#StepOut()<CR>
" nnoremap <silent> <leader>b :call vimspector#ToggleBreakpoint()<CR>
" nnoremap <silent> <leader>B :call vimspector#ToggleConditionalBreakpoint()<CR>
" nnoremap <silent> <leader>r :call vimspector#RunToCursor()<CR>
" nnoremap <silent> <leader>dS :call vimspector#Reset()<CR>

" nnoremap <silent> <leader>lp :call require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>
" nnoremap <silent> <leader>dr :call require'dap'.repl.open()<CR>
" nnoremap <silent> <leader>dl :call require'dap'.repl.run_last()<CR>`
"
if !has("python3")
  finish
end

" Set the basic sizes
let g:vimspector_sidebar_width = 50
let g:vimspector_code_minwidth = 90
let g:vimspector_terminal_minwidth = 75

function! s:CustomiseUI()
  " Customise the basic UI...

  " Close the output windowfunc! CustomiseUI()
  call win_gotoid( g:vimspector_session_windows.code )
  " Clear the existing WinBar created by Vimspector
  nunmenu WinBar
  " Cretae our own WinBar
  nnoremenu WinBar.Kill :call vimspector#Stop()<CR>
  nnoremenu WinBar.Continue :call vimspector#Continue()<CR>
  nnoremenu WinBar.Pause :call vimspector#Pause()<CR>
  nnoremenu WinBar.Step\ Over  :call vimspector#StepOver()<CR>
  nnoremenu WinBar.Step\ In :call vimspector#StepInto()<CR>
  nnoremenu WinBar.Step\ Out :call vimspector#StepOut()<CR>
  nnoremenu WinBar.Restart :call vimspector#Restart()<CR>
  nnoremenu WinBar.Exit :call vimspector#Reset()<CR>

endfunction

"" Credit for saving/restor mappings goes here https://vi.stackexchange.com/questions/7734/how-to-save-and-restore-a-mapping/7735#7735?newreg=fe2f242c9fe546e3999cecee085e3d69

fu! Save_mappings(keys, mode, global) abort
    let mappings = {}

    if a:global
        for l:key in a:keys
            let buf_local_map = maparg(l:key, a:mode, 0, 1)

            sil! exe a:mode.'unmap <buffer> '.l:key

            let map_info        = maparg(l:key, a:mode, 0, 1)
            let mappings[l:key] = !empty(map_info)
                                \     ? map_info
                                \     : {
                                        \ 'unmapped' : 1,
                                        \ 'buffer'   : 0,
                                        \ 'lhs'      : l:key,
                                        \ 'mode'     : a:mode,
                                        \ }

            call Restore_mappings({l:key : buf_local_map})
        endfor

    else
        for l:key in a:keys
            let map_info        = maparg(l:key, a:mode, 0, 1)
            let mappings[l:key] = !empty(map_info)
                                \     ? map_info
                                \     : {
                                        \ 'unmapped' : 1,
                                        \ 'buffer'   : 1,
                                        \ 'lhs'      : l:key,
                                        \ 'mode'     : a:mode,
                                        \ }
        endfor
    endif

    return mappings
endfu

fu! Restore_mappings(mappings) abort

    for mapping in values(a:mappings)
        if !has_key(mapping, 'unmapped') && !empty(mapping)
            exe     mapping.mode
               \ . (mapping.noremap ? 'noremap   ' : 'map ')
               \ . (mapping.buffer  ? ' <buffer> ' : '')
               \ . (mapping.expr    ? ' <expr>   ' : '')
               \ . (mapping.nowait  ? ' <nowait> ' : '')
               \ . (mapping.silent  ? ' <silent> ' : '')
               \ .  mapping.lhs
               \ . ' '
               \ . substitute(mapping.rhs, '<SID>', '<SNR>'.mapping.sid.'_', 'g')

        elseif has_key(mapping, 'unmapped')
            sil! exe mapping.mode.'unmap '
                                \ .(mapping.buffer ? ' <buffer> ' : '')
                                \ . mapping.lhs
        endif
    endfor

endfu


" nnoremap <silent> <leader>dd :call vimspector#Continue()<CR>

" nnoremap <expr> <Plug>BuildAndDebugVimSpector :call vimspector#Launch()<CR>
" nmap <leader>dd <Plug>BuildAndDebugVimSpector

" nnoremap <silent> <leader>b :call vimspector#ToggleBreakpoint()<CR>
let g:your_saved_mappings = Save_mappings(['<localleader>R', '<localleader>n', '<localleader>s', '<localleader>o', '<localleader>B', '<localleader>r', '<localleader>c', "<leader>dd"], 'n', 1)

function s:SetUpTerminal()
  " Customise the terminal window size/position
  " For some reasons terminal buffers in Neovim have line numbers
  " call win_gotoid( g:vimspector_session_windows.terminal )
  set norelativenumber nonumber
  " nnoremap <silent> <A-0> :<C-u>call VimspectorCloseAndRestore()<CR>
  nnoremap <silent> <A-0> :call vimspector#Reset()<CR>
  nnoremap <silent> <A-1> :call vimspector#ToggleConditionalBreakpoint()<CR>
  nnoremap <silent> <A-2> :call vimspector#Restart()<CR>
  nnoremap <silent> <A-5> :call vimspector#StepInto()<CR>
  nnoremap <silent> <A-6> :call vimspector#StepOver()<CR>
  nnoremap <silent> <A-7> :call vimspector#StepOut()<CR>
	nnoremap <silent> <A-8> :call vimspector#Continue()<CR>
	nnoremap <silent> <A-c> :call vimspector#RunToCursor()<CR>
endfunction

function VimspectorCloseAndRestore()
  call Restore_mappings(g:your_saved_mappings)
	call vimspector#Reset()
endfunction

" " nnoremap <silent> <A-0> :<C-u>call VimspectorCloseAndRestore()<CR>
" nmap <silent> <A-1> <Plug>VimspectorToggleBreakpoint
" nmap <silent> <A-2> <Plug>VimpectorRestart
" nmap <silent> <A-3> <Plug>VimspectorDownFrame
" nmap <silent> <A-4> <Plug>VimspectorUpFrame
" nmap <silent> <A-5> <Plug>VimspectorStepInto
" nmap <silent> <A-6> <Plug>VimspectorStepOver
" nmap <silent> <A-7> <Plug>VimspectorStepOut
" nmap <silent> <A-8> <Plug>VimspectorContinue
" " nmap <silent> <A-c> :call vimspector#RunToCursor()<CR>
" nmap <silent> <A-0> <Plug>VimspectorStop

" nnoremap <silent> <Esc>0 :<C-u>call VimspectorCloseAndRestore()<CR>
nnoremap <silent> <Esc>0 :call vimspector#Reset()<CR>
nnoremap <silent> <Esc>1 :call vimspector#ToggleBreakpoint()<CR>
nnoremap <silent> <Esc>2 :call vimspector#Restart()<CR>
nnoremap <silent> <Esc>3 :call vimspector#DownFrame()<CR>
nnoremap <silent> <Esc>4 :call vimspector#UpFrame()<CR>
nnoremap <silent> <Esc>5 :call vimspector#StepInto()<CR>
nnoremap <silent> <Esc>6 :call vimspector#StepOver()<CR>
nnoremap <silent> <Esc>7 :call vimspector#StepOut()<CR>
nnoremap <silent> <Esc>8 :call vimspector#Continue()<CR>
nnoremap <silent> <Esc>c :call vimspector#RunToCursor()<CR>

" augroup MyVimspectorUICustomistaion
"   autocmd!
"   " autocmd User VimspectorUICreated call s:CustomiseUI()
"   autocmd User VimspectorTerminalOpened call s:SetUpTerminal()
" augroup END
