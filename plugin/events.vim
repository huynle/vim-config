augroup bufs
	autocmd!
	" Auto compiling
	" Check if file changed when its window is focus, more eager than 'autoread'
	autocmd BufWritePost,FileWritePost *.vim nested if &l:autoread > 0 | source <afile> | echo 'source ' . bufname('%') | endif
  " Auto compile when there are changes in plugins.lua
	" autocmd BufWritePost *.lua PackerCompile 

	autocmd BufWritePre /tmp/*" setlocal noundofile
	autocmd BufWritePre COMMIT_EDITMSG" setlocal noundofile
	autocmd BufWritePre MERGE_MSG" setlocal noundofile
	autocmd BufWritePre *.tmp" setlocal noundofile
	autocmd BufWritePre *.bak" setlocal noundofile
	autocmd BufWritePre *.tsx" lua vim.api.nvim_command('Format')
	autocmd BufWritePre *.go" lua require('internal.golines').golines_format()
	autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
augroup END

augroup jumps
  autocmd!
    autocmd InsertLeave * normal! m'
augroup END
  
augroup wins
  autocmd!
    autocmd WinEnter,BufEnter,InsertLeave * if ! &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal cursorline | endif
    autocmd WinLeave,BufLeave,InsertEnter * if &cursorline && &filetype !~# '^\(dashboard\|clap_\)' && ! &pvw | setlocal nocursorline | endif
    autocmd VimLeave * if has('nvim') | wshada! | else | wviminfo! | endif
    autocmd FocusGained *" checktime
augroup END


augroup ft
  autocmd!
    autocmd FileType dashboard" set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2
    autocmd BufNewFile,BufRead *.toml"  setf toml
    autocmd BufNewFile,BufRead .localrc"  setf sh
    autocmd BufRead,BufNewFile *.pp"  setf puppet
    autocmd BufRead,BufNewFile *.vim"  setf vim
    autocmd FileType markdown" setlocal spell
    " -- windows to close with "q"
    autocmd FileType help,startuptime,qf,lspinfo,man,Trouble,orgagenda,org,packer,lspsagafinder,Outline,vista,Neogit*,tsplayground,vimwiki*,GoogleKeep*,keep,Telescope*,vimcmake" nnoremap <buffer><silent> q :close!<CR>
    autocmd FileType help,startuptime,qf,lspinfo,man,Trouble,orgagenda,org,packer,lspsagafinder,Outline,vista,Neogit*,tsplayground,vimwiki*,GoogleKeep*,keep,Telescope*,vimcmake" nnoremap <buffer><silent> <C-c> :close!<CR>
    autocmd BufEnter todo-list*,__Scratch__,_cheat,info.*,projects.*,taskwiki.*,summary.*,caldendar.*,stats.*,burndown.*" nnoremap <buffer><silent> <C-c> :close<CR>
augroup END


augroup custom_ui
  autocmd!
    autocmd BufWinEnter,BufNew,BufNewFile,VimEnter * if ! mapcheck('q', 'n') | nnoremap <silent><buffer> q :<C-u>close<CR> | endif
augroup END

augroup nvimtree
	autocmd!
	autocmd BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname('%') == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif
augroup END


augroup MyAutoCmd

  " you can also write it like the other autocmd below
  autocmd BufRead,BufNewFile *.dr set filetype=python

  """"" TAGs: Covered by gutentags
  " autocmd BufWritePost *.cpp,*.h,*.c,*.py,*.vim call UpdateTags()
  " autocmd BufWritePost *.cpp,*.h,*.c,*.py call UpdateCscope()

	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	autocmd BufReadPost *
		\ if &ft !~# 'commit' && ! &diff &&
		\      line("'\"") >= 1 && line("'\"") <= line("$")
		\|   execute 'normal! g`"zvzz'
		\| endif

	" Update filetype on save if empty
	autocmd BufWritePost * nested
		\ if &l:filetype ==# '' || exists('b:ftdetect')
		\ |   unlet! b:ftdetect
		\ |   filetype detect
		\ | endif

	autocmd Syntax * if line('$') > 5000 | syntax sync minlines=200 | endif

  " Automatically set read-only for files being edited elsewhere
	autocmd SwapExists * nested let v:swapchoice = 'o'

	" Disable paste after leaving insert mode
	autocmd InsertLeave *
			\ if &paste | set nopaste mouse=a | echo 'nopaste' | endif |
			\ if &l:diff | diffupdate | endif

	" " Open Quickfix window automatically
	" autocmd QuickFixCmdPost [^l]* leftabove copen
	" 	\ | wincmd p | redraw!
	" autocmd QuickFixCmdPost l* leftabove lopen
	" 	\ | wincmd p | redraw!

	" Fix window position of help/quickfix
	autocmd FileType help if &l:buftype ==# 'help'
		\ | wincmd K | endif
	autocmd FileType qf   if &l:buftype ==# 'quickfix'
		\ | wincmd J | endif

	" Update diff
	autocmd InsertLeave * if &l:diff | diffupdate | endif

	" Open quickfix in split
	autocmd FileType qf nnoremap <buffer> sv :call <SID>OpenQuickfix("vsplit")<CR>
	autocmd FileType qf nnoremap <buffer> sg :call <SID>OpenQuickfix("split")<CR>

	" Clean up hidden fugitive buffers
	autocmd BufReadPost fugitive://* set bufhidden=delete


	autocmd BufReadPost .settings.vim* set syntax=vim

	" auto-save all markdown files
	" autocmd CursorHold *.md update

	" ESCAPE out of fugitive buffer?
	" autocmd User fugitive
	" 	\ if fugitive#buffer().type() =~# '^\%(tree\|blob\)$' |
	" 	\   nnoremap <buffer> .. :edit %:h<CR> |
	" 	\ endif

augroup END



" vim: set ts=2 sw=2 tw=80 noet :
