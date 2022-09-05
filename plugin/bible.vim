"fu! bible#insert_quote(...) abort
"    let query = exists('a:1') && a:1 != "" ? a:1 : input("Query: ")
"    let translation = exists('a:2') ? a:2 : (exists('g:BibleTranslation') ? g:BibleTranslation: "NABRE")
"    " let translation = exists('a:2') && a:2 != "" ? a:2 : (exists('g:BibleTranslation') ? g:BibleTranslation : input("Bible translation: "))
"    " let format = exists('a:3') ? a:3 : (exists('g:BibleFormat') ? g:BibleFormat : "")
"    " let delimiter = exists('a:5') ? a:5 : (exists('g:BibleDelimiter') ? g:BibleDelimiter : "\\n")
"    " let omitModuleName = exists('a:6') ? a:6 : (exists('g:BibleOmitModuleName') ? g:BibleOmitModuleName : 1)

"    " let command = "bg2md -v " . translation . " ".query
"    let command = "bg2md -v NABRE -f -c '".query."'"

"    " if format != ''
"    "     let command .= " | sed -E \"s/^(.*) ([0-9]+):([0-9]+): (.*)$/" . format . "/g\""
"    " endif
"    " if omitModuleName == 1
"    "     let command .= " | sed -E \"s/^\\(.*\\)$//\""
"    " endif
"    " if delimiter != ''
"    "     let command .= " | tr '\\n' '" . delimiter . "'"
"    " endif

"    echom command
"    let text = system(command)
"    if text !~ "^Diatheke" && text !~ "^[\s\n\r]*$"
"        let text = substitute(text, '<[^>]*>', '', 'g')
"        put = text
"    else
"        echo "Invalid query!"
"    endif
"endfunction

"nnoremap <leader>b :call bible#insert_quote()<CR>
""Use selection as query
"vnoremap <leader>b y :call bible#insert_quote(@")<CR>
