" Unmap the colorizer plugin shortcut
silent! unmap <leader>tc

" Override all the various <CR> plugins to make sure that the play nice
" together + expand <CR> for html like tags
function! EnterOrIndentTag()
  let line = getline(".")
  let col = getpos(".")[2]
  let before = line[col-2]
  let after = line[col-1]

  if before == ">" && after == "<"
    return "\<CR>\<C-o>O"
  elseif delimitMate#WithinEmptyPair()
    return "\<C-R>=delimitMate#ExpandReturn()\<CR>"
  else
    return "\<CR>\<Plug>DiscretionaryEnd"
  endif
endfunction

imap <expr> <Enter> EnterOrIndentTag()

