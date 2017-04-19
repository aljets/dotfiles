set shell=/bin/sh " while using fish
set nocompatible

" =============== Plugin Initialization ==============
" First run: $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Install new plugins: :PlugInstall
filetype on " to exit system status 1. required for fish shell
filetype off " for syntastic
call plug#begin('~/.vim/plugged')
Plug 'mileszs/ack.vim'
Plug 'kien/ctrlp.vim'
Plug 'phleet/vim-mercenary'          " mercurial stuff (`:hg blame`, etc.)
Plug 'ervandew/supertab'             " one day consider replacing this with a mapping of Ctrl-N

" Motion plugins
Plug 'kana/vim-textobj-user'         " required for custom text object plugins
Plug 'bps/vim-textobj-python'        " provides af/if/ac/ic for selecting classes and functions and [pf, ]pf, [pc, ]pc for next/previous function/class

" syntax plugins
Plug 'hynek/vim-python-pep8-indent'  " python indentation per pep8
Plug 'scrooloose/syntastic'          " syntax highlighting, flake8, etc.
Plug 'mxw/vim-jsx'                   " jsx syntax and highlighting
Plug 'pangloss/vim-javascript'       " better js syntax and highlighting

" trial plugins
Plug 'easymotion/vim-easymotion'     " of dubious utility
Plug 'Chun-Yang/vim-textobj-chunk'   " provides generic ac/ic. presumably interfereces with textobj-python
Plug 'tpope/vim-surround' " looks extremely useful, once familiar add tpope's /vim-repeat
Plug 'sjbach/lusty' " requires set hidden
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()
filetype on

" ================ General Config ====================
let &t_Co=256
let g:zenburn_high_Contrast=1
colorscheme zenburn            " formerly: wombat256
set colorcolumn=101            " line length indicator
highlight colorcolumn ctermbg=0 guibg=Black
set ruler                      " Column/row indicator in status bar
set number                     " Show columns on left
set relativenumber             " Show columns relative
set cursorline                 " Highlight current
set history=256
set laststatus=2               " Always show bottom status bar (filename, ruler, etc.)
set backspace=indent,eol,start " Make backspace work
set nobackup                   " No backup files

" ================ Search ===========================
set ignorecase
set smartcase
set incsearch
set hlsearch
set hidden " allow modified buffers to be hidden, required by lustyexplorer and maybe simply ok?

" ================ Indentation ======================
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab " Tabs are spaces
set smarttab " Inserts blanks in front of line according to shiftwidth
set autoindent

" ================ Navigation ========================
set splitbelow " Open new split panes below
set splitright " Open new split panes to right
set switchbuf=usetab " If a buffer is open in another tab, go to that instead of editing in current tab

" ================ Syntax ===========================
syntax on
filetype indent on
filetype plugin on
let g:jsx_ext_required = 0 " Allow JSX in normal JS files, used with vim-jsx plugin
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_python_python_exec = '/usr/local/bin/python3.5' " requires flake8 install
let g:syntastic_python_flake8_args = '--ignore=E501 --exclude=.tox' " ignore line length flake8 check

" Override eslint with local version where necessary. Requries npm install -g eslint
let local_eslint = finddir('node_modules', '') . '/.bin/eslint'
if matchstr(local_eslint, "^\/\\w") == ''
 let local_eslint = getcwd() . "/" . local_eslint
endif
if executable(local_eslint)
 let g:syntastic_javascript_eslint_exec = local_eslint
endif
let g:syntastic_always_populate_loc_list = 1 "  Stick any detected errors into the location-list (e.g. use :lprevious and :lnext)

" ================ Remap ============================
let mapleader=","
let maplocalleader="\\"
" remap split keys from ctrl+w+j to ctrl+j
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" quick save/exit
noremap <Leader>w :w<CR>
noremap <Leader>q :q<CR>
noremap <Leader>x :x<CR>
" Open file in same directory shortcuts
nnoremap <Leader>e :e <C-R>=expand('%:p:h') . '/'<CR>
" TEMP COMMENT OUT SO I DON'T USE TABS nnoremap <Leader>t :tabnew <C-R>=expand('%:p:h') . '/'<CR>
nnoremap <Leader>x :sp <C-R>=expand('%:p:h') . '/'<CR>
nnoremap <Leader>v :vs <C-R>=expand('%:p:h') . '/'<CR>
" Un-highlight highlighted words
nmap <silent> <leader>/ :silent :nohlsearch<CR>
" Copy paragraph and paste below
noremap cp yap<S-}>p
" This mapping makes macros even easier to remember: hit qq to record, q to stop recording, and Q to apply.
" This mapping also allows you to play macros across a visual selection with Q.
nnoremap Q @q
vnoremap Q :norm @q<cr>
" Go to explorer with '-'
nnoremap - :Ex<cr>

" ================ Ack ==============================
" use ack instead of grep
set grepprg=ack
let g:ackprg = 'ag --nogroup --nocolor --column --ignore migrations --ignore node_modules' " Use ag instead of ack
" leader-e to edit in current dir
map <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
" leader-a to :Ack!
map <Leader>a :Ack!
" leader-s to :Ack! current buffer dir
" map <Leader>s :Ack! <C-R>=expand("%:p:h")<CR>
" HG BLAME
noremap <Leader>h :HGblame<CR>

" ================ Ctrl-P ============================
set runtimepath^=~/.vim/bundle/ctrlp.vim
" For use with git: let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
nnoremap <leader>z :CtrlPBuffer<CR>

let g:ctrlp_use_caching = 0
let g:ctrlp_working_path_mode = 'r' " open ctrlp in repository directory, set to blank to open in dir of current file
let g:ctrlp_user_command = 'ag %s -i --nocolor --nogroup --hidden
      \ --ignore .git
      \ --ignore .svn
      \ --ignore .hg
      \ --ignore .DS_Store
      \ --ignore "**/*.pyc"
      \ -g ""'
set wildignore+=*.pyc

" ================ FZF Experimental settings ========
noremap <Leader>b :Buffers<CR>
noremap <Leader>m :Marks<CR>
noremap <Leader>a :Ag!
noremap <Leader>g :call fzf#run({'source': 'ag -g ""'})<CR>
noremap <Leader>f :Files<CR>
" let g:fzf_files_options = '--preview "cat {} 2> /dev/null | head -'.&lines.'"'    " But doesn't use source
" let g:fzf_files_options = '--preview "cat {} 2> /dev/null | head -'.&lines.'"'    " But doesn't use source

autocmd VimEnter * command! -bang -nargs=* Ag
\    call fzf#vim#ag(<q-args>,
\       <bang>0 ? fzf#vim#with_preview('up:60%')
\      : fzf#vim#with_preview('right:50%:hidden', '?'),
\       <bang>0)

" ================ Explorer =========================
let g:netrw_list_hide= '\.s.*,.*\.swp$,.*\.swp\s,.pyc$,.pyc\s,.*\.swo$,.*\.swo\s' " Cycle with 'a'
let g:netrw_liststyle = 1 " Tree-like explorer (cycle through with 'i')
let g:netrw_banner = 0 " Remove banner (cycle through with 'I')

" ================ Autocommands ======================
" Strip whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" ================ Helpers ===========================
:autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
:autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>

" trial stuff
" dsfkfdkfdksfkds_dfsfdskfld_fdsfsd
"                   ^ da_
" dsfkfdkfdksfkdsfdsfsd
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`' ]
    execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
    execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
    execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
    execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

set directory=~/.vimbackup//
set backupdir=~/.vimbackup//
