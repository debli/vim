set cino=(0
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=10000         " How many undos
set undoreload=10000
set hlsearch

set fileencodings=utf-8,gbk
set number

if has("autocmd") 
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set showcmd        " Show (partial) command in status line.                                                  
set showmatch      " Show matching brackets.                                                                 
set ignorecase     " Do case insensitive matching                                                            
set smartcase      " Do smart case matching                                                                  
set incsearch      " Incremental search      

set exrc
set secure
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set colorcolumn=100
set mouse=a
highlight ColorColumn ctermbg=darkgray
nnoremap <F4> :make!<cr>

autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

set nocompatible              " be iMproved, required
"filetype off                  " required


" Make sure you use single quotes
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'

" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
Plugin 'junegunn/vim-easy-align'

" Any valid git URL is allowed
"Plug 'https://github.com/junegunn/vim-github-dashboard.git'

" Multiple Plug commands can be written in a single line using | separators
"Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'

" On-demand loading
Plugin 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plugin 'Xuyuanp/nerdtree-git-plugin'

Plugin 'ternjs/tern_for_vim'

"Plug 'tpope/vim-fireplace', { 'for': 'clojure' }


Plugin 'majutsushi/tagbar'
Plugin 'Shougo/denite.nvim'

" Using a non-master branch
"Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }

" Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
"Plug 'fatih/vim-go', { 'tag': '*' }

" Plugin options
"Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }

" Plugin outside ~/.vim/plugged with post-update hook
Plugin 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plugin 'Valloric/YouCompleteMe'

"Plug 'vim-syntastic/syntastic'
Plugin 'w0rp/ale'

" Unmanaged plugin (manually installed and updated)
"Plug '~/my-prototype-plugin'

" Initialize plugin system
call vundle#end()            " required

filetype plugin indent on    " required

xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

let g:nerdtree_tabs_open_on_console_startup=1
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"map <F9> :NERDTreeToggle<CR>
"nmap <F8> :TagbarToggle<CR>
map <F9> :Denite file_rec<CR>

let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
map <F2> :TernDef<CR>

let g:airline#extensions#ale#enabled = 1

function! LinterStatus() abort
    let l:counts = ale#statusline#Count(bufnr(''))

    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors

    return l:counts.total == 0 ? 'OK' : printf(
    \   '%dW %dE',
    \   all_non_errors,
    \   all_errors
    \)
endfunction


set statusline=%{LinterStatus()}

let g:ale_sign_column_always = 1
let g:ale_set_highlights = 0
"自定义error和warning图标
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚡'
"在vim自带的状态栏中整合ale
let g:ale_statusline_format = ['✗ %d', '⚡ %d', '✔ OK']
"显示Linter名称,出错或警告等相关信息
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
"普通模式下，sp前往上一个错误或警告，sn前往下一个错误或警告
nmap sp <Plug>(ale_previous_wrap)
nmap sn <Plug>(ale_next_wrap)
"<Leader>s触发/关闭语法检查
nmap <F4> :ALEToggle<CR>
"<Leader>d查看错误或警告的详细信息
nmap <Leader>d :ALEDetail<CR>
let g:ale_lint_on_enter = 1
let g:ale_emit_conflict_warnings = 0

let g:ale_lint_on_text_changed = "always"
let NERDTreeQuitOnOpen=0

let g:ycm_auto_trigger = 1
set completeopt=longest,menu
"let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_global_ycm_extra_conf='~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'
let g:ycm_key_invoke_completion = '<C-a>'
nnoremap <F3> :YcmCompleter GoToDefinitionElseDeclaration<CR>
let g:ycm_add_preview_to_completeopt = 1
syntax on
"let g:deoplete#enable_at_startup = 1
