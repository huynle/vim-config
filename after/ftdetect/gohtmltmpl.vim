" function DetectGoHtmlTmpl()
"     if expand('%:e') == "html" && search("{{") != 0
"         set filetype=gohtmltmpl 
"     endif
" endfunction

" augroup filetypedetect
"     au! BufRead,BufNewFile * call DetectGoHtmlTmpl()
" augroup END
