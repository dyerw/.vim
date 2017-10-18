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
set guioptions=
set guifont=Operator\ Mono\ Book:h14
set relativenumber

" Set up indentation properly
filetype indent on
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent

" Searching / Moving defaults
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <leader><space> :noh<cr>
nnoremap <tab> %
vnoremap <tab> %

" System copy/paste
nnoremap <leader>p "+p
nnoremap <leader>y "+y
vnoremap <leader>p "+p
vnoremap <leader>y "+y

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

function! Git_Repo_Cdup() " Get the relative path to repo root
    "Ask git for the root of the git repo (as a relative '../../' path)
    let git_top = system('git rev-parse --show-cdup')
    let git_fail = 'fatal: Not a git repository'
    if strpart(git_top, 0, strlen(git_fail)) == git_fail
        " Above line says we are not in git repo. Ugly. Better version?
        return ''
    else
        " Return the cdup path to the root. If already in root,
        " path will be empty, so add './'
        return './' . git_top
    endif
endfunction

function! CD_Git_Root()
    execute 'cd '.Git_Repo_Cdup()
    let curdir = getcwd()
    echo 'CWD now set to: '.curdir
endfunction
nnoremap <LEADER>gr :call CD_Git_Root()<cr>

" Define the wildignore from gitignore. Primarily for CommandT
function! WildignoreFromGitignore()
    silent call CD_Git_Root()
    let gitignore = '.gitignore'
    if filereadable(gitignore)
        let igstring = ''
        for oline in readfile(gitignore)
            let line = substitute(oline, '\s|\n|\r', '', "g")
            if line =~ '^#' | con | endif
            if line == '' | con  | endif
            if line =~ '^!' | con  | endif
            if line =~ '/$' | let igstring .= "," . line . "*" | con | endif
            let igstring .= "," . line
        endfor
        let execstring = "set wildignore=".substitute(igstring,'^,','',"g")
        execute execstring
        echo 'Wildignore defined from gitignore in: '.getcwd()
    else
        echo 'Unable to find gitignore'
    endif
endfunction
nnoremap <LEADER>cti :call WildignoreFromGitignore()<cr>

