" Goal: << 200 lines
set shell=/bin/sh " while using fish
set nocompatible

" =============== Plugin Initialization ==============
" First run: $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Install new plugins: :PlugInstall
call plug#begin('~/.vim/plugged')

" Theme
Plug 'jnurmine/Zenburn'

" File plugins
Plug 'mileszs/ack.vim'               " what's the use of this with fzf? primary difference seems the ability to keep the drawer open with :Ack!
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'            " Handy Git integration
Plug 'shumphrey/fugitive-gitlab.vim' " Allows GitLab urls in vim-fugitive
Plug 'junegunn/gv.vim'               " :GV (commits) and GV! (current file) and GV? (loc list current file!)

" Motion plugins
Plug 'tpope/vim-unimpaired'          " [<Space>, ]<Space> to add newlines and other handy bracket mappings
Plug 'tpope/vim-commentary'          " `gcc` comments out a line, `gcap`, etc.

" Movement plugins
Plug 'christoomey/vim-tmux-navigator' " allows seamless ctrl-j going from tmux split to vim split

" syntax plugins
Plug 'w0rp/ale'                      " better than syntastic (async)
Plug 'hynek/vim-python-pep8-indent'  " python indentation per pep8
Plug 'pangloss/vim-javascript'       " better js syntax and highlighting
Plug 'mxw/vim-jsx'                   " jsx syntax and highlighting

" trial plugins
Plug 'junegunn/vim-peekaboo'         " Peek at register when typing \" and @
Plug 'easymotion/vim-easymotion'     " of dubious utility
Plug 'kana/vim-textobj-user'         " required for custom text object plugins
Plug 'bps/vim-textobj-python'        " provides af/if/ac/ic for selecting classes and functions and [pf, ]pf, [pc, ]pc for next/previous function/class
Plug 'Chun-Yang/vim-textobj-chunk'   " provides generic ac/ic. presumably interferes with textobj-python
Plug 'tpope/vim-surround'            " looks extremely useful, once familiar add tpope's /vim-repeat
call plug#end()

" ================ General Config ====================
let &t_Co=256
let g:zenburn_high_Contrast=1
colorscheme zenburn            " formerly: wombat256
set colorcolumn=101            " line length indicator
set ruler                      " Column/row indicator in status bar
set number                     " Show columns on left
set relativenumber             " Show columns relative
set cursorline                 " Highlight current
set history=256                " Length of history
set laststatus=2               " Always show bottom status bar (filename, ruler, etc.)
set directory=~/.vimbackup//   " Change .swp files from being place in dir
" set the dictionary, which allows things like tab completion of dictionary words
set dictionary-=/usr/share/dict/words dictionary+=/usr/share/dict/words
set nofoldenable               " for vim-fugitive, which seems to fold by default :\

" ================ Search ===========================
set ignorecase " Case-insensitive except when using uppercase
set smartcase  " Case-insensitive except when using uppercase
set incsearch  " Move cursor to matched string when searching
set hlsearch   " Highlights matches
set hidden     " allow modified buffers to be hidden, without this warned if open new file in buffer without saving

" ================ Indentation ======================
set tabstop=4                  " Tab width
set shiftwidth=4               " Width for `>>`, `<<`, `==` commands and automatic indentation
set expandtab                  " Tabs are spaces
set softtabstop=4              " Tab is 4 spaces. Allows backspacing of tabs.
set backspace=indent,eol,start " Make backspace work
set autoindent

" ================ Navigation ========================
set splitbelow       " Open new split panes below
set splitright       " Open new split panes to right
set switchbuf=usetab " If a buffer is open in another tab, go to that instead of editing in current tab
set wildmenu         " Tab completion shows items available

" ================ Format ============================
set formatoptions+=j " Delete comment character when joining commented lines

" ================ Syntax ============================
" Better `:set list` format
set list
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif

filetype on
syntax on
filetype indent on
filetype plugin on
let g:jsx_ext_required = 0 " Allow JSX in normal JS files, used with vim-jsx plugin
let g:ale_python_flake8_executable = 'python3.6'  " Requires flake8 install
let g:ale_python_flake8_options = '-m flake8 --ignore=E501'  " Requires flake8 install

set wildignore+=*.pyc

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
" Un-highlight highlighted words
nmap <silent> <leader>/ :silent :nohlsearch<CR>
" Copy paragraph and paste below
noremap cp yap}p
" This mapping makes macros even easier to remember: hit qq to record, q to stop recording, and Q to apply.
" This mapping also allows you to play macros across a visual selection with Q.
nnoremap Q @q
vnoremap Q :norm @q<cr>
" Go to explorer with '-'
nnoremap - :Ex<cr>
" Remape escape in terminal to do what it does in insert mode
tnoremap <ESC> <C-\><C-n>

" ================ Ack ==============================
set grepprg=ag\ --nogroup\ --nocolor
let g:ackprg = 'ag --nogroup --nocolor --column --ignore node_modules' " Use ag instead of ack

" ================ Git Plugins ==================
noremap <Leader>g :Gblame<CR>
let g:fugitive_gitlab_domains = [$GITLAB_URL]

" ================ FZF settings ========
" Code highlighting using rougify/pygmentize/etc is cool but too slow
"
" Reminder old fzf settings for use with git: let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
noremap <Leader>b :Buffers<CR>
noremap <Leader>m :Marks<CR>
noremap <Leader>a :Ag!
noremap <Leader>f :Files!<CR>

" Using `head` instead of `command!` version on fzf.vim readme is much faster.
let g:fzf_files_options = '--preview "tput setaf 7; head -'.&lines.' {}"'

" Ag command with preview window (for some reason slightly slower than above)
autocmd VimEnter * command! -bang -nargs=* Ag
\    call fzf#vim#ag(<q-args>,
\       <bang>0 ? fzf#vim#with_preview('up:60%')
\      : fzf#vim#with_preview('right:50%:hidden', '?'),
\       <bang>0)

" ================ Explorer =========================
" Can probably stop hiding swp/swo files now that I changed `directory`
let g:netrw_list_hide= '\.s.*,.pyc$,.pyc\s'   " Cycle with 'a'
let g:netrw_liststyle = 1                     " Tree-like explorer (cycle through with 'i')
let g:netrw_banner = 0                        " Remove banner (cycle through with 'I')

" ================ Autocommands ======================
autocmd BufWritePre * :%s/\s\+$//e   " Strip whitespace on save
autocmd FileType yaml setlocal shiftwidth=2 tabstop=2 softtabstop=2
" Override when individuals set `vim:ft=ansible` to files
autocmd FileType ansible setlocal syntax=yaml

" ================ Helpers ===========================
:autocmd FileType javascript nnoremap <buffer> <localleader>c I//<esc>
:autocmd FileType python     nnoremap <buffer> <localleader>c I#<esc>

" ================ Test Stuff ========================
let g:ale_set_loclist = 0  " required if I want to use gv.vim
let g:ale_set_quickfix = 1
" dsfkfdkfdksfkds_dfsfdskfld_fdsfsd
"                   ^ da_
" dsfkfdkfdksfkdsfdsfsd
" 1. Really T_dt_ would do the same thing. Consider that?
" 2. wellle/targets.vim looks promising
for char in [ '_', '.', ':', ',', ';', '<bar>', '/', '<bslash>', '*', '+', '%', '`' ]
    execute 'xnoremap i' . char . ' :<C-u>normal! T' . char . 'vt' . char . '<CR>'
    execute 'onoremap i' . char . ' :normal vi' . char . '<CR>'
    execute 'xnoremap a' . char . ' :<C-u>normal! F' . char . 'vf' . char . '<CR>'
    execute 'onoremap a' . char . ' :normal va' . char . '<CR>'
endfor

:autocmd FileType text,markdown setlocal complete+=k   " dictionary available for completion
:autocmd FileType netrw setlocal nolist                " list is awful in netrw

" CTRL-A CTRL-Q to select all and build quickfix list
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction

" Weird thing that allows me to put fzf results in a quickfix list, which
" helps things like renaming func's
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" ============== Recycle Bin ==========================
" Empty!
