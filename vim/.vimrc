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

    "Syntax highlighting plugins
    Bundle 'jelera/vim-javascript-syntax'
    Bundle 'manic/vim-php-indent'
    Bundle 'tpope/vim-rails'
    Bundle 'jeyb/vim-jst'    
    Bundle 'kchmck/vim-coffee-script'
    Bundle 'AndrewRadev/vim-eco'
    Bundle 'vim-scripts/applescript.vim'
    Bundle 'vim-ruby/vim-ruby'
    Bundle 'othree/html5.vim'
    Bundle 'tpope/vim-haml'
    Bundle 'hail2u/vim-css3-syntax'
    Bundle 'ekalinin/Dockerfile.vim'
    Bundle 'mustache/vim-mustache-handlebars'
    Bundle 'pangloss/vim-javascript'
    Bundle 'mxw/vim-jsx'

    "Colorschemes
    Bundle 'altercation/vim-colors-solarized'
    Bundle '29decibel/codeschool-vim-theme'
    Bundle 'Lokaltog/vim-distinguished'    
    Bundle 'tpope/vim-vividchalk'
    Bundle 'vim-scripts/Wombat'
    Bundle 'morhetz/gruvbox'
    Bundle 'tomasr/molokai'

    "Interface improvements
    Bundle 'Raimondi/delimitMate'
    Bundle 'lilydjwg/colorizer'
    Bundle "honza/vim-snippets"
    Bundle "garbas/vim-snipmate"
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'scrooloose/syntastic'
    Bundle 'Shougo/neocomplcache'
    Bundle 'tpope/vim-fugitive'    
    Bundle 'mileszs/ack.vim'
    Bundle 'godlygeek/tabular'
    Bundle 'tpope/vim-surround'
    Bundle 'Lokaltog/vim-easymotion'
    Bundle 'junegunn/fzf.vim'

    "Utilites
    Bundle "MarcWeber/vim-addon-mw-utils"
    Bundle "tomtom/tlib_vim"

    if iCanHazVundle == 0
        echo "Installing Bundles, please ignore key map error messages"
        echo ""
        :BundleInstall
    endif
" Setting up Vundle - the vim plugin bundler end

set wildignore+=trunk/wp-content/themes/eddiemachado-bones-responsive-33b0dc3/learning-tree
autocmd VimEnter * call OpenNerdtreeOnly()
function! OpenNerdtreeOnly()
    " if we aren't opening a file directly, open nerdtree and close the
    " default window
    if 0 == argc()
        NERDTree
        wincmd p
        wincmd c
    end
endfunction

" View options
set background=dark
colorscheme solarized
"colorscheme Mustang
"colorscheme railscasts
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

au FileType ruby setlocal shiftwidth=2 softtabstop=2 tabstop=2
au FileType eruby.html setlocal shiftwidth=2 softtabstop=2 tabstop=2
au FileType eco.html setlocal shiftwidth=2 softtabstop=2 tabstop=2
au FileType eruby setlocal shiftwidth=2 softtabstop=2 tabstop=2
au FileType eco setlocal shiftwidth=2 softtabstop=2 tabstop=2
au FileType javascript setlocal shiftwidth=2 softtabstop=2 tabstop=2
au FileType coffee setlocal shiftwidth=2 softtabstop=2 tabstop=2
au FileType scss setlocal shiftwidth=2 softtabstop=2 tabstop=2
au FileType yaml setlocal shiftwidth=2 softtabstop=2 tabstop=2

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
" Leader-z folds the entire file up to indent level of cursor
:nnoremap <silent> <leader>z :let&l:fdl=indent('.')/&sw<cr>

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
"let g:colorizer_auto_filetype='css,html,erb,scss'
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
" Leader-g searches for the word under the cursor in files in the working directory
nmap <Leader>g :vimgrep /<C-R><C-W>/gj **<CR>

set virtualedit=onemore         " allow for cursor beyond last character
set history=1000                " Store a ton of history (default is 20)
map <F5> :setlocal spell! spelllang=en_us<CR>
set hidden                      " allow buffer switching without saving

" Run php beautifier on Ctrl-B
au BufEnter,BufNew *.php map <C-b> :% ! php_beautifier --filters "PEAR() DocBlock()"<CR>
"autocmd BufWrite *.php % !php_beautifier --filters "phpBB() DocBlock()"

map <C-H> <ESC>:!phpm <C-R>=expand("<cword>")<CR><CR>

" neocomplache settings
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Use camel case completion.
let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
let g:neocomplcache_enable_underbar_completion = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Fix for vim-rails
" Ref: https://git.cloudhost.io/ka/dotfiles/commit/8eaf689586d91ac9d6f23babeb650a01694e4289
let g:neocomplcache_force_overwrite_completefunc=1

" Define dictionary.
"let g:neocomplcache_dictionary_filetype_lists = {
    "\ 'default' : '',
    "\ 'vimshell' : $HOME.'/.vimshell_hist',
    "\ 'scheme' : $HOME.'/.gosh_completions'
    "\ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
let g:neocomplcache_snippets_dir='~/.vim/bundle/snipmate-snippets/snippets'

"imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <expr><CR>  pumvisible() ? neocomplcache#smart_close_popup() : "\<CR>"
imap <expr> <CR> pumvisible() ? neocomplcache#smart_close_popup() : '<Plug>delimitMateCR'
" <TAB>: completion.
"inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<TAB>"
"inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

" Enable heavy omni completion.
if !exists('g:neocomplcache_omni_patterns')
  let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_omni_patterns.c = '\%(\.\|->\)\h\w*'
let g:neocomplcache_omni_patterns.cpp = '\h\w*\%(\.\|->\)\h\w*\|\h\w*::'

" Set .md files as markdown syntax
au BufRead,BufNewFile *.md set filetype=markdown

" Setup up color schemes to cycle through
nmap <Leader>1 :call SwitchColorSchemes()<CR>
function! SwitchColorSchemes()
  let scheme_number = input("Enter scheme number: ")
  if len(scheme_number) > 0 
    if scheme_number == 1
      exe "colo railscasts"
    elseif scheme_number == 2
      exe "colo solarized"
    elseif scheme_number == 3
      exe "colo Mustang"
    elseif scheme_number == 4
      exe "colo desert"
    elseif scheme_number == 5
      exe "colo candy"
    elseif scheme_number == 6
      exe "colo Wombat"
    elseif scheme_number == 7
      exe "colo gruvbox"
    elseif scheme_number == 8
      exe "colo molokai"
    elseif scheme_number == 9
      exe "colo codeschool"
    endif
  endif
  exe "ColorHighlight"
endfunction

nmap <Leader>2 :call SetColorSchemeToFileTypeDefault()<CR>
function! SetColorSchemeToFileTypeDefault()
  let the_filetype = &filetype
  if the_filetype == "scss"
    exe "colo candy"
  elseif the_filetype == "ruby"
    exe "colo railscasts"
  elseif the_filetype == "eruby"
    exe "colo railscasts"
  elseif the_filetype == "php"
    exe "colo solarized"
  else
    exe "colo solarized"
  endif
  exe "ColorHighlight"
endfunction

nmap <Leader>3 :ColorToggle<CR>
" Automatically set the colorscheme to the filetype default. Removed for now
" because there was noticeable delay when switching windows
"au   BufEnter * execute ":call SetColorSchemeToFileTypeDefault()"

" Highlight when lines become longer than 80 characters
"match ErrorMsg '\%>80v.\+'

au! BufNewFile,BufRead *.applescript setf applescript
autocmd BufNewFile,BufRead,BufFilePost *.hamljs set filetype=haml

" Execute 'cmd' while redirecting output.
" Delete all lines that do not match regex 'filter' (if not empty).
" Delete any blank lines.
" Delete '<whitespace><number>:<whitespace>' from start of each line.
" Display result in a scratch buffer.
function! s:Filter_lines(cmd, filter)
  let save_more = &more
  set nomore
  redir => lines
  silent execute a:cmd
  redir END
  let &more = save_more
  new
  setlocal buftype=nofile bufhidden=hide noswapfile
  put =lines
  g/^\s*$/d
  %s/^\s*\d\+:\s*//e
  if !empty(a:filter)
    execute 'v/' . a:filter . '/d'
  endif
  0
endfunction
command! -nargs=? Scriptnames call s:Filter_lines('scriptnames', <q-args>)

" Have delimitmate insert carriage returns
let delimitMate_expand_cr=1
let delimitMate_expand_space=1

" fzf mappings
nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>p :Buffers<CR>
