" Goal: << 200 lines
" Forgot why this shell line was necessary??
" set shell=/bin/sh " while using fish
set nocompatible

" =============== Plugin Initialization ==============
" First run: $ curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" Install new plugins: :PlugInstall
call plug#begin('~/.vim/plugged')

" Theme
Plug 'jnurmine/Zenburn'
Plug 'sickill/vim-monokai'
" temporarily try nord
set termguicolors
Plug 'jcypret/nord-vim-midnight'

" File plugins
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-fugitive'            " Handy Git integration
Plug 'shumphrey/fugitive-gitlab.vim' " Allows GitLab urls in vim-fugitive
Plug 'tpope/vim-rhubarb'             " Allows GitHub urls in vim-fugitive
Plug 'junegunn/gv.vim'               " `:GV` (commits), `GV!` (current file), `GV?` (loc list current file!)

" Motion plugins
Plug 'tpope/vim-unimpaired'          " [<Space>, ]<Space> to add newlines and other handy bracket mappings
Plug 'tpope/vim-commentary'          " `gcc` comments out a line, `gcap`, etc.
Plug 'junegunn/vim-easy-align'       " Align text around `=`, markdown tables, etc.

" Movement plugins
" Plug 'knubie/vim-kitty-navigator', {'do': 'cp ./*.py ~/.config/kitty/'} " allow seamless navigation between kitty and vim splits

" Syntax plugins
Plug 'w0rp/ale'                      " better than syntastic (async)
Plug 'hynek/vim-python-pep8-indent'  " python indentation per pep8
Plug 'pangloss/vim-javascript'       " better js syntax and highlighting
Plug 'maxmellon/vim-jsx-pretty'      " better jsx syntax and indentation
Plug 'exu/pgsql.vim'
let g:sql_type_default = 'pgsql'
Plug 'raimon49/requirements.txt.vim'

" Trial plugins
Plug 'junegunn/seoul256.vim'         " try it
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
" silent! colorscheme zenburn    " formerly: wombat256. `silent!` is b/c this colorscheme is installed via vim-plug, which must run with the vimrc loaded before the colorscheme is loaded
" seoul256 is like zenburn but with some different contrasts. Lots of nice
" features. Test when have time. However, maybe too low contrast.
silent! colorscheme zenburn " Rotation: seoul256, zenburn, monokai
let g:seoul256_background = 234

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
let &t_ut=''                   " Turn off background-color erase so navigating VIM file results in sane VIM background.

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

set wildignore+=*.pyc

" ================ Remap ============================
nnoremap <SPACE> <Nop>
let mapleader=" "
let maplocalleader="\\"
" remap split keys from ctrl+w+j to ctrl+j. required if not using kitty or tmux navigator plugin.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
" quick save/exit
noremap <Leader>w :w<CR>
noremap <Leader>q :q<CR>
noremap <Leader>x :x<CR>
" Lexplore 25% width
noremap <Leader>er :Lexplore 25<CR>
" Lexplore 25% width current dir
noremap <Leader>ed :Lexplore 25 <C-r>=expand('%:p:h')<CR><CR>
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
" ALE isort quickfix
let g:ale_python_isort_options = ''
augroup your_group
  autocmd!
  autocmd FileType python noremap <Leader>i :ALEFix isort<CR>
  autocmd FileType javascript,javascriptreact noremap <Leader>i :ALEFix prettier<CR>
augroup END

" ================ Git Plugins ==================
noremap <Leader>g :Git blame<CR>
let g:fugitive_gitlab_domains = [$GITLAB_URL]

" ================ FZF settings ========
" Reminder old fzf settings for use with git: let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files . -co --exclude-standard', 'find %s -type f']
" Shortcuts to fzf commands. `!` denotes fullsreen.
noremap <Leader>b :Buffers<CR>
noremap <Leader>m :Marks!<CR>
noremap <Leader>a :Ag!
noremap <Leader>f :Files!<CR>
noremap <Leader>n :Notes!<CR>
" Git status
noremap <Leader>gs :GFiles?<CR>
" Git log
noremap <Leader>gl :Commits!<CR>
noremap <Leader>h :History:<CR>
command! -bang Notes call fzf#vim#files('~/notes', {'source': 'fd --type file -X ls -dt', 'options': [
    \ '--preview=mdcat {}',
    \ '--bind=ctrl-d:execute-silent(rm {})+reload(sh -c "$FZF_DEFAULT_COMMAND")',
    \ '--bind=ctrl-s:execute-silent(sh -c "rtouch {q}")+reload(sh -c "$FZF_DEFAULT_COMMAND")',
    \ '--bind=ctrl-n:preview-half-page-up',
    \ '--bind=ctrl-p:preview-half-page-down',
    \ '--header=<note name> -> ctrl+s creates new note',
    \ '--header-first'
    \ ]}, <bang>0)

" Mostly for highlight: Nontext, which sets the overal popup window border as
" more subtle (highlight groups: `:so $VIMRUNTIME/syntax/hitest.vim`)
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'Nontext' } }
" default preview window to larger than 50%
let g:fzf_preview_window = ['up:70%', 'ctrl-/']
" let g:fzf_layout = { 'down': '40%' } " use location window, not popup

" Cool thing that allows me to put fzf results in a quickfix list, which
" helps things like renaming func's.
" CTRL-A CTRL-Q to select all and build quickfix list
function! s:build_quickfix_list(lines)
  call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
  copen
  cc
endfunction
let g:fzf_action = {
  \ 'ctrl-q': function('s:build_quickfix_list'),
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" ================ Explorer =========================
let g:netrw_list_hide= netrw_gitignore#Hide() " Use .gitignore for ignored files; cycle through w/ `a`
let g:netrw_liststyle = 0                     " Tree-like explorer (cycle through with 'i'). thin/long/tree 0/1/3
let g:netrw_banner = 0                        " Remove banner (cycle through with 'I')
" let g:netrw_sort_options = 'i'              " Ignore case in sort
" '?' calls netrw key mappings
autocmd FileType netrw nnoremap ? :help netrw-quickmap<CR>
" Have to map NetrwRefresh explicitly otherwise it'll map to <C-L> which I
" want
nmap <unique> <C-P> <Plug>NetrwRefresh

" ================ Autocommands ======================
autocmd BufWritePre * :%s/\s\+$//e   " Strip whitespace on save
autocmd FileType yaml,tf setlocal shiftwidth=2 tabstop=2 softtabstop=2

" ================ Helpers ===========================

" ================ Test Stuff ========================
" To not have ALE be constantly overwriting loclist or quickfix and be able to
" use for other purposes, have to map command to populate list only on demand
let g:ale_set_loclist = 0  " .e.g, gv.vim uses loclist
let g:ale_set_quickfix = 0 " e.g., CTRL-A CTRL-Q below uses quickfix
noremap <Leader>t :ALEPopulateLocList<CR>

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

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

" allow project-specific vimrc, e.g. `set path+=`
set exrc
set secure

"" ----------------------------------------------------------------------------
" Syntax highlighting in code snippets in markdown
" Courtesy of [junegunn](https://github.com/junegunn/dotfiles/blob/master/vimrc)
" ----------------------------------------------------------------------------
function! s:syntax_include(lang, b, e, inclusive)
  let syns = split(globpath(&rtp, "syntax/".a:lang.".vim"), "\n")
  if empty(syns)
    return
  endif

  if exists('b:current_syntax')
    let csyn = b:current_syntax
    unlet b:current_syntax
  endif

  let z = "'" " Default
  for nr in range(char2nr('a'), char2nr('z'))
    let char = nr2char(nr)
    if a:b !~ char && a:e !~ char
      let z = char
      break
    endif
  endfor

  silent! exec printf("syntax include @%s %s", a:lang, syns[0])
  if a:inclusive
    exec printf('syntax region %sSnip start=%s\(\)\(%s\)\@=%s ' .
                \ 'end=%s\(%s\)\@<=\(\)%s contains=@%s containedin=ALL',
                \ a:lang, z, a:b, z, z, a:e, z, a:lang)
  else
    exec printf('syntax region %sSnip matchgroup=Snip start=%s%s%s ' .
                \ 'end=%s%s%s contains=@%s containedin=ALL',
                \ a:lang, z, a:b, z, z, a:e, z, a:lang)
  endif

  if exists('csyn')
    let b:current_syntax = csyn
  endif
endfunction

function! s:markdown_handler()
  let map = { 'bash': 'sh' }
  for lang in ['html', 'ruby', 'yaml', 'vim', 'sh', 'bash', 'python', 'java', 'c', 'sql', 'gnuplot']
    call s:syntax_include(get(map, lang, lang), '```'.lang, '```', 0)
  endfor

  highlight def link Snip Folded

  setlocal textwidth=78
  setlocal completefunc=emoji#complete
endfunction

au FileType,ColorScheme markdown call <SID>markdown_handler()

" ============== Recycle Bin ==========================
" Empty!
"
"
