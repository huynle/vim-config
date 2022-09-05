if !get(g:, 'loaded_gtest', v:false)
  finish
endif

let g:gtest#gtest_command = "build/bin/run_gtests"
augroup GTest
  au!
  " autocmd FileType cpp nnoremap <silent> <leader>tt :GTestRun<CR>
  autocmd FileType cpp nnoremap <silent> <leader>tu :GTestRunUnderCursor<CR>
  autocmd FileType cpp nnoremap <silent> <c-0> :GTestRunUnderCursor<CR>
  " autocmd FileType cpp nnoremap <silent> <A-t> :GTestRunUnderCursor<CR>
  " autocmd FileType cpp nnoremap          <leader>tc :GTestCase<space>
  " autocmd FileType cpp nnoremap          <leader>tn :GTestName<space>
  " autocmd FileType cpp nnoremap <silent> <leader>te :GTestToggleEnabled<CR>
  " autocmd FileType cpp nnoremap <silent> ]T         :GTestNext<CR>
  " autocmd FileType cpp nnoremap <silent> [T         :GTestPrev<CR>
  " autocmd FileType cpp nnoremap <silent> <leader>tf :CtrlPGTest<CR>
  " autocmd FileType cpp nnoremap <silent> <leader>tj :GTestJump<CR>
  " autocmd FileType cpp nnoremap          <leader>ti :GTestNewTest<CR>i
augroup END

