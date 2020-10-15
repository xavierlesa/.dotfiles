"# vim: fdm=marker foldenable sw=4 ts=4 et sts=4 
set nocompatible
set t_Co=256
set autoindent
set background=dark
set backspace=indent,eol,start
set encoding=utf-8
set expandtab
set hidden
set hlsearch
set laststatus=2
set number
set relativenumber
set numberwidth=3
set ruler
set runtimepath^=~/.vim/bundle/ctrlp.vim
set shiftwidth=4
set showmatch
set smarttab
set softtabstop=4
set tabstop=4
set tags=./tags,./.tags,./.git/tags,.tags;$HOME
set ttimeoutlen=50
set statusline+=%{gutentags#statusline()}
filetype on
filetype plugin on
syntax on
syntax enable
colorscheme monokai
set colorcolumn=100
highlight ColorColumn guibg=lightgrey
"call matchadd('ColorColumn', '\%101v', 80)
autocmd BufNewFile,BufRead *.conf,*.config,.env,.env.* set syntax=config
autocmd BufNewFile,BufRead *.js,*.vue,*.ts set tabstop=2 shiftwidth=2 expandtab
autocmd FileType yaml setlocal et ts=2 ai sw=2 nu sts=0

let using_neovim = has('nvim')
let using_vim = !using_neovim

" Indentación segun el tipo de archivo detectado
if has("autocmd")
    filetype indent on
endif

if has('TermOpen')
    autocmd TermOpen * setlocal nospell nonumber textwidth=0 winheight=1
endif
if has('TerminalOpen')
    autocmd TerminalOpen * setlocal nospell nonumber textwidth=0 winheight=1
endif

if has('python3')
  silent! python3 1
endif

if has("persistent_undo")
    set undodir="$HOME/.undodir"
    set undofile
endif

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/adelarsq/vim-matchit'
Plug 'https://github.com/ycm-core/YouCompleteMe'
"Plug 'https://github.com/neoclide/coc.nvim', {'branch': 'release'}
"Plug 'git://github.com/jiangmiao/auto-pairs.git'
Plug 'git://github.com/tpope/vim-fugitive.git'
Plug 'git://github.com/tpope/vim-surround.git'
Plug 'plasticboy/vim-markdown'
Plug 'https://github.com/ctrlpvim/ctrlp.vim.git'
Plug 'https://github.com/rking/ag.vim'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'https://github.com/elzr/vim-json'
Plug 'https://github.com/othree/html5.vim.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/ryanoasis/vim-devicons'
Plug 'https://github.com/tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'https://github.com/vim-airline/vim-airline'
Plug 'https://github.com/vim-airline/vim-airline-themes'
Plug 'https://github.com/ludovicchabant/vim-gutentags'
Plug 'https://github.com/editorconfig/editorconfig-vim'
Plug 'https://github.com/NLKNguyen/papercolor-theme'
Plug 'nvie/vim-flake8'
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'ianks/vim-tsx'
Plug 'https://github.com/mbbill/undotree'
"Plug 'https://github.com/dense-analysis/ale'
Plug 'https://github.com/Glench/Vim-Jinja2-Syntax'
Plug 'https://github.com/dhruvasagar/vim-zoom'
Plug 'mhinz/vim-startify'

call plug#end()

let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let g:AutoPairsShortcutFastWrap = '<C-e>'
let g:AutoPairsShortcutToggle = '<M-l>'
let g:NERDTreeDirArrowCollapsible = '▾'
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrows = 1
let g:NERDTreeExactMatchHighlightFullName = 1
let g:NERDTreeFileExtensionHighlightFullName = 1
let g:NERDTreeGlyphReadOnly = ''
let g:NERDTreeHighlightFolders = 1 " enables folder icon highlighting using exact match
let g:NERDTreeHighlightFoldersFullName = 1 " highlights the folder name
let g:NERDTreePatternMatchHighlightFullName = 1
"let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#formatter = 'unique_tail_improved' " 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark' " 'molokai' 'base16_snazzy'
"let g:ale_completion_enabled = 1
"let g:ale_completion_tsserver_autoimport = 1
"let b:ale_fixers = ['prettier', 'eslint']
"let g:ale_keep_list_window_open = 0
"let g:ale_lint_on_enter = 0
"let g:ale_lint_on_insert_leave = 0
"let g:ale_lint_on_text_changed = 'never'
"let g:ale_list_window_size = 5
"let g:ale_open_list = 1
"let g:ale_python_auto_pipenv = 0
"let g:ale_python_flake8_auto_pipenv = 0
"let g:ale_python_flake8_change_directory = 1
"let g:ale_python_flake8_executable = 'flake8'
"let g:ale_python_flake8_options = '--max-line-length=120 --ignore=E265,E266,501'
"let g:ale_python_flake8_use_global = 0
"let g:ale_sign_error = '●' " Less aggressive than the default '>>'
"let g:ale_sign_warning = '.'

let g:ctrlp_cmd = 'CtrlPMixed' " 'CtrlPBuffer'
let g:ctrlp_custom_ignore = {'dir': '\v[\/](\.(git|hg|svn)|\_site|node_modules)$', 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg|pyc|swp)$',}
let g:ctrlp_open_multiple_files = '2vjr'
let g:ctrlp_working_path_mode = 'r'

if executable('ag')
  let g:ctrlp_use_caching=0
  let g:ctrlp_user_command='ag %s -i --nocolor --nogroup -g ""'
endif

let g:ag_working_path_mode="r"

let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
let g:gutentags_ctags_tagfile = '.tags'
let g:gutentags_plus_switch = 1
let g:gutentags_project_root = ['package.json', 'composer.json', 'Pipfile.lock', '.env']
let g:jsx_ext_required = 0
let g:undotree_DiffAutoOpen = 1
let g:undotree_WindowLayout = 2
let g:vim_jsx_pretty_colorful_config = 1 " def 0
let g:vim_jsx_pretty_highlight_close_tag = 1 " def 0
let g:vue_disable_pre_processors=1
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
"let g:webdevicons_conceal_nerdtree_brackets = 0
let g:webdevicons_enable_ctrlp = 1
let g:webdevicons_enable_airline_tabline = 1
let g:webdevicons_enable_airline_statusline = 1

" [KEY]MAPS
"let mapleader=' ' " <space> como Leader 
nmap <C-n> :NERDTreeToggle<CR>
nmap gt :bnext<CR>
nmap gT :bprevious<CR>
nmap tt :tabNext<CR>
nmap tT :tabprevious<CR>

" FZF
map <C-f> <Esc><Esc>:Files!<CR>
inoremap <C-f> <Esc><Esc>:BLines!<CR>


nnoremap <C-s> :UndotreeToggle<cr>
nnoremap <silent> <C-l> :nohl<CR><C-l>
" remap <ESC> to normal-mode in :term
tnoremap <Esc> <C-\><C-n>
" Mapeo de comandos propios [y ajenos]
nnoremap ,vcx :sp ~/vim_cheatsheet.vim<CR>

" FUNCTIONS
function! HLNext(blinktime)
    set invcursorline
    redraw
    exec 'sleep '. float2nr(a:blinktime * 1000) . 'm'
    set invcursorline
    redraw
endfunction
nnoremap <silent> n n:call HLNext(0.3)<CR>

" swap-colorscheme
function! Swapschema()
"    if background == "dark"
    if &background ==# 'dark'
        set background=light
        colorscheme PaperColor
    else
        set background=dark
        colorscheme monokai
    endif
endfunction
