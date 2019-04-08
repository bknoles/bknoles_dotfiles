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
    Bundle 'tpope/vim-rails'
    Bundle 'vim-scripts/applescript.vim'
    Bundle 'vim-ruby/vim-ruby'
    Bundle 'othree/html5.vim'
    Bundle 'tpope/vim-haml'
    Bundle 'hail2u/vim-css3-syntax'
    Bundle 'ekalinin/Dockerfile.vim'
    Bundle 'mustache/vim-mustache-handlebars'
    Bundle 'pangloss/vim-javascript'
    Bundle 'maxmellon/vim-jsx-pretty'
    Bundle 'stephpy/vim-yaml'
    Bundle 'sheerun/vim-polyglot'


    "Colorschemes
    Bundle 'altercation/vim-colors-solarized'
    Bundle '29decibel/codeschool-vim-theme'
    Bundle 'Lokaltog/vim-distinguished'
    Bundle 'tpope/vim-vividchalk'
    Bundle 'vim-scripts/Wombat'
    Bundle 'morhetz/gruvbox'
    Bundle 'tomasr/molokai'
    Bundle 'trevordmiller/nova-vim'
    Bundle 'mhartington/oceanic-next'
    Bundle 'carakan/new-railscasts-theme'
    Bundle 'kaicataldo/material.vim'
    Bundle 'haishanh/night-owl.vim'


    "Interface improvements
    Bundle 'lilydjwg/colorizer'
    Bundle "honza/vim-snippets"
    Bundle "garbas/vim-snipmate"
    Bundle 'scrooloose/nerdcommenter'
    Bundle 'tpope/vim-fugitive'
    Bundle 'mileszs/ack.vim'
    Bundle 'godlygeek/tabular'
    Bundle 'tpope/vim-surround'
    "Bundle 'Lokaltog/vim-easymotion'
    Bundle 'junegunn/fzf.vim'
    Bundle 'airblade/vim-gitgutter'
    Bundle 'w0rp/ale'
    Bundle 'vim-airline/vim-airline'
    Bundle 'raimondi/delimitmate'
    Bundle 'alvan/vim-closetag'
    Bundle 'tpope/vim-endwise'
    "Bundle 'valloric/youcompleteme'
    Bundle 'valloric/listtoggle'
    Bundle 'scrooloose/nerdtree'

    if has('nvim')
      Bundle 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    else
      Bundle 'Shougo/deoplete.nvim'
      Bundle 'roxma/nvim-yarp'
      Bundle 'roxma/vim-hug-neovim-rpc'
    endif

    "Utilites
    Bundle "MarcWeber/vim-addon-mw-utils"
    Bundle "tomtom/tlib_vim"
    Bundle 'skywind3000/asyncrun.vim'

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

" Begin hacky workaround for vim's issues with switching colorschemes
" See https://github.com/altercation/solarized/issues/102#issuecomment-275269574
if !exists('s:known_links')
  let s:known_links = {}
endif

function! s:Find_links() " {{{1
  " Find and remember links between highlighting groups.
  redir => listing
  try
    silent highlight
  finally
    redir END
  endtry
  for line in split(listing, "\n")
    let tokens = split(line)
    " We're looking for lines like "String xxx links to Constant" in the
    " output of the :highlight command.
    if len(tokens) == 5 && tokens[1] == 'xxx' && tokens[2] == 'links' && tokens[3] == 'to'
      let fromgroup = tokens[0]
      let togroup = tokens[4]
      let s:known_links[fromgroup] = togroup
    endif
  endfor
endfunction

function! s:Restore_links() " {{{1
  " Restore broken links between highlighting groups.
  redir => listing
  try
    silent highlight
  finally
    redir END
  endtry
  let num_restored = 0
  for line in split(listing, "\n")
    let tokens = split(line)
    " We're looking for lines like "String xxx cleared" in the
    " output of the :highlight command.
    if len(tokens) == 3 && tokens[1] == 'xxx' && tokens[2] == 'cleared'
      let fromgroup = tokens[0]
      let togroup = get(s:known_links, fromgroup, '')
      if !empty(togroup)
        execute 'hi link' fromgroup togroup
        let num_restored += 1
      endif
    endif
  endfor
endfunction

function! s:AccurateColorscheme(colo_name)
  call <SID>Find_links()
  exec "colorscheme " a:colo_name
  call <SID>Restore_links()
endfunction

command! -nargs=1 -complete=color MyColorscheme call <SID>AccurateColorscheme(<q-args>)
" End hacky workaround for vims color schemes


" View options
set background=dark
if (has("termguicolors"))
  set termguicolors
endif

"MyColorscheme solarized
"MyColorscheme nova
"MyColorscheme Mustang
"MyColorscheme railscasts
MyColorscheme OceanicNext
"set guifont=Iosevka:h14,Monaco:h13
set macligatures
set guifont=Fira\ Code:h14
set guioptions=
set nu

filetype on
filetype plugin on
filetype indent on
filetype plugin indent on
syntax on

"tabstuff
set tabstop=2
set shiftwidth=2
set softtabstop=2
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
au FileType javascript.jsx setlocal shiftwidth=2 softtabstop=2 tabstop=2

"NERDTree
let NERDTreeChDirMode=2
" Open NERDTree with Atom command
nmap <D-\> :call ToggleMyTree()<CR>
nmap <C-\> :call ToggleMyTree()<CR>
nmap <Leader>f :call ToggleMyTree()<CR>
function! ToggleMyTree()
  if winnr("$") == 1
    exe "NERDTreeFind"
  else
    exe "NERDTreeToggle"
  endif
endfunction


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

set virtualedit=onemore         " allow for cursor beyond last character
set history=1000                " Store a ton of history (default is 20)
map <F5> :setlocal spell! spelllang=en_us<CR>
set hidden                      " allow buffer switching without saving

" Run php beautifier on Ctrl-B
au BufEnter,BufNew *.php map <C-b> :% ! php_beautifier --filters "PEAR() DocBlock()"<CR>
"autocmd BufWrite *.php % !php_beautifier --filters "phpBB() DocBlock()"

map <C-H> <ESC>:!phpm <C-R>=expand("<cword>")<CR><CR>

" Set .md files as markdown syntax
au BufRead,BufNewFile *.md set filetype=markdown

" Setup up color schemes to cycle through
nmap <Leader>1 :call SwitchColorSchemes()<CR>
function! SwitchColorSchemes()
  let scheme_number = input("Enter scheme number: ")
  if len(scheme_number) > 0
    if scheme_number == 1
      exe "MyColorscheme solarized"
    elseif scheme_number == 2
      exe "MyColorscheme OceanicNext"
    elseif scheme_number == 3
      exe "MyColorscheme material"
    elseif scheme_number == 4
      exe "MyColorscheme nova"
    elseif scheme_number == 5
      exe "MyColorscheme night-owl"
    elseif scheme_number == 6
      exe "MyColorscheme Wombat"
    elseif scheme_number == 7
      exe "MyColorscheme gruvbox"
    elseif scheme_number == 8
      exe "MyColorscheme molokai"
    elseif scheme_number == 9
      exe "MyColorscheme codeschool"
    endif
  endif
  exe "ColorHighlight"
endfunction

nmap <Leader>2 :call SetColorSchemeToFileTypeDefault()<CR>
function! SetColorSchemeToFileTypeDefault()
  let the_filetype = &filetype
  if the_filetype == "scss"
    exe "MyColorscheme candy"
  elseif the_filetype == "ruby"
    exe "MyColorscheme railscasts"
  elseif the_filetype == "eruby"
    exe "MyColorscheme railscasts"
  elseif the_filetype == "php"
    exe "MyColorscheme solarized"
  else
    exe "MyColorscheme solarized"
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
"let delimitMate_expand_cr=1
let delimitMate_expand_space=1

" fzf mappings
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf
nmap ; :Buffers<CR>
nmap <Leader>p :Files<CR>
nmap <D-p>:Files<CR>

" Tell ack.vim to use ag (the Silver Searcher) instead
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif
" Leader-g searches for the word under the cursor in files in the working directory
nmap <Leader>g :Ack! "\b<cword>\b" <CR>


" Close quick fix easily
nmap <Leader>w :cclose<CR>

autocmd FileType ruby set omnifunc=rubycomplete#Complete
let g:rubycomplete_buffer_loading = 1
let g:rubycomplete_classes_in_global = 1
let g:rubycomplete_rails = 1

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=160 guibg=#DA3435
autocmd VimEnter * match ExtraWhitespace /\s\+$/

"Remove all trailing whitespace by pressing F4
nnoremap <F4> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar><CR>

nnoremap <leader>t :bo :terminal<CR> source $HOME/.bash_profile<CR>

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.html.erb,*.jsx,*.js'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'
let g:closetag_filetypes = 'html,xhtml,phtml,eruby'
let g:closetag_xhtml_filetypes = 'xhtml,jsx,javascript.jsx,javascript'
let g:closetag_shortcut = '>'

let g:ycm_key_list_select_completion = []

let delimitMate_matchpairs = "(:),[:],{:}"

let g:ale_sign_error = '●' " Less aggressive than the default '>>'
let g:ale_sign_warning = '.'

let g:jsx_ext_required = 0

function! EsLintFix()
  if filereadable("./node_modules/.bin/eslint")
    if confirm('Autofix code via ESLint?', "&Yes\n&No", 1)==1
      execute "AsyncRun -post=checktime ./node_modules/.bin/eslint --fix %"
    endif
  endif
endfunction

augroup eslinter
  autocmd!
  autocmd BufWritePost *.js,*.jsx call EsLintFix()
augroup END

let g:deoplete#enable_at_startup = 1
let g:deoplete#file#enable_buffer_path = 1

let g:ale_fixers = {
  \ 'javascript': ['eslint']
  \ }
nmap <leader>d <Plug>(ale_fix)

set autoread
au FocusGained,BufEnter * :checktime
