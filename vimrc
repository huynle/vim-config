" Note: Skip initialization for vim-tiny or vim-small.
if 0
	execute 'source' fnamemodify(expand('<sfile>'), ':h').'/.vim/config/fullrc.vim'
elseif 1
	execute 'source' fnamemodify(expand('<sfile>'), ':h').'/.vim/config/minrc.vim'
endif
