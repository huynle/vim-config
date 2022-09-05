if !get(g:, 'EasyMotion_loaded', v:false)
  finish
endif

" let g:EasyMotion_do_mapping=0
" " EasyMotion
" nmap ss <Plug>(easymotion-s2)
" nmap sd <Plug>(easymotion-s)
" nmap sf <Plug>(easymotion-overwin-f)
" map  sh <Plug>(easymotion-linebackward)
" map  sl <Plug>(easymotion-lineforward)
" " map  sj <Plug>(easymotion-j)
" " map  sk <Plug>(easymotion-k)
" map  s/ <Plug>(easymotion-sn)
" omap s/ <Plug>(easymotion-tn)
" map  sn <Plug>(easymotion-next)
" map  sp <Plug>(easymotion-prev)

let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

