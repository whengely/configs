set nu
set relativenumber
set pastetoggle=<F2>
set tabstop=2
set shiftwidth=2
set expandtab
set smarttab
set nobackup
set nowritebackup
set hidden
set background=dark
set encoding=UTF-8

let g:deoplete#enable_at_startup = 1

let g:ale_completion_enabled = 1
let g:ale_fixers = ['prettier', 'eslint']
let g:ale_linters = {'typescript': ['eslint','prettier'], 'typescriptreact': ['eslint','prettier']}
let g:ale_sign_column_always = 1

let g:airline_powerline_fonts=1
let g:airline_statusline_ontop=0
let g:airline_theme='molokai'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#ale#enabled = 1

call plug#begin()

Plug 'neoclide/coc.nvim', {'tag': '*', 'do': './install.sh'}
Plug 'w0rp/ale'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/Shougo/denite.nvim.git'
Plug 'editorconfig/editorconfig-vim'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'yardnsm/vim-import-cost', { 'do': 'npm install' }
Plug 'https://github.com/Galooshi/vim-import-js.git'
Plug 'bling/vim-bufferline'
Plug 'https://github.com/tiagofumo/vim-nerdtree-syntax-highlight.git'
Plug 'ryanoasis/vim-devicons'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Implement stylelint at some time
" https://github.com/styled-components/stylelint-processor-styled-components
call plug#end()

command! -nargs=0 Prettier :CocCommand prettier.formatFile
command! -nargs=0 ReloadVim :source ~/.config/nvim/init.vim
command! -nargs=0 EditConfig :e ~/.config/nvim/init.vim

nmap <silent> <C-k> <Plug>(ale_previous_wrap) 
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprev<CR>
nnoremap <C-d> :bdelete<CR>
nnoremap <C-o> :NERDTreeToggle<CR>
