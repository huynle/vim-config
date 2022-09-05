""""" Rsync
let g:auto_rsync = [
      \ { 
        \ "enable": 1,
        \ "local_dir": $PROJECT,
        \ "remote_dir": "pipe:~/.vim",
        \ "exclude_files": ["$VIMLOCAL/rsync_exclude"],
        \ "exclude_git": 1,
        \ "exclude_gitignore": 1,
        \ },
        \ ]
