" echomsg "got here to after"


python << EOF
import os
import sys
import vim

#for p in sys.path:
    # Add each directory in sys.path, if it exists.
#    if os.path.isdir(p):
        # Command 'set' needs backslash before each space.
#        vim.command(r"set path+=%s" % (p.replace(" ", r"\ ")))
project_path = vim.eval('getcwd()')

if project_path not in sys.path:
    sys.path.insert(0, project_path)
EOF
