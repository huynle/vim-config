
" Copying and Pasting on ChromeOS
if !empty(glob("$HOME/.crouton-clipboard/data.txt"))
	nnoremap "*p :r !cat $HOME/.crouton-clipboard/data.txt<CR>
	vnoremap "*y :'<,'>w! $HOME/.crouton-clipboard/data.txt<CR>
endif
