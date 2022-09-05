if !get(g:, 'loaded_ctrlp', v:false)
  finish
end

"""""""""""" CtrlP
let g:ctrlp_root_markers = ['$ROOT_MARKER', '.p4ignore']

" change defaults
let g:ctrlp_regexp = 0
let g:ctrlp_clear_cache_on_exit = 0
" let g:ctrlp_arg_map = 1 " allow for one extra argument when doing <c-o>
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll|lo|pyc)$',
  \ }

let g:ctrlp_extensions = ['buffertag', 'tag', 'line', 'dir']
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPLastMode'

" nnoremap <silent><leader><leader> :<C-u>CtrlP<CR>
nnoremap <silent><leader><leader> :<C-u>CtrlPMixed<CR>
nnoremap <silent><leader>fb :<C-u>CtrlPBuffer<CR>
" nnoremap <silent><leader>f :<C-u>CtrlPCurWD<CR>
nnoremap <silent><leader>ft :<C-u>CtrlPTag<cr>
nnoremap <silent><leader>ftb :<C-u>CtrlPBufTag<cr>
nnoremap <silent><leader>fq :<C-u>CtrlPQuickFix<cr>
nnoremap <silent><leader>ff :<C-u>CtrlPLine<cr>
nnoremap <silent>// :<C-u>CtrlPLine %<cr>
nnoremap <silent>\\ :<C-u>CtrlPLastMode<cr>
nnoremap <silent><leader>, :<C-u>CtrlPMRUFiles<cr>

let g:ctrlp_prompt_mappings = {
  \ 'PrtBS()':              ['<bs>', '<c-]>'],
  \ 'PrtDelete()':          ['<del>'],
  \ 'PrtDeleteWord()':      ['<c-w>'],
  \ 'PrtClear()':           ['<c-u>'],
  \ 'PrtSelectMove("j")':   ['<c-j>', '<down>'],
  \ 'PrtSelectMove("k")':   ['<c-k>', '<up>'],
  \ 'PrtSelectMove("t")':   ['<Home>', '<kHome>'],
  \ 'PrtSelectMove("b")':   ['<End>', '<kEnd>'],
  \ 'PrtSelectMove("u")':   ['<PageUp>', '<kPageUp>'],
  \ 'PrtSelectMove("d")':   ['<PageDown>', '<kPageDown>'],
  \ 'PrtHistory(-1)':       ['<c-n>'],
  \ 'PrtHistory(1)':        ['<c-p>'],
  \ 'AcceptSelection("e")': ['<cr>', '<2-LeftMouse>'],
  \ 'AcceptSelection("h")': ['<c-x>', '<c-cr>', '<c-s>'],
  \ 'AcceptSelection("t")': ['<c-t>'],
  \ 'AcceptSelection("v")': ['<c-v>', '<c-l>', '<RightMouse>'],
  \ 'ToggleFocus()':        ['<s-tab>'],
  \ 'ToggleRegex()':        ['<c-r>'],
  \ 'ToggleByFname()':      ['<c-d>'],
  \ 'ToggleType(1)':        ['<c-f>', '<c-up>'],
  \ 'ToggleType(-1)':       ['<c-b>', '<c-down>'],
  \ 'PrtExpandDir()':       ['<tab>'],
  \ 'PrtInsert("c")':       ['<MiddleMouse>', '<insert>'],
  \ 'PrtInsert()':          ['<c-\>'],
  \ 'PrtCurStart()':        [],
  \ 'PrtCurEnd()':          [],
  \ 'PrtCurLeft()':         ['<left>', '<c-^>'],
  \ 'PrtCurRight()':        ['<right>'],
  \ 'PrtClearCache()':      ['<F5>'],
  \ 'PrtDeleteEnt()':       ['<F7>'],
  \ 'CreateNewFile()':      ['<c-y>'],
  \ 'MarkToOpen()':         ['<c-space>'],
  \ 'OpenMulti()':          ['<c-o>'],
  \ 'PrtExit()':            ['<esc>', '<c-c>', '<c-g>'],
  \ }
