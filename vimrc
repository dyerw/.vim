" Set up Pathogen plugin loading
execute pathogen#infect()

" Pluign config
autocmd vimenter * NERDTree
let g:lightline = {
      \ 'colorscheme': 'Dracula',
      \ }

" Basic Config
syntax on
color dracula
filetype on
set number
set hidden
set history=100
set hlsearch
set showmatch
map <leader>s :source ~/.vimrc<CR>
set guioptions=

" Set up indentation properly
filetype indent on
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent

