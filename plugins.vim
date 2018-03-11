" Manage all plugins for Vim install
call plug#begin('~/.vim/plugged')

" Fuzzy file searching
" this requires an external installation
" of fzf cloned to ~/.fzf
Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
Plug 'junegunn/fzf.vim'

" Status line
Plug 'itchyny/lightline.vim'

" Buffer management
Plug 'jeetsukumaran/vim-buffergator'

" Git integration
Plug 'tpope/vim-fugitive'

" GitHub integration
Plug 'tpope/vim-rhubarb'

" Show pretty Git stuff in the gutter
Plug 'airblade/vim-gitgutter'

" Loadup vim with a nice screen
Plug 'mhinz/vim-startify'

" Surround motions
Plug 'tpope/vim-surround'

call plug#end()
