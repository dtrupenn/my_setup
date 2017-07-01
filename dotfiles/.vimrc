" Never hit escape again!
imap jk <Esc>:w<CR>

" Use 256 colors!
set t_Co=256

" utf-8 encoding baby!
set encoding=utf-8

" Make sure I can spell
" set spell spelllang=en_us

" Bye, bye arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

" Syntax Highlighting
syntax on
let g:rehash256 = 1
set background=dark
colorscheme molokai
"let g:molokai_original = 1

" Easy viewing of multiple files? Why not!
set hidden

" Line Numbers
set number

" What column am I in?
set ruler

" Cool tab completion stuff
set wildmenu
set wildmode=list:longest,full

" Enable mouse support in console (Has issues with git)
"set mouse=a

" Highlight things found with search
set hlsearch
set incsearch

" Why make search case sensitive?
set ignorecase

" Highlight current line
set cursorline

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Who wants an 8 character tab?  Not me!
set shiftwidth=4
set softtabstop=4

" Who doesn't like auto-indent?
set autoindent
set copyindent

" Spaces are better than a tab character
set expandtab
set smarttab

" This shows what you are typing as a command.
set showcmd

" Show that filename in that bottom
set ls=2

" Set that backspace to work
set backspace=indent,eol,start

" Why backup when you can git?
set nobackup
set noswapfile

" Die annoying beep die!!!
set visualbell
set noerrorbells

" Get them 80 columns (Vim 7.3 and above)
set colorcolumn=100
"highlight OverLength ctermbg=red ctermfg=white guibg=#592929
"match OverLength /\%81v.\+/

" Vundle Setup
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

Plugin 'gmarik/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'Lokaltog/vim-powerline'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-surround'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'chilicuil/conque'
Plugin 'kien/rainbow_parentheses.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'bling/vim-airline'
Plugin 'fatih/vim-go'
Plugin 'majutsushi/tagbar'
Plugin 'nathanaelkane/vim-indent-guides'
Plugin 'tomasr/molokai'
Plugin 'elzr/vim-json'
Plugin 'christoomey/vim-tmux-navigator'
Plugin 'airblade/vim-gitgutter'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

" OMG it's powerline!
let g:airline_powerline_fonts = 1
let g:airline_theme = 'powerlineish'

" Syntastic on by default
let g:syntastic_mode_map = { 'mode': 'active',
    \ 'active_filetypes': [],
    \ 'passive_filetypes': [] }

" Check it on startup
let g:syntastic_check_on_open = 1
" Don't check syntax when you quit fool
let g:syntastic_check_on_wq = 0
" Got them pretty symbols
let g:syntastic_error_symbol = '✗'
let g:syntastic_warning_symbol = '⚠'

" Checkers
let g:syntastic_python_checkers=['pyflakes']
let g:syntastic_json_checkers=['jsonlint']

" NERDtree things
nmap <C-l> :NERDTreeToggle<CR>

"Ctrl-p Stuff
set runtimepath^=~/.vim/bundle/ctrlp.vim
set wildignore+=*/tmp/*,*.so,*.swp,*.zip   " MacOSX/Linux
" set wildignore+=tmp\*,*.swp,*.zip,*.exe    " Windows
:helptags ~/.vim/bundle/ctrlp.vim/doc
let g:ctrlp_working_path_mode = 2          " CtrlP: use the nearest ancestor that contains one of these directories or files: .git/ .hg/ .svn/ .bzr/ _darcs/
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|node_modules',
    \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\|\.DS_Store',
    \ 'link': 'some_bad_symbolic_links',
    \ }
let g:ctrlp_extensions = [
   \ 'ctrlp-filetpe',
   \ ]
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
nmap ; :CtrlPBuffer<CR>
nnoremap <leader>. :CtrlPTag<cr>

" Rainbow parentheses colors.
" Left column is for terminal environment.
" Right column is for GUI environment.
" Outermost is determined by last.
let g:rbpt_colorpairs = [
    \ ['blue',       '#FF6000'],
    \ ['cyan', '#00FFFF'],
    \ ['darkmagenta',    '#CC00FF'],
    \ ['yellow',   '#FFFF00'],
    \ ['red',     '#FF0000'],
    \ ['darkgreen',    '#00FF00'],
    \ ['White',         '#c0c0c0'],
    \ ['blue',       '#FF6000'],
    \ ['cyan', '#00FFFF'],
    \ ['darkmagenta',    '#CC00FF'],
    \ ['yellow',   '#FFFF00'],
    \ ['red',     '#FF0000'],
    \ ['darkgreen',    '#00FF00'],
    \ ['White',         '#c0c0c0'],
    \ ['blue',       '#FF6000'],
    \ ['cyan', '#00FFFF'],
    \ ['darkmagenta',    '#CC00FF'],
    \ ['yellow',   '#FFFF00'],
    \ ['red',     '#FF0000'],
    \ ['darkgreen',    '#00FF00'],
    \ ['White',         '#c0c0c0'],
    \ ]

" Update this with the amount of supported colors
"let g:rbpt_max = 21
let g:rbpt_max = 21

" Turn rainbow parenthesis script on
au VimEnter * RainbowParenthesesToggle
" These are necessary to re-load the stuff when syntax changes.
au Syntax * RainbowParenthesesLoadRound

"vim-indent-guides
let g:indent_guides_start_level = 2
let g:indent_guides_guid_size = 1

"vim-tmux-navigator
let g:tmux_navigator_no_mappings = 1

nnoremap <silent> {Left-mapping} :TmuxNavigateLeft<cr>
nnoremap <silent> {Down-Mapping} :TmuxNavigateDown<cr>
nnoremap <silent> {Up-Mapping} :TmuxNavigateUp<cr>
nnoremap <silent> {Right-Mapping} :TmuxNavigateRight<cr>
nnoremap <silent> {Previous-Mapping} :TmuxNavigatePrevious<cr>

let g:tmux_navigator_save_on_switch = 1
