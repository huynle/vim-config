" MapFastKeycode: helper for fast keycode mappings
" makes use of unused vim keycodes <[S-]F15> to <[S-]F37>
function! <SID>MapFastKeycode(key, keycode)
  if s:fast_i == 46
    echohl WarningMsg
    echomsg "Unable to map ".a:key.": out of spare keycodes"
    echohl None
    return
  endif
  let vkeycode = '<'.(s:fast_i/23==0 ? '' : 'S-').'F'.(15+s:fast_i%23).'>'
  exec 'set '.vkeycode.'='.a:keycode
  exec 'map '.vkeycode.' '.a:key
  let s:fast_i += 1
endfunction
let s:fast_i = 0

" map raw chars to <C-CR>
" call <SID>MapFastKeycode('<C-CR>', "\e[13;5u")
call <SID>MapFastKeycode('<C-CR>', "^[[13;5u")
" map ^[[13;5u <C-CR>

inoremap <C-Space> <C-x><C-o>
inoremap <C-@> <C-Space>

" this char is output by the terminal with settings to send these chars
" map ^[[13;5u <C-CR>

" Start an external command with a single bang
nnoremap ! :!
" pipe command output to buffer
nnoremap !@ :read !

" Allow misspellings
cnoreabbrev qw wq
cnoreabbrev Wq wq
cnoreabbrev WQ wq
cnoreabbrev Qa qa
cnoreabbrev Bd bd
cnoreabbrev bD bd

" get out, get out! in a panic, just slam jk
imap jk <ESC>
imap kj <ESC>

"Switch to Other Buffer"
nnoremap <Space>` :e #<cr>

" Clear search with <esc>
map ", "<esc> :noh<cr>

" Opens line below or above the current line
" inoremap <S-CR> <C-O>o
" inoremap <C-CR> <C-O>O


" Quick substitute within selected area
xnoremap sg :s/\v/g<Left><Left>
xnoremap sc :s/\v/gc<Left><Left><Left>

" Improve scroll, credits: https://gijhub.com/Shougo
nnoremap <expr> zz (winline() == (winheight(0)+1) / 2) ?
  \ 'zt' : (winline() == 1) ? 'zb' : 'zz'
noremap <expr> <C-f> max([winheight(0) - 2, 1])
  \ ."\<C-d>".(line('w$') >= line('$') ? "L" : "M")
noremap <expr> <C-b> max([winheight(0) - 2, 1])
  \ ."\<C-u>".(line('w0') <= 1 ? "H" : "M")
noremap <expr> <C-e> (line("w$") >= line('$') ? "j" : "3\<C-e>")
noremap <expr> <C-y> (line("w0") <= 1         ? "k" : "3\<C-y>")


" Select blocks after indenting
xnoremap < <gv
xnoremap > >gv|

" Switch history search pairs, matching my bash shell
cnoremap <C-p>  <Up>
cnoremap <C-n>  <Down>
cnoremap <Up>   <C-p>
cnoremap <Down> <C-n>

" ---------------
" When pressing <leader>cd switch to the directory of the open buffer
map <Leader>cd :lcd %:p:h<CR>:pwd<CR>

" Save a file with sudo
" http://forrst.com/posts/Use_w_to_sudo_write_a_file_with_Vim-uAN
cmap W!! w !sudo tee % >/dev/null


" Quicker window movement
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" Toggle editor visuals
nmap <silent> <Leader>ts :setlocal spell!<cr>
nmap <silent> <Leader>tn :setlocal nonumber!<CR>
nmap <silent> <Leader>tl :setlocal nolist!<CR>
nmap <silent> <Leader>th :nohlsearch<CR>
nmap <silent> <Leader>tw :setlocal wrap! breakindent!<CR>

" Tabs
nnoremap <silent> <S-l> :<C-U>tabnext<CR>
nnoremap <silent> <S-h> :<C-U>tabprevious<CR>

" https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
nnoremap <expr> n  'Nn'[v:searchforward]
xnoremap <expr> n  'Nn'[v:searchforward]
onoremap <expr> n  'Nn'[v:searchforward]
nnoremap <expr> N  'nN'[v:searchforward]
xnoremap <expr> N  'nN'[v:searchforward]
onoremap <expr> N  'nN'[v:searchforward]

" Remove spaces at the end of lines
nnoremap <silent> ,<Space> :<C-u>silent! keeppatterns %substitute/\s\+$//e<CR>


" dont store {} movement in jumplist
nnoremap } :<C-u>execute "keepjumps norm! " . v:count1 . "}"<CR>
nnoremap { :<C-u>execute "keepjumps norm! " . v:count1 . "{"<CR>

" Binding to record j/k to the jumplist
nnoremap <expr> k (v:count >1 ? "m'" . v:count : '') . 'gk'
nnoremap <expr> j (v:count >1 ? "m'" . v:count : '') . 'gj'

" Remove whitespace
nnoremap ,<space> :%s/\s\+$//<CR>

" for selecting diffs
if &diff
    map <leader>1 :diffget LOCAL<CR>
    map <leader>2 :diffget BASE<CR>
    map <leader>3 :diffget REMOTE<CR>
endif

" allow folding and unfolding at the current level
nnoremap <silent> <S-z> @=(foldlevel('.')?'za':"\<Space>")<CR>
" nnoremap <silent> <CR> @=(foldlevel('.')?'za':"\<Space>")<CR>
" nnoremap <silent> <S-tab> zMzv
" Focus the current fold by closing all others
" nnoremap <S-z> zMzvzz




" Tabs
nnoremap <S-l> :<C-U>tabnext<CR>
nnoremap <S-h> :<C-U>tabprevious<CR>






" https://github.com/mhinz/vim-galore#saner-command-line-history
cnoremap <expr> <c-n> wildmenumode() ? "\<c-n>" : "\<down>"
cnoremap <expr> <c-p> wildmenumode() ? "\<c-p>" : "\<up>"

" allow to move when line is wrapped
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Fix keybind name for Ctrl+Spacebar
map <Nul> <C-Space>
map! <Nul> <C-Space>

" Change selected word in a repeatable manner
vnoremap <expr> cn "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgn"
vnoremap <expr> cN "y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgN"


" Window shortcuts
" use this for lightspeed
nnoremap <c-w>v :<C-u>vsplit<CR>:wincmd p<CR>:e#<CR>
nnoremap <c-w>s :<C-u>split<CR>:wincmd p<CR>:e#<CR>
nnoremap <c-w>t <C-w>T
nnoremap <c-w>, :-tabmove<cr>
nnoremap <c-w>. :+tabmove<cr>

" move window left right in a view
nnoremap <c-w><left> <C-w>r
nnoremap <c-w><right> <C-w>R

" Window control
" nnoremap <silent><C-w>z :vert resize<CR>:resize<CR>:normal! ze<CR>

" better indenting, hold on to highlight
vnoremap < <gv
vnoremap > >gv


" quit, record macrocs
nnoremap <silent> q :<C-u>:quit<CR>
nnoremap Q q

" Insert
" inoremap <C-e> pumvisible() ? "\<C-e>" : "\<End>"

" -- Yank from cursor position to end-of-line
" yank to end of line
nmap Y y$
nnoremap <localleader>Y    :let @"=expand("%:p")<CR>:OSCYankReg "<CR>
nnoremap <localleader>YY    :let @"=expand("%:p:h")<CR>:OSCYankReg "<CR>
vnoremap <localleader>y    :OSCYank<CR>
nnoremap <leader>yy    :let @*=expand("%:p")<CR>:OSCYankReg *<CR>

" Use backspace key for matching parens
nmap <BS> %
xmap <BS> %

" Put vim command output into buffer
nnoremap g! :<C-u>put=execute('')<Left><Left>


if has('nvim')
  " Move Lines - using Alt key... esc is used in binding. but its really ALT
  nnoremap <A-j> :m .+1<CR>==
  vnoremap <A-j> :m '>+1<CR>gv=gv
  inoremap <A-j> <Esc>:m .+1<CR>==gi
  nnoremap <A-k> :m .-2<CR>==
  vnoremap <A-k> :m '<-2<CR>gv=gv
  inoremap <A-k> <Esc>:m .-2<CR>==gi

  " exit out of insert mode in terminal
  tnoremap <Esc><Esc> <C-\><C-n>
  tnoremap <A-j><A-k>    <C-\><C-n>
  tnoremap <M-j><M-k>    <C-\><C-n>
  tnoremap <C-j><C-k>    <C-\><C-n>

  " Resize window using <ctrl> arrow keys
  " for some reason this, doesnt work with vim
  nnoremap <S-Up> :resize +4<CR>
  nnoremap <S-Down> :resize -4<CR>
  nnoremap <S-Left> :vertical resize -4<CR>
  nnoremap <S-Right> :vertical resize +4<CR>
else
  " Move Lines - using Alt key... esc is used in binding. but its really ALT
  " nnoremap <esc>o :FSHere<cr>
  
  " nnoremap <esc>j :m .+1<CR>==
  " vnoremap <esc>j :m '>+1<CR>gv=gv
  " inoremap <esc>j <Esc>:m .+1<CR>==gi
  " nnoremap <esc>k :m .-2<CR>==
  " vnoremap <esc>k :m '<-2<CR>gv=gv
  " inoremap <esc>k <Esc>:m .-2<CR>==gi

  " Disable arrow movement, resize splits instead.
  nnoremap <Down>    :resize +5<CR>
  nnoremap <Up>  :resize -5<CR>
  nnoremap <Right>  :vertical resize +5<CR>
  nnoremap <Left> :vertical resize -5<CR>
endif
