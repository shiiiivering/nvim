
let mapleader="\<space>"


" general settings
set number " show line number
set relativenumber " relative number
set cursorline " line below cursor line
set wrap
set noshowcmd
set wildmenu

set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on

set encoding=utf-8

let &t_ut='' " compatible with different terminals to make sure they display correct color

" tab operation
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set list " display spaces at the end of line
set tw=0
set indentexpr=
set backspace=indent,eol,start " press backspace at begin of line will jump to end of line
set foldmethod=indent
set foldlevel=99

" with different style of cursor under different mode
let &t_SI = "\<ESC>]50;CursorShape=1\x7"
let &t_SR = "\<ESC>]50;CursorShape=2\x7"
let &t_EI = "\<ESC>]50;CursorShape=0\x7"

set laststatus=2
set autochdir " automatically switch dir to current file path

" when close a file, cursor will automatically jump to last position when next
" time you reopen it
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif


syntax on " syntax highlight
colorscheme darkblue

" search
set hlsearch " high light search 
exec "nohlsearch"
set incsearch " high light while input
set ignorecase " ignore case
set smartcase " ignore case when all input is lowercase
noremap n nzz
noremap N Nzz
noremap <LEADER><CR> :nohlsearch<CR>

set foldmethod=indent " fold method
set pastetoggle=<C>2 " CTRL + 2 switch paste mode

" inoremap jj <Esc>
" use space + h/j/k/l to switch window
map <LEADER>l <C-w>l
map <LEADER>h <C-w>h
map <LEADER>j <C-w>j
map <LEADER>k <C-w>k

" change size of splited window
noremap <C-up> :res +5<CR>
noremap <C-down> :res -5<CR>
noremap <C-left> :vertical resize-5<CR>
noremap <C-right> :vertical resize+5<CR>

" split screen
noremap <LEADER>sv :vsplit<CR>
noremap <LEADER>sh :split<CR>
" change the direction of split
noremap <LEADER>stv <C-w>t<C-w>H
noremap <LEADER>sth <C-w>t<C-w>K


" tabs
noremap tu :tabe<CR>
noremap tn :+tabnext<CR>
noremap tp :-tabnext<CR>

" TODO: edit .vim to .nvim later, cause its for vim
call plug#begin('~/.vim/plugged')

Plug 'vim-airline/vim-airline' " status bar under the screen
Plug 'connorholyday/vim-snazzy' " color scheme snazzy
Plug 'crusoexia/vim-monokai' " color scheme monokai

Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

color snazzy


" nerdTree
noremap <LEADER>tt :NERDTreeToggle<CR>
" auto close nerdTree when it is the last window
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
let NERDTreeAutoCenter=1
let NERDTreeShowLineNumbers=1
let NERDTreeShowHidden=1
" share nerdTree when start vim in terminal
let g:nerdtree_tabs_open_on_console_startup=1
let NERDTreeIgnore=['\.pyc','\~$', '\.swp']

" ================================
" coc.nvim
" use <LEADER>c to call coc functions
let g:coc_global_extensions = [
            \'coc-json', 
            \'coc-vimlsp',
            \'coc-tsserver',
            \'coc-marketplace',
            \'coc-actions',
            \'coc-clangd', 
            \'coc-cmake',
            \'coc-git',
            \'coc-sh',
            \'coc-syntax',
            \'coc-pairs',
            \'coc-highlight',
            \'coc-pyright',
            \]
let g:coc_disable_startup_warning = 1
" jump to reference or other files without saving previous file
" by creating new buffer
set hidden
" let vim faster
set updatetime=100
" Don't pass messages to |ins-completion-menu|
set shortmess+=c
" set Tab active
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" use <c-o> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-o> coc#refresh()
else
  inoremap <silent><expr> <c-o> coc#refresh()
endif

" use Enter(<CR>)to confirm completion
" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
" navigate diagnostics
nmap <silent> <LEADER>= <Plug>(coc-diagnostic-next)
nmap <silent> <LEADER>+ <Plug>(coc-disgnostic-prev)
" FIND DEFINITION OR REFERENCES
nmap <silent> <LEADER>cd <Plug>(coc-definition)
nmap <silent> <LEADER>cy <Plug>(coc-type-definition)
nmap <silent> <LEADER>ci <Plug>(coc-implementation)
nmap <silent> <LEADER>cr <Plug>(coc-references)
" Use <LEADER>cs to show documentation in preview window.
nnoremap <silent> <LEDER>cs :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
else
    call feedkeys('K', 'in')
  endif
endfunction
" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
" Symbol renaming.
nmap <leader>crn <Plug>(coc-rename)
" Formatting selected code.
xmap <leader>cf  <Plug>(coc-format-selected)
nmap <leader>cf  <Plug>(coc-format-selected)
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <leader>ca  <Plug>(coc-codeaction-selected)
nmap <leader>ca  <Plug>(coc-codeaction-selected)


