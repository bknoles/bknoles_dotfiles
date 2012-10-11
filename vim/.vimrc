set nocompatible
" Setting up Vundle - the vim plugin bundler
    let iCanHazVundle=1
    let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
    if !filereadable(vundle_readme)
        echo "Installing Vundle.."
        echo ""
        silent !mkdir -p ~/.vim/bundle
        silent !git clone https://github.com/gmarik/vundle ~/.vim/bundle/vundle
        let iCanHazVundle=0
    endif
    set rtp+=~/.vim/bundle/vundle/
    call vundle#rc()
    Bundle 'gmarik/vundle'
    "Add your bundles here
    "Bundle 'Syntastic' "uber awesome syntax and errors highlighter
    Bundle 'altercation/vim-colors-solarized'
    Bundle 'jelera/vim-javascript-syntax'
    Bundle 'Raimondi/delimitMate'
    "Bundle 'godlygeek/csapprox'
    Bundle 'vim-scripts/Better-CSS-Syntax-for-Vim' 
    Bundle 'chrisbra/color_highlight'
    Bundle "MarcWeber/vim-addon-mw-utils"
    Bundle "tomtom/tlib_vim"
    Bundle "honza/snipmate-snippets"
    Bundle "garbas/vim-snipmate"
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'scrooloose/syntastic'
    "Bundle 'spf13/PIV'
    Bundle 'Shougo/neocomplcache'
    Bundle 'tpope/vim-fugitive'
    Bundle 'manic/vim-php-indent'
    "...All your other bundles...
    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :BundleInstall
    endif
" Setting up Vundle - the vim plugin bundler end

autocmd VimEnter * NERDTree

" View options
set background=dark
" colorscheme solarized
" colorscheme Mustang
colorscheme railscasts
set guifont=Monaco:h12
set nu

filetype on
filetype plugin on
filetype indent on
filetype plugin indent on
syntax on

"tabstuff
set tabstop=4
set shiftwidth=4
set softtabstop=4
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

" Easier moving in tabs and windows
map <C-J> <C-W>j<C-W>_
map <C-K> <C-W>k<C-W>_
map <C-L> <C-W>l<C-W>_
map <C-H> <C-W>h<C-W>_

""" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

set scrolloff=999

" Adjust viewports to the same size
map <Leader>= <C-w>=

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

"Configuration options for chrisbra/color_highlight
let g:colorizer_auto_filetype='css,html'
"let g:colorizer_skip_comments = 1

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <leader>sv :so $MYVIMRC<CR>

set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set showmatch                   " show matching brackets/parenthesis

"Turn off search highlighting with leader-/
nmap <silent> <leader>/ :nohlsearch<CR>

set virtualedit=onemore         " allow for cursor beyond last character
set history=1000                " Store a ton of history (default is 20)
set spell                       " spell checking on
set hidden                      " allow buffer switching without saving

" Run php beautifier on Ctrl-B
au BufEnter,BufNew *.php map <C-b> :% ! php_beautifier --filters "PEAR() DocBlock()"<CR>
"autocmd BufWrite *.php % !php_beautifier --filters "phpBB() DocBlock()"

map <C-H> <ESC>:!phpm <C-R>=expand("<cword>")<CR><CR>

