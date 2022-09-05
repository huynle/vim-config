if v:false || has('nvim')
  finish
end

" vim-lsp settings :)
" ---






" vim-lsp
" ---
let g:lsp_auto_enable = 1
let g:lsp_log_file = expand('$DATAPATH/vim-lsp.log', 1)

" if ! g:lsp_auto_enable
"   call lsp#enable()
" endif

" let g:lsp_auto_enable = argc() > 0
let g:lsp_ignorecase = 1
let g:lsp_signs_enabled = 1
let g:lsp_async_completion = 1
let g:lsp_fold_enabled = 0
let g:lsp_text_edit_enabled = 1
let g:lsp_peek_alignment = 'top'
let g:lsp_virtual_text_enabled = 0
let g:lsp_diagnostics_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_echo_delay = 400
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_highlights_delay = 400
let g:lsp_diagnostics_signs_error = {'text': '✖'}
let g:lsp_diagnostics_signs_warning = {'text': '⬪'}
let g:lsp_diagnostics_signs_hint = {'text': '▪'}
let g:lsp_diagnostics_signs_information = {'text': '▫'}



" Apply settings for languages that registered LSP
function! s:on_lsp_buffer_enabled() abort
	if empty(globpath(&rtp, 'autoload/lsp.vim'))
		finish
	endif
	setlocal omnifunc=lsp#complete

	if exists('+tagfunc')
		setlocal tagfunc=lsp#tagfunc
	endif

	" Folds are really slow
	" setlocal foldmethod=expr
	"	\ foldexpr=lsp#ui#vim#folding#foldexpr()
	"	\ foldtext=lsp#ui#vim#folding#foldtext()

	" Prefer native help with vim files
	if &filetype != 'vim'
		nmap <silent><buffer> K  <Plug>(lsp-hover)
	endif

	nmap <silent><buffer> gr     <Plug>(lsp-references)
	nmap <silent><buffer> gi     <Plug>(lsp-peek-implementation)
	nmap <silent><buffer> gy     <Plug>(lsp-peek-type-definition)
	nmap <silent><buffer> <C-]>  <Plug>(lsp-definition)
	nmap <silent><buffer> g<C-]> <Plug>(lsp-peek-definition)
	nmap <silent><buffer> gd     <Plug>(lsp-peek-declaration)
	nmap <silent><buffer> gY     <Plug>(lsp-type-hierarchy)
	nmap <silent><buffer> gA     <Plug>(lsp-code-action)
	nmap <silent><buffer> ,s     <Plug>lsp-signature-help)
	nmap <silent><buffer> [d     <Plug>(lsp-previous-diagnostic)
	nmap <silent><buffer> ]d     <Plug>(lsp-next-diagnostic)
	nmap <buffer> <Leader>rn     <Plug>(lsp-rename)
	nmap <buffer> <Leader>F      <plug>(lsp-document-format)
	vmap <buffer> <Leader>F      <plug>(lsp-document-range-format)
endfunction




augroup lsp_user_plugin
	autocmd!

	autocmd User lsp_buffer_enabled call <SID>on_lsp_buffer_enabled()

	" autocmd CompleteDone * if pumvisible() == 0 | pclose | endif

	" autocmd VimResized * call <SID>fix_preview_max_width()

	" autocmd FileType markdown.lsp-hover
	"	\ nnoremap <buffer> K <Nop>
	"	\| nnoremap <silent><buffer>q :pclose<CR>

augroup END


""" Manual setup to servers -- use settings  https://github.com/mattn/vim-lsp-settings/tree/master/settings as base
" if executable('jedi-language-server')
"     au User lsp_setup call lsp#register_server({
"         \ 'name': 'jedi-language-server',
"         \ 'cmd': {server_info->['jedi-language-server']},
"         \ 'allowlist': ['python'],
"         \ })
" endif

" if executable('clangd')
"   au User lsp_setup call lsp#register_server({
"         \ 'name': 'clangd',
"         \ 'priority': 4,
"         \ 'cmd': {server_info->['clangd', '-background-index']},
"         \ 'allowlist': ['c', 'cpp', 'objc', 'objcpp'],
"         \ })
" endif

