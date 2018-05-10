" Guttentags Settings
" Look at using .gutctags

" Turn on for debugging purpose
let g:gutentags_define_advanced_commands = 1
let g:gutentags_trace = 0

" getting modules to work. default was just ctags
let g:gutentags_modules = ['ctags', 'cscope']

" taking out cache_dir in favor of getting tags and cscope to work together
" let g:gutentags_cache_dir = $VARPATH.'/tags'
let g:gutentags_resolve_symlinks = 1
let g:gutentags_generate_on_write = 1
let g:gutentags_generate_on_missing = 0
let g:gutentags_generate_on_new = 0

" Define custom project root marker
let g:gutentags_add_default_project_roots = 0
let g:gutentags_project_root = ['.config/project.vim']
let g:gutentags_exclude_project_root = [ '/usr/local', '/usr/include', '.config/notags']

let g:gutentags_file_list_command = {
    \ 'markers': {
	\ '.git': 'git ls-files',
	\ '.hg': 'hg files',
	\ },
    \ }

" Ignore these wild generating tags
let g:gutentags_ctags_exclude_wildignore = 0
let g:gutentags_ctags_exclude = [
  \ '*/wp-admin', '*/wp-content', '*/wp-includes',
  \ '*/application/vendor', '*/vendor/ckeditor', '*/media/vendor',
  \ '*/venv']


" settings project cscope
let g:gutentags_auto_add_cscope = 1
let g:gutentags_scopefile = '.config/cscope.big'

