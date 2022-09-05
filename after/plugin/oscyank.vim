if !get(g:, 'loaded_oscyank', v:false)
	finish
endif 

autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankReg "' | endif
