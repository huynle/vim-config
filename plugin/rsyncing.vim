"""""""""""""""""""" Running rsync on save"
let g:auto_rsync_trace = 0
let g:auto_rsync_prog = 'rsync --archive --compress --update'
let g:auto_rsync_dryrun = 0
let g:auto_rsync = []
" let g:auto_rsync = [
"       \ { 
"         \ "enable": 0,
"         \ "local_dir": $PROJECT,
"         \ "remote_dir": "vm:/tmp",
"         \ "exclude_files": ["$VIMLOCAL/rsync_exclude"],
"         \ "exclude_git": 1,
"         \ "exclude_gitignore": 1,
"         \ "addl_args"": [],
"         \ },
"         \ ]

function! s:make_include_exclude_file(file, sub_str="exclude", local_dir = $PROJECT)
  let rsync_base = ""
  let expanded_path = expand(a:file)
  let local_expanded_path = expand(a:local_dir."/".a:file)
  if filereadable(local_expanded_path)
    let rsync_base .= " --".a:sub_str."=".local_expanded_path
  elseif filereadable(expanded_path)
    let rsync_base .= " --".a:sub_str."=".expanded_path
  endif
  return rsync_base
endfunction

function! s:create_include_exclude_file(sync, sub_str="exclude")
  let rsync_base = ""

  " make sure key exists first
  if !has_key(a:sync, a:sub_str."_files")
    return ""
  endif

  if type(a:sync[a:sub_str."_files"]) == v:t_list
    for val in a:sync[a:sub_str."_files"]
      let rsync_base .= s:make_include_exclude_file(val, a:sub_str."-from")
    endfor
  else
      let rsync_base .= s:make_include_exclude_file(a:sync[a:sub_str."_files"], a:sub_str."-from")
  endif

  return rsync_base
endfunction

function! s:create_include_exclude(sync, sub_str="exclude")
  let rsync_base = ""

  " make sure key exists first
  if !has_key(a:sync, a:sub_str)
    return ""
  endif

  if type(a:sync[a:sub_str]) == v:t_list
    for val in a:sync[a:sub_str]
      let rsync_base .= " --".a:sub_str."=\"".val."\""
    endfor
  else
      let rsync_base .= " --".a:sub_str."=\"".val."\""
  endif

  return rsync_base
endfunction


function! s:create_full_rsync_cmd(sync, rsync_cmd_post)
  if a:sync.enable == 0 && g:auto_rsync_trace
    echom "Rsync for ".a:sync.remote_dir." is not enabled"
    return
  endif

  " archive -- equals -rlptgoD
  " r -- recursive
  " l -- copy symlink as symlinks
  " p -- preserve permissions
  " t -- preserve time
  " g -- preserve group
  " o -- preserve owner
  " D --
  " existing -- create new file on receiver
  " update -- skip files that are newer on receiver
  " let rsync_base = "rsync --archive --compress --update"
  let rsync_base = g:auto_rsync_prog
  " let rsync_base = "rsync --recursive --links --perms --group --owner --times --compress --existing --update"

  if has_key(a:sync, "exclude_git") && a:sync.exclude_git == 1
    let rsync_base .= " --exclude .git/"
  endif 

  if has_key(a:sync, "exclude_gitignore") && a:sync.exclude_gitignore == 1 && filereadable(a:sync.local_dir."/.gitignore")
    let rsync_base .= " --exclude-from=".a:sync.local_dir."/.gitignore"
  endif 

  " NOTE: include needs to happen before exclude
  let rsync_base .= s:create_include_exclude_file(a:sync, "include")
  let rsync_base .= s:create_include_exclude(a:sync, "include")

  let rsync_base .= s:create_include_exclude_file(a:sync, "exclude")
  let rsync_base .= s:create_include_exclude(a:sync, "exclude")

  if has_key(a:sync, "addl_args")
    let rsync_base .= " ".join(a:sync.addl_args, " ")
  endif

  if g:auto_rsync_dryrun
    let rsync_base .= " --dry-run"
  endif

  let total_rsync_cmd = rsync_base ." ". a:rsync_cmd_post

  if g:auto_rsync_trace
    execute "!" . total_rsync_cmd
  else
    silent execute "!" . total_rsync_cmd . " &"
  endif

endfunction

" rsync
function! AutoRsync(read_or_write)
	if exists("g:auto_rsync") && len(g:auto_rsync) > 0
    if g:auto_rsync_trace
		  echom "found g:auto_rsync"
    endif

    for sync in g:auto_rsync
      " create main rsync command string
      let rsync_cmd_post = s:auto_rsync_cmd(sync, a:read_or_write)
      call s:create_full_rsync_cmd(sync, rsync_cmd_post)
    endfor

  elseif exists("b:auto_rsync") && len(b:auto_rsync) > 0
    if g:auto_rsync_trace
		  echom "found b:auto_rsync"
    endif

    for sync in b:auto_rsync
      " create main rsync command string
      let rsync_cmd_post = s:auto_rsync_cmd(sync, a:read_or_write)
      call s:create_full_rsync_cmd(sync, rsync_cmd_post)
    endfor

  else
    return
	endif

	" " u for Update
	" " t for copying time also
	" " r for recursive
  " " TODO: to update this to automatically strip off the trailing slashes
  " for sync in g:auto_rsync
    " " create main rsync command string
    " let rsync_cmd_post = s:auto_rsync_cmd(sync, a:read_or_write)
    " call s:create_full_rsync_cmd(sync, rsync_cmd_post)
  " endfor


endfunction

function! s:format_rsync_server(rsync_server)
  if a:rsync_server == ""
    let rsync_server_ = ""
  else
    let rsync_server_ = a:rsync_server.":"
  endif
  return rsync_server_
endfunction


" rsyncing for single file
function! AutoRsyncFile(rsync_server)
	" if len(g:auto_rsync) > 0
    " echom "Dir AutoRsync is enabled, skipping single file write"
	" 	return
	" endif

  " add bashslashes to the path
  let l:relative_home_path = fnameescape(fnamemodify(expand("%"), ":~"))

  " TODO: this runs in the background, but the shell error is incorrect. when it is not running in background, the shell
  if executable('rsync')
    let total_rsync_cmd = printf('rsync -art %s %s"%s" &', l:relative_home_path, s:format_rsync_server(a:rsync_server), l:relative_home_path)
  else
    " fall back to scp
    let total_rsync_cmd = printf('scp -pr %s %s"%s" &', l:relative_home_path, s:format_rsync_server(a:rsync_server), l:relative_home_path)
  endif

  if g:auto_rsync_trace
    echom total_rsync_cmd
	  execute '!' . total_rsync_cmd
  else
	  " execute '!' . total_rsync_cmd
	  silent execute '!' . total_rsync_cmd
  endif

endfunction

function! s:auto_rsync_cmd(sync, sync_type)
  if a:sync_type == "write-project"
    let rsync_cmd_post = expand(a:sync.local_dir)."/ ".a:sync.remote_dir

  elseif a:sync_type == "write-project-delete"
    let rsync_cmd_post = expand(a:sync.local_dir)."/ ".a:sync.remote_dir." --delete"

  elseif a:sync_type == "read-project"
    let rsync_cmd_post = a:sync.remote_dir."/ ".expand(a:sync.local_dir)

  elseif a:sync_type == "read-project-delete"
    let rsync_cmd_post = a:sync.remote_dir."/ ".expand(a:sync.local_dir)." --delete"
  end
  return rsync_cmd_post
endfunction


" function! s:is_master(sync)
"   if isdirectory(a:sync.local_dir."/.git")
"     return 1
"   elseif filereadable(a:sync.local_dir."/.git") || filereadable(a:sync.local_dir.$ROOT_MARKER./rsync_master")
"     return 1
"   endif
"   if a:sync.enable && g:auto_rsync_trace
"     echom "Rsyncing is enabled, but cannot detect 'rsync_master' or '.git'"
"   endif
"   return 0
" endfunction

command! RWriteProject call AutoRsync("write-project") 
command! RWriteProjectDelete call AutoRsync("write-project-delete") 

command! RReadProject call AutoRsync("read-project") 
command! RReadProjectDelete call AutoRsync("read-project-delete") 

" $HOME/docs/** are synced by autocommand in $VIMLOCAL/settings.vim
" Automatically try to run rsync, it will check if g:auto_rsync has been set
augroup auto_rsync
    au!
    autocmd BufWritePost * call AutoRsync("write-project")
augroup end

