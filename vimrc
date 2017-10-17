" Set up Pathogen plugin loading
execute pathogen#infect()

" Pluign config
autocmd vimenter * NERDTree
let g:lightline = {
      \ 'colorscheme': 'Dracula',
      \ }

nmap <silent> <Leader>f <Plug>(CommandT)

" Basic Config
syntax on
color dracula
filetype on
set number
set hidden
set history=100
set hlsearch
set showmatch
set guioptions=

" Set up indentation properly
filetype indent on
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent

""" Custom Mappings
" Let me edit and source my vimrc quickly
:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source ~/.vimrc<CR>

" Let me enter Normal mode w/o hitting enter
:inoremap jk <ESC>
