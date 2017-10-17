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

" JSON Formatting
:nnoremap <leader>fj :%!python -m json.tool<CR>

" Let me enter Normal mode w/o hitting enter
:inoremap jk <ESC>

""" Custom Functions

function! ToggleSpec()
  let curr_file = @%
  if (curr_file =~ "\.rb")
    if (curr_file =~ "_spec")
      let sub = ".rb" 
      let pat = "_spec\.rb" 
    else
      let sub = "_spec.rb"
      let pat = "\.rb"
    endif

    let toggle_file = split(substitute(curr_file, pat, sub, ""), "\/")[-1]
    let file = split(globpath(".", "**/*" . toggle_file), "\n")[0]
    execute "edit " . file
  else
    echo "Cannot toggle to spec in non-Ruby file"
  endif
endfunction
:nnoremap <leader>ts :call ToggleSpec()<CR>

