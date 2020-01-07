"# vim: fdm=marker foldenable sw=4 ts=4 et sts=4 

" Plugins, autoload y ctags {{{

set nocompatible
filetype on
filetype plugin on

autocmd BufNewFile,BufRead *.conf,*.config set syntax=conf
" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml} set filetype=yaml foldmethod=indent
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

" Terminal init {{{ 
" Options:
" nobuflisted

try
    autocmd TermOpen * setlocal nospell nonumber textwidth=0 winheight=1
catch
    autocmd TerminalOpen * setlocal nospell nonumber textwidth=0 winheight=1
endtry

" }}}

if has('python3')
  silent! python3 1
endif
" }}}

" Plug {{{

" vim-plug
call plug#begin('~/.vim/plugged')

" Utils
Plug 'https://github.com/adelarsq/vim-matchit'

"Plug 'https://github.com/MarcWeber/vim-addon-mw-utils.git'
"Plug 'https://github.com/garbas/vim-snipmate.git'
"Plug 'https://github.com/mxw/vim-jsx.git'
"Plug 'https://github.com/powerman/vim-plugin-autosess.git'
"Plug 'https://github.com/tomtom/tlib_vim.git'
Plug 'git://github.com/jiangmiao/auto-pairs.git'
Plug 'git://github.com/tpope/vim-fugitive.git'
Plug 'git://github.com/tpope/vim-surround.git'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'https://github.com/elzr/vim-json'
Plug 'https://github.com/othree/html5.vim.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
"Plug 'https://github.com/ludovicchabant/vim-gutentags'
Plug 'https://github.com/editorconfig/editorconfig-vim'

" Python
Plug 'nvie/vim-flake8'

" Javascript
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'ianks/vim-tsx'
" Plug 'leafOfTree/vim-vue-plugin'

" Lint
Plug 'https://github.com/dense-analysis/ale'

" end vim-plug
call plug#end()
" }}}

" TAGS {{{
" https://tbaggery.com/2011/08/08/effortless-ctags-with-git.html
set tags=./tags,./.git/tags,.tags;$HOME
" }}}

" Plugins para JS y JSX {{{
let g:vim_jsx_pretty_highlight_close_tag = 1 " def 0
let g:vim_jsx_pretty_colorful_config = 1 " def 0
" jsx, verifica jsx dentro de .js
let g:jsx_ext_required = 0
" jsx estricto
"let g:jsx_pragma_required = 1
let g:vue_disable_pre_processors=1

" lint
"let b:ale_linter_aliases = ['javascript', 'vue']
"let b:ale_linters = {'javascript': ['eslint']}

" }}}

" Ale {{{
" integración con airline
let g:airline#extensions#ale#enabled = 1
" abre una ventana horizontal con los warning/error
let g:ale_open_list = 1
" mantiene la ventana aberta incluse si no hay mensajes
let g:ale_keep_list_window_open = 0
let g:ale_list_window_size = 5
" signos de mensajes
let g:ale_sign_error = '*' " '●'  Less aggressive than the default '>>'
let g:ale_sign_warning = '!'
" no muestra nada al abrir el file
let g:ale_lint_on_enter = 0
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0

" autocompletion
let g:ale_completion_enabled = 1

" Python {{{ 

let g:ale_python_auto_pipenv = 0
let g:ale_python_flake8_auto_pipenv = 0
let g:ale_python_flake8_change_directory = 1
let g:ale_python_flake8_executable = 'flake8'
let g:ale_python_flake8_options = '--max-line-length=120 --ignore=E265,E266,501'
let g:ale_python_flake8_use_global = 0

" }}}

" JavaScript, TypeScript {{{

" ts
let g:ale_completion_tsserver_autoimport = 1

" prettier
let b:ale_fixers = ['prettier', 'eslint']

" Indent
autocmd BufNewFile,BufRead *.js,*.ts,*.vue,*.jsx set ts=2 sw=2 sts=2 expandtab

" }}}

" }}}

" Guntentags {{{

set statusline+=%{gutentags#statusline()}

" }}}

" Vim-Airline {{{
let g:airline_powerline_fonts = 1

" theme
let g:airline_theme='badwolf'
"let g:airline_theme='base16_bright'
"let g:airline_theme='base16_monokai'
"let g:airline_theme = 'molokai'

" muestra los buffers como tabs
"
let g:airline#extensions#tabline#buffer_nr_show = 1

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" tabline format
" https://github.com/vim-airline/vim-airline#default
let g:airline#extensions#tabline#formatter = 'unique_tail_improved' " 'unique_tail'

" }}}

" CtrlP {{{
set runtimepath^=~/.vim/bundle/ctrlp.vim

" Set default mode as buffer
let g:ctrlp_cmd = 'CtrlPBuffer'
" let g:ctrlp_cmd = 'CtrlP'

" Setup some default ignores
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site|node_modules)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg|pyc|swp)$',
\}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" }}}

" Auto-Pair {{{

let g:AutoPairsShortcutFastWrap = '<C-e>'
let g:AutoPairsShortcutToggle = '<M-a>'

" }}}

" Customs del entorno, colores y esas cosas {{{

highlight ColorColumn guibg=purple
call matchadd('ColorColumn', '\%101v', 80)

"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%101v.\+/

"Mode Settings

let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

" for tmux 
"let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
"let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=2\x7\<Esc>\\"
"let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"

"Cursor settings:

"  1 -> blinking block
"  2 -> solid block 
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar


" }}}

" UI/UX General {{{

" Tmux compatible
set t_Co=256

" Coloreado por sintaxis
syntax on

" Paleta de colores para fondo oscuro (si usas fondo claro colocar light en lugar de dark)
"set background=dark
"colorscheme desert
syntax enable
colorscheme monokai

" Indentacion segun el tipo de archivo detectado
if has("autocmd")
    filetype indent on
endif

" backspace compatible
set backspace=indent,eol,start

" Mostrar parentesis que se emparejan
set showmatch

" Tabulador de 4 espacios
set shiftwidth=4
set tabstop=4
set smarttab
set expandtab
set autoindent
set softtabstop=4
set hlsearch
"set bs=2

" columnas y lineas
"set co=80
"set lines=24
" relative, number, etc
" set relativenumber
set number
set ruler

" fonts
" Menlo\ Regular 13
"set guifont=Menlo:h14
set laststatus=2
set ttimeoutlen=50
set encoding=utf-8
" }}}

" Configuración para NerdTree {{{
let g:NERDTreeGlyphReadOnly = ''
let g:NERDTreeDirArrows = 1
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
nmap <C-n> :NERDTreeToggle<CR>
" }}}

" Snippets y shortcuts {{{

" Mapeo de comandos propios [y ajenos]
nnoremap ,vcx :sp ~/vim_cheatsheet.vim<CR>

function! Header_django_template()
    put='{% comment %}'
    put='# fdm=marker foldenable sw=4 ts=4 et sts=4 filetype=htmldjango'
    put='Block: '
    put='{% endcomment %}'
endfunction
nnoremap ,tpl gg:call Header_django_template()<CR>

" }}}

" Funciones personales, tildes y esas cosas {{{

" Tildes2Acute: busca caracteres con tíldes y ñuflo y los transforma en &?atuce {{{
function! Tildes2Acute()
   %s/á/\&aacute;/gc
   %s/é/\&eacute;/gc
   %s/í/\&iacute;/gc
   %s/ó/\&oacute;/gc
   %s/ú/\&uacute;/gc
   %s/ñ/\&ntilde;/gc
   %s/Á/\&Aacute;/gc
   %s/É/\&Eacute;/gc
   %s/Í/\&Iacute;/gc
   %s/Ó/\&Oacute;/gc
   %s/Ú/\&Uacute;/gc
   %s/Ñ/\&Ntilde;/gc
endfunction
" }}}

" Acute2Tildes: busca caracteres con &?acute y los transforma tíldes y ñuflo {{{
function! Acute2Tildes()
   %s/&aacute;/á/gc
   %s/&eacute;/é/gc
   %s/&iacute;/í/gc
   %s/&oacute;/ó/gc
   %s/&uacute;/ú/gc
   %s/&ntilde;/ñ/gc
   %s/&Aacute;/Á/gc
   %s/&Eacute;/É/gc
   %s/&Iacute;/Í/gc
   %s/&Oacute;/Ó/gc
   %s/&Uacute;/Ú/gc
   %s/&Ntilde;/Ñ/gc
endfunction
" }}}

" HLNext: Highlight Next {{{
function! HLNext(blinktime)
    set invcursorline
    redraw
    exec 'sleep '. float2nr(a:blinktime * 1000) . 'm'
    set invcursorline
    redraw
endfunction

nnoremap <silent> n n:call HLNext(0.3)<CR>
" }}}

" Convert_to_li: crea una lista de <li> a partir de la selección actual {{{
function! Convert_to_li() range
    let lnum = a:firstline
    while lnum <= a:lastline
        let curr_line = getline(lnum)
        "busca y reemplaza cualquier & que no sea un &WORD es decir que el & 
        "preceda de una palabra.
        "let replacement = substitute(curr_line,'&\(\w\+;\)\@!','&amp;','g')
        call setline(lnum, "<li>" . curr_line . "</li>")
        let lnum = lnum + 1
    endwhile
endfunction

vnoremap <silent> L :'<,'>call Convert_to_li()<CR>
" }}}

" Wrap {% trans "" %} {{{
xnoremap <silent> trans xi{% trans "" %}<ESC>3hP
" }}}

" Wrap {% static "" %} {{{
xnoremap <silent> static xi{% static "" %}<ESC>3hP
" }}}

" }}}

" Key - bindings {{{

" Ctrl-l para deseleccionar las busquedas
nnoremap <silent> <C-l> :nohl<CR><C-l>

" buffers <>
" Move to the next buffer
nmap gt :bnext<CR>
" Move to the previous buffer
nmap gT :bprevious<CR>
 
" tabs <>
" Move to the next tab
nmap tt :tabNext<CR>
" Move to the previous buffer
nmap tT :tabprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
"nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
"nmap <leader>bl :ls<CR>

" remap <ESC> to normal-mode in :term
tnoremap <Esc> <C-\><C-n>

" hack para osx open https?
"let g:netrw_http_cmd='open'

" }}}
