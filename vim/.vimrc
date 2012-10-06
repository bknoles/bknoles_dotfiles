autocmd VimEnter * NERDTree
colorscheme Mustang
set guifont=Monaco:h12
set nu!

filetype on
filetype plugin on
filetype indent on
syntax on

"tabstuff
set tabstop=3
set shiftwidth=3
set softtabstop=3
set expandtab

"NERDTree
let NERDTreeChDirMode=2

"Turn 'crosshairs' on
set cursorcolumn
set cursorline

"setup code folding
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=1

" cycle through tabs with control-tab
nnoremap <C-S-tab> :tabprevious<CR>
nnoremap <C-tab>   :tabnext<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i
set scrolloff=999

" Wrap visual selection in an HTML tag.
vmap <Leader>w <Esc>:call VisualHTMLTagWrap()<CR>
function! VisualHTMLTagWrap()
  let tag = input("Tag to wrap block: ")
  if len(tag) > 0 
    normal `>
    if &selection == 'exclusive'
      exe "normal i</".tag.">"
    else
      exe "normal a</".tag.">"
    endif
    normal `<
    exe "normal i<".tag.">"
    normal `<
  endif
endfunction
