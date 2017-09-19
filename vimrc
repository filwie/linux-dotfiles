" ========  VUNDLE CONFIG ========
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" -------- PLUGINS --------

" vundle - plugin manager
Plugin 'VundleVim/Vundle.vim'

" directory tree
Plugin 'scrooloose/nerdtree'

" icons for nerdtree
Plugin 'ryanoasis/vim-devicons'

" airline statusline with themes
Plugin 'itchyny/lightline.vim'

" silver searcher
Plugin 'rking/ag.vim'

" tagbar showing classes/functions/variables etc - requires exuberant-ctags
Plugin 'majutsushi/tagbar'

" buffer explorer - tablike plugin for vim buffers
" Plugin 'fholgado/minibufexpl.vim'
Plugin 'taohex/lightline-buffer'

" Completion engine plugin for Python
Plugin 'Valloric/YouCompleteMe'


" removes trailing whitespaces
Plugin 'bronson/vim-trailing-whitespace'

" ------- /PLUGINS --------
call vundle#end()            " required
filetype plugin indent on    " required
" ======= /VUNDLE CONFIG ========


" -------- NERDTREE CONFIG --------
map <C-n> :NERDTreeToggle<CR>
" open NERDTree if vim starts up with no specified file:
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
    call webdevicons#refresh()
endif
" ------- /NERDTREE CONFIG --------


" -------- LIGHTLINE CONFIG --------
set hidden  " allow buffer switching without saving
set showtabline=2  " always show tabline
set laststatus=2

let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ 'component_type': {
        \ 'buffercurrent': 'tabsel',
        \ },
    \ 'component_function': {
        \ 'bufferbefore': 'lightline#buffer#bufferbefore',
        \ 'bufferafter': 'lightline#buffer#bufferafter',
        \ 'bufferinfo': 'lightline#buffer#bufferinfo',
        \ },
    \ }

" lightline-buffer ui settings
" replace these symbols with ascii characters if your environment does not
" support unicode
let g:lightline_buffer_logo = ' '
let g:lightline_buffer_readonly_icon = ''
let g:lightline_buffer_modified_icon = '✭'
let g:lightline_buffer_git_icon = ' '
let g:lightline_buffer_ellipsis_icon = '..'
let g:lightline_buffer_expand_left_icon = '◀ '
let g:lightline_buffer_expand_right_icon = ' ▶'
let g:lightline_buffer_active_buffer_left_icon = ''
let g:lightline_buffer_active_buffer_right_icon = ''
let g:lightline_buffer_separator_icon = '%'

" lightline-buffer function settings
let g:lightline_buffer_show_bufnr = 1
let g:lightline_buffer_rotate = 0
let g:lightline_buffer_fname_mod = ':t'
let g:lightline_buffer_excludes = ['vimfiler']

let g:lightline_buffer_maxflen = 30
let g:lightline_buffer_maxfextlen = 3
let g:lightline_buffer_minflen = 16
let g:lightline_buffer_minfextlen = 3
let g:lightline_buffer_reservelen = 20
" ------- /LIGHTLINE CONFIG --------



" -------- TAGBAR CONFIG --------
map <F8> :TagbarToggle<CR>
" ------- /TAGBAR CONFIG --------


" -------- MINIBUFFER CONFIG --------
" map <C-B> :MBEToggle<CR>
" -----------------------------------


" -------- AG CONFIG --------
let g:unite_source_history_yank_enable = 1
try
  let g:unite_source_rec_async_command='ag --nocolor --nogroup -g ""'
  call unite#filters#matcher_default#use(['matcher_fuzzy'])
catch
endtry
" search a file in the filetree
nnoremap <space><space> :split<cr> :<C-u>Unite -start-insert file_rec/async<cr>
" reset not it is <C-l> normally
:nnoremap <space>r <Plug>(unite_restart)
" ------- /AG CONFIG --------


" ======== OTHER CONFIG ========

" mark 80th column with different color depending on mode (INSERT/NORMAL)
" highlight ColorColumn ctermbg=2
" if (exists('+colorcolumn'))
" set colorcolumn=80
" au InsertEnter * highlight ColorColumn ctermbg=3
"     au InsertLeave * highlight ColorColumn ctermbg=2
" endif

" 4 spaces instead of a tab
:set tabstop=4 shiftwidth=4 expandtab

" 256 terminal colours:
:set t_Co=256


" display line numbers
set number
" colorize sytanx
syntax on
" set text encoding to UTF8
set encoding=utf8
" set indent depending on file type
filetype plugin indent on
filetype plugin on
" make backspace work like most other apps
set backspace=2
" vsplit opens second file on the right instead of left
set splitright


