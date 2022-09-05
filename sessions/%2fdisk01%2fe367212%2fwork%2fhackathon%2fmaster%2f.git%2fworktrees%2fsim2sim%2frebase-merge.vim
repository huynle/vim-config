" ~/dot/config/vim/sessions/%2fdisk01%2fe367212%2fwork%2fhackathon%2fmaster%2f.git%2fworktrees%2fsim2sim%2frebase-merge.vim:
" Vim session script.
" Created by session.vim 2.13.1 on 15 August 2022 at 16:19:41.
" Open this file in Vim and run :source % to restore your session.

if exists('g:syntax_on') != 1 | syntax on | endif
if exists('g:did_load_filetypes') != 1 | filetype on | endif
if exists('g:did_load_ftplugin') != 1 | filetype plugin on | endif
if exists('g:did_indent_on') != 1 | filetype indent on | endif
if &background != 'dark'
	set background=dark
endif
if !exists('g:colors_name') || g:colors_name != 'material' | colorscheme material | endif
call setqflist([])
let SessionLoad = 1
if &cp | set nocp | endif
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd /disk01/e367212/work/hackathon/sim2sim
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +0 /disk01/e367212/work/hackathon/master/.git/worktrees/sim2sim/rebase-merge/git-rebase-todo
argglobal
silent! argdel *
$argadd /disk01/e367212/work/hackathon/master/.git/worktrees/sim2sim/rebase-merge/git-rebase-todo
edit /disk01/e367212/work/hackathon/master/.git/worktrees/sim2sim/rebase-merge/git-rebase-todo
set splitbelow splitright
wincmd t
set winminheight=1 winheight=1 winminwidth=1 winwidth=1
argglobal
let s:l = 1 - ((0 * winheight(0) + 51) / 102)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 05|
tabnext 1
if exists('s:wipebuf') && s:wipebuf != bufnr('%')
"   silent exe 'bwipe ' . s:wipebuf
endif
" unlet! s:wipebuf
set winheight=1 winwidth=30 shortmess=aoOTIcF
set winminheight=1 winminwidth=1
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save

" Support for special windows like quick-fix and plug-in windows.
" Everything down here is generated by vim-session (not supported
" by :mksession out of the box).

1wincmd w
tabnext 1
if exists('s:wipebuf')
  if empty(bufname(s:wipebuf))
if !getbufvar(s:wipebuf, '&modified')
  let s:wipebuflines = getbufline(s:wipebuf, 1, '$')
  if len(s:wipebuflines) <= 1 && empty(get(s:wipebuflines, 0, ''))
    silent execute 'bwipeout' s:wipebuf
  endif
endif
  endif
endif
doautoall SessionLoadPost
unlet SessionLoad
" vim: ft=vim ro nowrap smc=128
