" =============================================================================
" Lance's vimrc — Vim 9.x, managed by vim-plug
" Install: ./setup.sh   (or open vim once; vim-plug bootstraps itself)
" =============================================================================

set shell=/bin/bash
set encoding=utf-8
scriptencoding utf-8

" Leader must be defined before any <Leader> mapping.
let mapleader = "\<Space>"

" Completion engine: 'coc' (default, LSP via coc.nvim) or 'ycm' (YouCompleteMe).
" Override per shell with:  VIM_COMPLETION=ycm vim
let g:completion_engine = empty($VIM_COMPLETION) ? 'coc' : $VIM_COMPLETION
let s:use_coc = g:completion_engine ==# 'coc'

" -----------------------------------------------------------------------------
" vim-plug bootstrap
" -----------------------------------------------------------------------------
let s:vim_home = has('win32') ? expand('~/vimfiles') : expand('~/.vim')
let s:plug_file = s:vim_home . '/autoload/plug.vim'
if empty(glob(s:plug_file))
  silent execute '!curl -fLo ' . shellescape(s:plug_file) . ' --create-dirs '
        \ . 'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  augroup plug_bootstrap
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
endif

" Built-in optional packages shipped with Vim 9.
packadd! matchit
packadd! editorconfig

" -----------------------------------------------------------------------------
" Plugins
" -----------------------------------------------------------------------------
call plug#begin(s:vim_home . '/plugged')

" Editing
Plug 'terryma/vim-expand-region'
Plug 'Raimondi/delimitMate'
Plug 'mg979/vim-visual-multi', { 'branch': 'master' }   " replaces vim-multiple-cursors
Plug 'mbbill/undotree', { 'on': 'UndotreeToggle' }
Plug 'preservim/nerdcommenter'
Plug 'bronson/vim-trailing-whitespace'

" Linting / completion / snippets
Plug 'dense-analysis/ale'                               " replaces syntastic
if s:use_coc
  Plug 'neoclide/coc.nvim', { 'branch': 'release' }    " needs Node.js >= 22.15
else
  Plug 'ycm-core/YouCompleteMe', { 'do': 'python3 install.py --go-completer' }
  Plug 'SirVer/ultisnips'
endif
Plug 'honza/vim-snippets'                               " used by coc-snippets and UltiSnips

" Languages
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'mattn/emmet-vim'
Plug 'pearofducks/ansible-vim'                          " replaces chase/vim-ansible-yaml

" Git
Plug 'tpope/vim-fugitive'
Plug 'christoomey/vim-conflicted'

" Navigation / UI
Plug 'preservim/nerdtree'
Plug 'preservim/tagbar', { 'on': 'TagbarToggle' }
Plug 'ctrlpvim/ctrlp.vim'                               " maintained fork of kien/ctrlp.vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Colorscheme (previously a git submodule)
Plug 'tomasr/molokai'

" plug#end() also runs `filetype plugin indent on` and `syntax enable`.
call plug#end()

" -----------------------------------------------------------------------------
" General options
" -----------------------------------------------------------------------------
set tabstop=4
set shiftwidth=4
set backspace=indent,eol,start
set hidden                  " switch buffers without saving first
set number
set cursorline
set ruler
set showcmd
set scrolloff=3
set laststatus=2
set history=1000
set hlsearch
set incsearch
set ignorecase
set smartcase               " case-sensitive when the pattern has uppercase
set showmatch
set wrap
set linebreak
set nolist
set autoread
set wildmenu
set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.idea/*,*/.DS_Store,*/vendor
set updatetime=300
set signcolumn=yes          " keep gutter stable for ALE/YCM signs

" No backup/swap files; keep persistent undo instead (pairs with undotree).
set nobackup
set nowritebackup
set noswapfile
let s:undo_dir = s:vim_home . '/undo'
if !isdirectory(s:undo_dir)
  call mkdir(s:undo_dir, 'p', 0700)
endif
let &undodir = s:undo_dir
set undofile

set guifont=Menlo\ for\ Powerline

" -----------------------------------------------------------------------------
" Colors
" -----------------------------------------------------------------------------
if has('termguicolors') && ($COLORTERM ==# 'truecolor' || $COLORTERM ==# '24bit')
  set termguicolors
endif
set background=dark
let g:molokai_original = 1
let g:rehash256 = 1
silent! colorscheme molokai

augroup user_ui
  autocmd!
  autocmd ColorScheme,VimEnter * highlight CursorLine cterm=underline
  " Restore the last cursor position when reopening a file.
  autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line('$') && &filetype !~# 'commit'
        \ |   execute "normal! g`\""
        \ | endif
augroup END

" -----------------------------------------------------------------------------
" Plugin settings
" -----------------------------------------------------------------------------

" delimitMate
let delimitMate_expand_cr = 2

" undotree
nnoremap <F5> :UndotreeToggle<CR>

" ALE (replaces syntastic). coc/YCM own LSP, so ALE only runs linters;
" coc forwards its diagnostics to ALE (see coc-settings.json) for one list.
let g:ale_disable_lsp = 1
let g:ale_set_loclist = 1
let g:ale_open_list = 1
let g:ale_lint_on_text_changed = 'normal'
let g:ale_linters = { 'go': ['govet', 'golangci-lint'] }
let g:airline#extensions#ale#enabled = 1

" Completion engine settings (coc or YCM); setup.sh copies this file into ~/.vim.
let s:completion_file = s:vim_home . '/completion.vim'
if filereadable(s:completion_file)
  execute 'source' fnameescape(s:completion_file)
else
  echohl WarningMsg
  echomsg 'completion.vim not found in ' . s:vim_home . ' — run setup.sh'
  echohl None
endif

" NERDCommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDAltDelims_java = 1
let g:NERDCustomDelimiters = { 'c': { 'left': '/**', 'right': '*/' } }
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1

" NERDTree
nnoremap <F2> :NERDTreeToggle<CR>
nnoremap <Leader>n :NERDTreeFocus<CR>
nnoremap <Leader>f :NERDTreeFind<CR>
augroup user_nerdtree
  autocmd!
  " Open NERDTree when vim starts without file arguments.
  autocmd StdinReadPre * let s:std_in = 1
  autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
  " `vim <dir>`: NERDTree would show the dir as a window tree in the main window,
  " which opening a file replaces. Use a sidebar tree + empty buffer instead.
  autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in')
        \ | execute 'NERDTree' fnameescape(argv()[0]) | wincmd p | enew
        \ | execute 'cd' fnameescape(argv()[0]) | endif
  " Quit when NERDTree is the only window left (Vim 9: :quit not allowed in autocmd).
  autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree()
        \ | call feedkeys(":quit\<CR>:\<BS>") | endif
augroup END

" Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1

" Tagbar (needs universal-ctags; gotags is used for Go when installed)
nnoremap <F8> :TagbarToggle<CR>
if executable('gotags')
  let g:tagbar_type_go = {
        \ 'ctagstype' : 'go',
        \ 'kinds'     : [
        \   'p:package', 'i:imports:1', 'c:constants', 'v:variables',
        \   't:types', 'n:interfaces', 'w:fields', 'e:embedded',
        \   'm:methods', 'r:constructor', 'f:functions'
        \ ],
        \ 'sro'        : '.',
        \ 'kind2scope' : { 't' : 'ctype', 'n' : 'ntype' },
        \ 'scope2kind' : { 'ctype' : 't', 'ntype' : 'n' },
        \ 'ctagsbin'   : 'gotags',
        \ 'ctagsargs'  : '-sort -silent'
        \ }
endif

" CtrlP — list files via git (respects .gitignore, much faster) in git repos.
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
nnoremap <Leader>o :CtrlP<CR>

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" -----------------------------------------------------------------------------
" Go (vim-go)
" -----------------------------------------------------------------------------
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_fields = 1
let g:go_highlight_types = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_list_type = 'quickfix'
let g:go_fmt_command = 'goimports'

" Make `go install`-ed tools (gopls, goimports, golangci-lint…) visible.
if executable('go')
  let s:gopath = trim(system('go env GOPATH'))
  if v:shell_error == 0 && !empty(s:gopath) && stridx($PATH, s:gopath . '/bin') < 0
    let $PATH = s:gopath . '/bin:' . $PATH
  endif
endif

augroup user_go
  autocmd!
  autocmd FileType go nmap <buffer> <Leader>r <Plug>(go-run)
  autocmd FileType go nmap <buffer> <Leader>b <Plug>(go-build)
  autocmd FileType go nmap <buffer> <Leader>t <Plug>(go-test)
  autocmd FileType go nmap <buffer> <Leader>c <Plug>(go-coverage)
  autocmd FileType go nmap <buffer> <Leader>ds <Plug>(go-def-split)
  autocmd FileType go nmap <buffer> <Leader>dv <Plug>(go-def-vertical)
  autocmd FileType go nmap <buffer> <Leader>dt <Plug>(go-def-tab)
  autocmd FileType go nmap <buffer> <Leader>gd <Plug>(go-doc)
  autocmd FileType go nmap <buffer> <Leader>gv <Plug>(go-doc-vertical)
  autocmd FileType go nmap <buffer> <Leader>gb <Plug>(go-doc-browser)
  autocmd FileType go nmap <buffer> <Leader>s <Plug>(go-implements)
  autocmd FileType go nmap <buffer> <Leader>i <Plug>(go-info)
  autocmd FileType go nmap <buffer> <Leader>e <Plug>(go-rename)
  autocmd FileType go nnoremap <buffer> <silent> gr :GoRename<CR>
  autocmd FileType go nnoremap <buffer> <silent> gf :GoReferrers<CR>
augroup END

" -----------------------------------------------------------------------------
" Key mappings
" -----------------------------------------------------------------------------
nmap <F3> <C-w>
nnoremap <C-z> :resize +1<CR>
nnoremap <C-c> :resize -1<CR>

nnoremap <Leader>w :w<CR>
nnoremap <Leader>q :q<CR>
nnoremap <Leader>wa :wa<CR>
nnoremap <Leader>x :x<CR>
vnoremap <Leader>y "+y
vnoremap <Leader>d "+d
nnoremap <Leader>P "+P
vnoremap <Leader>P "+P

nnoremap <Leader>l :bnext<CR>
nnoremap <Leader>h :bprevious<CR>
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>tc :tabclose<CR>

nmap <Leader><Leader> V

" `s` in visual mode: extend selection to the end of the next search match.
vnoremap <silent> s //e<C-r>=&selection=='exclusive'?'+1':''<CR><CR>
      \:<C-u>call histdel('search',-1)<Bar>let @/=histget('search',-1)<CR>gv
omap s :normal vs<CR>

" Fugitive (:Gdiff / :Gblame were removed upstream)
nnoremap <Leader>Gd :Gdiffsplit<CR>
nnoremap <Leader>Gb :Git blame<CR>
