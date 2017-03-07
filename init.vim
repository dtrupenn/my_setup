"""
" Key Mappings
"""

" Map :w!! to allow writing file as sudo if opened normally
" http://stackoverflow.com/questions/2600783/how-does-the-vim-write-with-sudo-trick-work?answertab=active#tab-top
cmap w!! w !sudo tee > /dev/null %

" Never hit escape again!
imap jk <Esc>:w<CR>
imap jj <Esc>

" Bye, bye arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

"""
" Placement
"""
" Line Numbers
set number

" Highlight current line
set cursorline

" Syntax Highlighting
syntax on

" Use 256 colors!
set t_Co=256

colorscheme molokai

"""
" Search
"""
" Why make search case sensitive?
" set search case to a good configuration http://vim.wikia.com/wiki/Searching
set ignorecase
set smartcase

" Highlight things found with search
set hlsearch
set incsearch

" Remove any trailing whitespace that is in the file
autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" Who wants an 8 character tab?  Not me!
set shiftwidth=4
set softtabstop=4

" Why backup when you can git?
set nobackup
set noswapfile

" Die annoying beep die!!!
set visualbell
set noerrorbells

" Highlight 80th column and all columns past 100 (Vim 7.3 and above)
let &colorcolumn="80,".join(range(100,999),",")


"""
" Plugins
"""

" Specify a directory for plugins (for Neovim: ~/.local/share/nvim/plugged)
call plug#begin('~/.config/nvim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neomake/neomake'
Plug 'kien/rainbow_parentheses.vim'
Plug 'tpope/vim-fugitive'
Plug 'Yggdroot/indentLine'
Plug 'Lokaltog/vim-easymotion'
Plug 'tamelion/neovim-molokai'
Plug 'zchee/deoplete-jedi'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }


" On-demand plugins
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Initialize plugin system
call plug#end()

"""
" Plugin Settings
"""

" Ctrl-P Settings
set wildignore+=*/tmp/*,*.so,*.swp,*.zip   " MacOSX/Linux
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\.git$\|\.hg$\|\.svn$\|node_modules',
    \ 'file': '\.pyc$\|\.pyo$\|\.rbc$|\.rbo$\|\.class$\|\.o$\|\~$\|\.DS_Store'
    \ }
let g:ctrlp_follow_symlinks = 1
let g:ctrlp_match_window_bottom = 0
let g:ctrlp_match_window_reversed = 0
nmap ; :CtrlPBuffer<CR>
nnoremap <leader>. :CtrlPTag<cr>

" Airline Settings
let g:airline_powerline_fonts = 1
let g:airline_theme = 'luna'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" Neomake Settings
"let g:neomake_python_flake8_maker = { 'exe': '/usr/local/bin/flake8' }
let g:neomake_python_enabled_makers = ['flake8']
let g:neomake_python_flake8_maker = { 'args': ['--ignore=E501,E402'], }
"let g:neomake_open_list = 2
autocmd BufWritePost,BufEnter * Neomake  " run NeoMake on save

" Nerdtree Settings
nmap <C-L> :NERDTreeToggle<CR>

let g:molokai_original = 1
let g:rehash256 = 1

" Use deoplete.
let g:deoplete#enable_at_startup = 1
