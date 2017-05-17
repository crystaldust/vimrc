set shell=/bin/bash
set nocompatible              " be iMproved, required
filetype off                  " required
set guifont=Menlo\ for\ Powerline

set tabstop=4
set shiftwidth=4

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'terryma/vim-expand-region'

Plugin 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" let g:syntastic_go_checkers = ['golint', 'govet', 'errcheck']
" let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': ['go'] }
let g:syntastic_go_checkers = ['govet', 'errcheck']
let g:syntastic_mode_map = { 'mode': 'active', 'passive_filetypes': [] }
let g:go_list_type = "quickfix"

Plugin 'raimondi/delimitmate'
let delimitMate_expand_cr = 2

Plugin 'terryma/vim-multiple-cursors'

Plugin 'mbbill/undotree'
nnoremap <F5> :UndotreeToggle<cr>

Plugin 'mattn/emmet-vim'
Bundle 'chase/vim-ansible-yaml'
Bundle 'tpope/vim-fugitive'

Bundle 'christoomey/vim-conflicted'
" set stl+=%{ConflictedVersion()}

Bundle 'bronson/vim-trailing-whitespace'

Plugin 'fatih/vim-go'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let $GOPATH="/home/lance/go"
let $PATH=$GOPATH.$PATH
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>c <Plug>(go-coverage)

au FileType go nmap <Leader>ds <Plug>(go-def-split)
au FileType go nmap <Leader>dv <Plug>(go-def-vertical)
au FileType go nmap <Leader>dt <Plug>(go-def-tab)

au FileType go nmap <Leader>gd <Plug>(go-doc)
au FileType go nmap <Leader>gv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>gb <Plug>(go-doc-browser)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>i <Plug>(go-info)
au FileType go nmap <Leader>e <Plug>(go-rename)


Plugin 'Valloric/YouCompleteMe'

" Track the engine.
Plugin 'SirVer/ultisnips'

" Snippets are separated from the engine. Add this if you want them:
Plugin 'honza/vim-snippets'

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

let g:ycm_key_list_select_completion = ['<c-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<c-p>', '<Up>']

Plugin 'scrooloose/nerdcommenter'
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

Plugin 'scrooloose/nerdtree'
nmap <F2> :NERDTreeToggle<CR>

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

" Powerline settings
"set g:airline_powerline_fonts = 1

if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif

"nnoremap <s-pageup> :bprevious<CR>
" nnoremap <s-tab> :bnext<CR>
" nnoremap <a-s-tab> :bprevious<CR>
"

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.linenr = '␊'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.maxlinenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.spell = 'Ꞩ'
let g:airline_symbols.notexists = '∄'
let g:airline_symbols.whitespace = 'Ξ'

" powerline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''

" old vim-powerline symbols
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.readonly = '⭤'
let g:airline_symbols.linenr = '⭡'

" Plugin 'vim-airline/vim-airline'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = '⮀'
let g:airline#extensions#tabline#left_alt_sep = '⮁'

Plugin 'majutsushi/tagbar'
nmap <F8> :TagbarToggle<CR>
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
\ }

Plugin 'kien/ctrlp.vim'
" let g:ctrlp_custom_ignore = '\v[\/]\.(vendor\/)$'
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/vendor
" let g:ctrlp_custom_ignore = {
"   \ 'dir':  '\v[\/]\.(git|log|vendor)$',
"   \ }

" \ 'file': '\v\.(exe|so|dll)$',
" \ 'link': 'some_bad_symbolic_links',

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

syntax enable
filetype plugin on
set number
let g:go_disable_autoinstall = 0


set t_Co=256
let g:solarized_termcolors=256
set background=dark
" colorscheme solarized
colorscheme molokai
" colorscheme contrastneed
let g:molokai_original = 1
let g:rehash256 = 1
"
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

set cul "高亮光标所在行
" autocmd InsertEnter * highlight CursorLine guibg=#000050 guifg=fg
autocmd VimEnter * highlight CursorLine cterm=underline
" set cuc
" set shortmess=atI   " 启动的时候不显示那个援助乌干达儿童的提示
" autocmd InsertEnter * se cul    " 用浅色高亮当前行  
set ruler           " 显示标尺  
set showcmd         " 输入的命令显示出来，看的清楚些  
set scrolloff=3     " 光标移动到buffer的顶部和底部时保持3行距离  
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容  
set laststatus=2    " 启动显示状态行(1),总是显示状态行(2)  

" 历史记录数
set history=1000
"搜索逐字符高亮
set hlsearch
set incsearch

"当打开vim且没有文件时自动打开NERDTree
autocmd vimenter * if !argc() | NERDTree | endif
" 只剩 NERDTree时自动关闭
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
" 设置当文件被改动时自动载入
set autoread

"禁止生成临时文件
set nobackup
set noswapfile
"搜索忽略大小写
set ignorecase

" 高亮显示匹配的括号
set showmatch

" 不自动换行
set nowrap


nmap <buffer> <silent> gr :GoRename<cr>
nmap <buffer> <silent> gf :GoReferrers<cr>

"nmap <F3>a <ESC><C-w>>
"nmap <F3>d <ESC><C-w><

nmap <F3> <C-w>
"map <F3> <C-w>

"nmap <C-a> <ESC><C-w>>
"nmap <C-d> <ESC><C-w><
"map <C-a> <ESC><C-w>>
"map <C-d> <ESC><C-w><

nmap <C-z> <ESC>:res+1<CR>
nmap <C-c> <ESC>:res-1<CR>
"map <C-z> <ESC>:res+1<CR>
"map <C-c> <ESC>:res-1<CR>

"第一次执行请执行这两个冒号空间命令，之后删除
"PluginInstall
"GoInstallBinaries 
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

nmap <F12> :YcmCompleter GoToDefinition<CR>
nmap <F10> :YcmCompleter GoToDeclaration<CR>

let g:go_fmt_command = "goimports"

set wrap
set linebreak
set nolist 

"let mapleader=","
let mapleader = "\<Space>"
nnoremap <Leader>o :CtrlP<CR>
nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wa :wa<CR>
nnoremap <Leader>x :x<CR>
vmap <Leader>y "+y
vmap <Leader>d "+d
" nmap <Leader>p "+p
nmap <Leader>P "+P
" vmap <Leader>p "+p
vmap <Leader>P "+P

nnoremap <Leader>l :bnext <CR>
nnoremap <Leader>h :bprevious<CR>
" nnoremap <Leader>N :bprevious<CR>

nmap <Leader><Leader> V
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
    \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>




nnoremap <Leader>tn :tabnew <CR>
nnoremap <Leader>tc :tabclose<CR>

nnoremap <Leader>Gd :Gdiff <CR>
nnoremap <Leader>Gb :Gblame <CR>
