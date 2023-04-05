set nocompatible
" Auto install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')

"Syntax highlighting plugins
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-rails'
Plug 'vim-scripts/applescript.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'othree/html5.vim'
Plug 'tpope/vim-haml'
Plug 'hail2u/vim-css3-syntax'
Plug 'ekalinin/Dockerfile.vim'
Plug 'mustache/vim-mustache-handlebars'
Plug 'pangloss/vim-javascript'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'stephpy/vim-yaml'

"Colorschemes
Plug 'altercation/vim-colors-solarized'
Plug '29decibel/codeschool-vim-theme'
Plug 'Lokaltog/vim-distinguished'
Plug 'tpope/vim-vividchalk'
Plug 'vim-scripts/Wombat'
Plug 'morhetz/gruvbox'
Plug 'tomasr/molokai'
Plug 'trevordmiller/nova-vim'
Plug 'mhartington/oceanic-next'
Plug 'carakan/new-railscasts-theme'
Plug 'kaicataldo/material.vim'
Plug 'haishanh/night-owl.vim'


"Interface improvements
Plug 'lilydjwg/colorizer'
Plug 'honza/vim-snippets'
"Plug "garbas/vim-snipmate"
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'mileszs/ack.vim'
Plug 'godlygeek/tabular'
Plug 'tpope/vim-surround'
"Plug 'Lokaltog/vim-easymotion'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'airblade/vim-gitgutter'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'raimondi/delimitmate'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-endwise'
"Plug 'valloric/youcompleteme'
Plug 'valloric/listtoggle'
Plug 'scrooloose/nerdtree'
Plug 'ludovicchabant/vim-gutentags'
Plug 'kristijanhusak/vim-js-file-import', {'do': 'npm install'}

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'github/copilot.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }
Plug 'wellle/context.vim'

"Utilites
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'skywind3000/asyncrun.vim'

call plug#end()

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
"MyColorscheme OceanicNext
MyColorscheme night-owl
"set guifont=Iosevka:h14,Monaco:h13

if has("gui_macvim")
  set macligatures
endif

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
au FileType php setlocal shiftwidth=4 softtabstop=4 tabstop=4
au FileType python setlocal shiftwidth=2 softtabstop=2 tabstop=2

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

" Quickly edit/reload the vimrc file
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <leader>sv :so $MYVIMRC<CR>

set ignorecase    " ignore case when searching
set smartcase     " ignore case if search pattern is all lowercase, case-sensitive otherwise
set smarttab      " insert tabs on the start of a line according to shiftwidth, not tabstop
set hlsearch      " highlight search terms
set incsearch     " show search matches as you type
set showmatch                   " show matching brackets/parenthesis
" Don't show ~ for lines beyoned end of file
hi NonText guifg=bg

"Turn off search highlighting with leader-/
nmap <silent> <leader>/ :nohlsearch<CR>

set virtualedit=onemore         " allow for cursor beyond last character
set history=1000                " Store a ton of history (default is 20)
map <F5> :setlocal spell! spelllang=en_us<CR>
set hidden                      " allow buffer switching without saving

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
set rtp+=/opt/homebrew/bin/fzf
set rtp+=~/.fzf
nmap ; :Buffers<CR>
nmap <Leader>p :Files<CR>
nmap <D-p>:Files<CR>
let g:fzf_layout = { 'down': '60%' }
let g:fzf_preview_window = ['up:50%', 'ctrl-/']
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }
command! -bang -nargs=? -complete=dir Files
      \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({ 'options': ['--preview-window', 'up:50%'] }), <bang>0)

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

nnoremap <leader>t :bo :terminal<CR> source $HOME/.zshrc<CR>

let g:closetag_filenames = '*.html,*.xhtml,*.phtml,*.html.erb,*.jsx,*.js'
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.js'
let g:closetag_filetypes = 'html,xhtml,phtml,eruby'
let g:closetag_xhtml_filetypes = 'xhtml,jsx,javascript.jsx,javascript'
let g:closetag_shortcut = '>'

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
  "autocmd BufWritePost *.js,*.jsx call EsLintFix()
augroup END

let g:ale_fixers = {
  \ 'javascript': ['prettier', 'eslint'],
  \ 'javascriptreact': ['prettier', 'eslint'],
  \ 'css': ['prettier'],
  \ 'typescript': ['tslint', 'eslint'],
  \ 'typescriptreact': ['prettier', 'eslint'],
  \ }
let g:ale_linters = {
  \ 'javascript': ['prettier', 'eslint',],
  \ 'javascriptreact': ['prettier', 'eslint'],
  \ 'typescriptreact': ['prettier', 'eslint', 'tsserver'],
  \ 'css': ['prettier'],
  \ }

nmap <leader>d <Plug>(ale_fix)

set autoread
au FocusGained,BufEnter * :checktime


" Start Coc.vim options
let g:coc_node_path = $HOME."/.nodenv/shims/node"

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() :"\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>\<c-r>=EndwiseDiscretionary()\<CR>" 

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" End Coc.vim options

" Copilot options
imap <silent> <D-]> <Plug>(copilot-next)
imap <silent> <D-[> <Plug>(copilot-previous)
imap <silent> <D-\> <Plug>(copilot-dismiss)

" End Copilot options

" Markdown preview options
let g:mkdp_auto_close = 0
nmap <C-p> <Plug>MarkdownPreviewToggle
