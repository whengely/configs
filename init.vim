set nu
set relativenumber
set pastetoggle=<F2>
set tabstop=1
set shiftwidth=2
set expandtab
set smarttab
set nobackup
set nowritebackup
set hidden
set background=dark
set encoding=UTF-8
set updatetime=300
set shortmess+=c
set signcolumn=number

let mapleader = ","

let g:airline_powerline_fonts=1
let g:airline_statusline_ontop=0
let g:airline_theme='papercolor'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#ale#enabled = 1

let NERDTreeMinimalUI = 1

" http://owen.cymru/fzf-ripgrep-navigate-with-bash-faster-than-ever-before/
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,jsx,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf,ts,tsx}"
  \ -g "!*package-lock.json*"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* RG call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)

filetype plugin indent off

call plug#begin()

" https://pragmaticpineapple.com/ultimate-vim-typescript-setup/
" :help ale
Plug 'dense-analysis/ale'

" Language Server Protocol
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Frontend
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jparise/vim-graphql'

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
" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'NLKNguyen/papercolor-theme'
Plug 'glepnir/dashboard-nvim'

"
" Implement stylelint at some time
" https://github.com/styled-components/stylelint-processor-styled-components
call plug#end()

colorscheme PaperColor
" dashboard-vim
let g:dashboard_default_executive = 'fzf'
let g:dashboard_preview_command = 'cat'
let g:dashboard_preview_pipeline = 'lolcat --animate --spread 12 --speed 35 --freq .2 --duration 6'
let g:dashboard_preview_file = '~/.config/nvim/game-on-anon'
let g:dashboard_preview_file_height = 16
let g:dashboard_preview_file_width = 80

" Source Vim configuration file and install plugins  ,1
nnoremap <silent><leader>1 :source ~/configs/init.vim \| :PlugInstall<CR>

" CoC extensions
let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-html', 'coc-css', 'coc-emoji', 'coc-graphql']
if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
  let g:coc_global_extensions += ['coc-prettier']
endif
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
  let g:coc_global_extensions += ['coc-eslint']
endif

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader><F2> <Plug>(coc-rename)

" Tab complete with COC
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ coc#refresh()

" Check if backspace was just pressed      
function! s:check_back_space() abort                    
  let col = col('.') - 1    
  return !col || getline('.')[col - 1]  =~# '\s'    
endfunction   

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Format
nmap <leader>f   :CocCommand prettier.formatFile<CR>

inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <C-p> :Files<CR>
nnoremap <F8> :ALENextWrap<CR>
inoremap <F8> <ESC>:ALENextWrap<CR>i
nnoremap <Right> :bnext<CR>
nnoremap <Left> :bprev<CR>
nnoremap <Down> :bdelete<CR>
nnoremap <C-o> :NERDTreeToggle<CR>
