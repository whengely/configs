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
set updatetime=300
set shortmess+=c
set signcolumn=number
" Use SHIFT when pasting
set mouse=a
set textwidth=120
set formatoptions+=t
set nohlsearch
set foldenable
set foldmethod=syntax
set foldnestmax=5
set foldcolumn=1
set foldlevelstart=99

set autoread
" Trigger `autoread` when files changes on disk
" https://unix.stackexchange.com/questions/149209/refresh-changed-content-of-file-opened-in-vim/383044#383044
" https://vi.stackexchange.com/questions/13692/prevent-focusgained-autocmd-running-in-command-line-editing-mode
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
  \ if mode() !~ '\v(c|r.?|!|t)' && getcmdwintype() == '' | checktime | endif

" Notification after file change
" https://vi.stackexchange.com/questions/13091/autocmd-event-for-autoread
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

let mapleader = "\<Space>"

let g:airline_powerline_fonts=1
let g:airline_statusline_ontop=0
let g:airline_theme='palenight'

let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 0
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
let g:airline#extensions#ale#enabled = 1

let NERDTreeMinimalUI = 1
let NERDTreeShowHidden=1
let NERDTreeWinSize=55

" http://owen.cymru/fzf-ripgrep-navigate-with-bash-faster-than-ever-before/
let g:rg_command = '
  \ rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --color "always"
  \ -g "*.{js,jsx,json,php,md,styl,jade,html,config,py,cpp,c,go,hs,rb,conf,ts,tsx}"
  \ -g "!*package-lock.json*"
  \ -g "!{.git,node_modules,vendor}/*" '

command! -bang -nargs=* RG call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
command Wc write | bdelete

" Delete empty space from the end of lines on every save
autocmd BufWritePre * :%s/\s\+$//e

filetype plugin indent off

call plug#begin()

" https://pragmaticpineapple.com/ultimate-vim-typescript-setup/
" :help ale
Plug 'dense-analysis/ale'

" Language Server Protocol
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Git
Plug 'tpope/vim-fugitive'

" Frontend
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'maxmellon/vim-jsx-pretty'
Plug 'jparise/vim-graphql'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'https://github.com/Shougo/denite.nvim.git'
Plug 'editorconfig/editorconfig-vim'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/tiagofumo/vim-nerdtree-syntax-highlight.git'
Plug 'yardnsm/vim-import-cost', { 'do': 'npm install --production' }
Plug 'kyazdani42/nvim-web-devicons'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'glepnir/dashboard-nvim'
Plug 'akinsho/bufferline.nvim'
Plug 'moll/vim-bbye'
Plug 'tpope/vim-commentary'
"Plug 'neovim/nvim-lspconfig' "also needs npm i -g vscode-langservers-extracted

"
" Implement stylelint at some time
" https://github.com/styled-components/stylelint-processor-styled-components
call plug#end()

colorscheme palenight
let g:palenight_terminal_italics=1
if (has("nvim"))
  "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif

"For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
"Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
" < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
if (has("termguicolors"))
  set termguicolors
endif

" bufferline
lua << EOF
require("bufferline").setup{
  options = {
    max_name_length = 20,
    tab_size = 25,
    diagnostics = "coc"
  }
}
EOF


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
let g:coc_global_extensions = ['coc-tsserver', 'coc-json', 'coc-html', 'coc-css', 'coc-emoji', 'coc-graphql', 'coc-react-refactor', 'coc-styled-components']
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
" inoremap <silent><expr> <TAB>
"   \ pumvisible() ? "\<C-n>" :
"   \ <SID>check_back_space() ? "\<TAB>" :
"   \ coc#refresh()

" Check if backspace was just pressed
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" inoremap <expr> <<CR>> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac   <Plug>(coc-codeaction)

" Apply AutoFix to problem on the current line.
nmap <leader>qf   <Plug>(coc-fix-current)
nmap <leader>qq   :CocFix<CR>

" Format
nmap <leader>f    :CocCommand prettier.formatFile<CR>


" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>

let g:dashboard_custom_section={
\ 'session': {
\   'description': ['🕚   Last session                 SPC sl'],
\   'command': 'SessionLoad'
\ },
\ 'find_file': {
\   'description': ['🔍📝 Find File                       C-p'],
\   'command': 'DashboardFindFile'
\ },
\ 'find_word': {
\   'description': ['🔍🎫 Find Word                   SPC C-p'],
\   'command': 'DashboardFindWord'
\ },
\ 'history': {
\   'description': ['📜   History                      SPC hh'],
\   'command': 'DashboardFindHistory'
\ },
\ 'new_file': {
\   'description': ['🆕   New File                     SPC nf'],
\   'command': 'DashboardNewFile'
\ }
\}

nmap <Leader>ss :<C-u>SessionSave<CR>
nmap <Leader>sl :<C-u>SessionLoad<CR>
nnoremap <Silent> <Leader>hh :DashboardFindHistory<CR>

nmap <leader>oi :CocCommand tsserver.organizeImports<<CR>>
nmap <leader>rt :CocCommand tsserver.restart<<CR>>
" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

" https://github.com/neoclide/coc.nvim/wiki/Debug-language-server#using-output-channel
nnoremap <Leader>so               :CocCommand workspace.showOutput<CR>
nnoremap <Leader>gic              :ImportCost<CR>
nmap <Leader>r                    :NERDTreeFocus<CR>R<c-w><c-p>
nnoremap <A-L>                    :NERDTreeFind<CR>
nnoremap <silent>gb               :BufferLinePick<CR>
inoremap <silent><expr> <c-space> coc#refresh()
nnoremap <C-p>                    :Files<CR>
nnoremap <Leader><C-p>            :Rg<CR>
nnoremap <F8>                     :ALENextWrap<CR>
inoremap <F8>                     <ESC>:ALENextWrap<CR>i
nnoremap <Right>                  :bnext<CR>
nnoremap <Left>                   :bprev<CR>
nnoremap <Down>                   :Bdelete<CR>
nnoremap <Leader><Down>           :Bdelete!<CR>
nnoremap <C-o>                    :NERDTreeToggle<CR>
nnoremap <Leader><C-Down>         :bufdo bd<CR>
nnoremap <Leader>sq               :Wc<CR>
nnoremap <Leader>focus            :Goyo<CR>
