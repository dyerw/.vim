set encoding=utf-8
scriptencoding utf-8

" Install Plug if it isn't
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

source plugins.vim

let g:startify_custom_header = [
      \'                                 ',
      \'      ________ ++     ________   ',
      \'     /VVVVVVVV\++++  /VVVVVVVV\  ',
      \'     \VVVVVVVV/++++++\VVVVVVVV/  ',
      \'      |VVVVVV|++++++++/VVVVV/''  ',
      \'      |VVVVVV|++++++/VVVVV/''    ',
      \'     +|VVVVVV|++++/VVVVV/''+     ',
      \'   +++|VVVVVV|++/VVVVV/''+++++   ',
      \' +++++|VVVVVV|/VVVVV/''+++++++++ ',
      \'   +++|VVVVVVVVVVV/''+++++++++   ',
      \'     +|VVVVVVVVV/''+++++++++     ',
      \'      |VVVVVVV/''+++++++++       ',
      \'      |VVVVV/''+++++++++         ',
      \'      |VVV/''+++++++++           ',
      \'      ''V/''   ++++++            ',
      \'               ++                ',
      \'                                 ',
      \] 


" Plugin config
set rtp+=/usr/local/opt/fzf
let g:lightline = {
      \ 'colorscheme': 'Dracula',
      \ }
set laststatus=2

" FZF bindings
nnoremap <leader>f :Files<CR>
nnoremap <leader>r :Buffers<CR>

" Basic Config
syntax on
color dracula
filetype on
set number
set hidden
set history=100
set guioptions=
set relativenumber

" Set up indentation properly
filetype indent on
set nowrap
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
set autoindent

" Whitespace!
nmap <leader>l :set list!<CR>
set listchars=tab:▸-,eol:¬,space:∙,trail:◥

" Terminal keys
tnoremap jk <C-\><C-n>
nnoremap <leader>o :below 10sp term://fish<cr>i


" Split navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
tnoremap <C-J> <C-W><C-J>
tnoremap <C-K> <C-W><C-K>
tnoremap <C-L> <C-W><C-L>
tnoremap <C-H> <C-W><C-H>

" netrw keys
nnoremap <leader>ex :Explore<CR>
nnoremap <leader>exv :Vexplore<CR>
nnoremap <leader>exh :Sexplore<CR>

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

" Supertab
let g:SuperTabDefaultCompletionType = '<c-x><c-o>'

if has("gui_running")
  imap <c-space> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
else " no gui
  if has("unix")
    inoremap <Nul> <c-r>=SuperTabAlternateCompletion("\<lt>c-x>\<lt>c-o>")<cr>
  endif
endif

"" Language autocomplete stuff
let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc
autocmd FileType ruby let g:rubycomplete_rails = 1
autocmd FileType ruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby let g:rubycomplete_classes_in_global = 1   
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete

""" Custom Mappings
" Let me edit and source my vimrc quickly
:nnoremap <leader>ev :vsplit ~/.vim/vimrc<cr>
:nnoremap <leader>sv :source ~/.vim/vimrc<CR>

" JSON Formatting
:nnoremap <leader>jf :%!python -m json.tool<CR>

" Let me enter Normal mode w/o hitting enter
:inoremap jk <ESC>

" Yo, fuck grep
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor
endif

" Search project for word under cursor
nnoremap <leader>ag :grep! "\b<C-R><C-W>\b"<CR>:cw<CR><CR>

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

