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
    Bundle 'godlygeek/csapprox'
    Bundle 'vim-scripts/Better-CSS-Syntax-for-Vim' 
    Bundle 'chrisbra/color_highlight'
    Bundle "MarcWeber/vim-addon-mw-utils"
    Bundle "tomtom/tlib_vim"
    Bundle "honza/snipmate-snippets"
    Bundle "garbas/vim-snipmate"
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'scrooloose/syntastic'
    "Bundle 'https://github.com/tpope/vim-fugitive' "So awesome, it should be illegal 
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

"Configuration options for chrisbra/color_highlight
let g:colorizer_auto_filetype='css,html'
"let g:colorizer_skip_comments = 1

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type

"Turn off search highlighting with leader-/
nmap <silent> ,/ :nohlsearch<CR>



