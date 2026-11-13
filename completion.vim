" Completion / LSP settings, sourced from vimrc.
" g:completion_engine is 'coc' (default) or 'ycm'.

if g:completion_engine ==# 'coc'
  " ---------------------------------------------------------------------------
  " coc.nvim — works on Vim >= 9.0.0438 and Neovim >= 0.8, needs Node.js
  " ---------------------------------------------------------------------------
  " coc reads ~/.vim/coc-settings.json (copied there by setup.sh).
  let g:coc_global_extensions = ['coc-go', 'coc-json', 'coc-yaml', 'coc-snippets']
  set shortmess+=c

  function! s:check_backspace() abort
    let l:col = col('.') - 1
    return !l:col || getline('.')[l:col - 1] =~# '\s'
  endfunction

  " Popup menu: <C-n>/<C-p> navigate, <C-y> confirm (coc defaults, same as YCM).
  " <Tab>: confirm popup / expand or jump snippet / insert a real tab.
  inoremap <silent><expr> <Tab>
        \ coc#pum#visible() ? coc#_select_confirm() :
        \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
        \ <SID>check_backspace() ? "\<Tab>" :
        \ coc#refresh()
  let g:coc_snippet_next = '<C-b>'
  let g:coc_snippet_prev = '<C-z>'

  nmap <silent> <F12> <Plug>(coc-definition)
  nmap <silent> <F10> <Plug>(coc-declaration)
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)
  nmap <F6> <Plug>(coc-rename)

  function! s:show_documentation() abort
    if CocAction('hasProvider', 'hover')
      call CocActionAsync('doHover')
    else
      call feedkeys('K', 'in')
    endif
  endfunction
  nnoremap <silent> K :call <SID>show_documentation()<CR>

  " Let coc (gopls) handle definition / completion / docs instead of vim-go.
  let g:go_def_mapping_enabled = 0
  let g:go_code_completion_enabled = 0
  let g:go_doc_keywordprg_enabled = 0
else
  " ---------------------------------------------------------------------------
  " YouCompleteMe + UltiSnips
  " ---------------------------------------------------------------------------
  let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
  let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
  nnoremap <F12> :YcmCompleter GoToDefinition<CR>
  nnoremap <F10> :YcmCompleter GoToDeclaration<CR>

  " <Tab> is safe for UltiSnips because YCM uses <C-n>/<C-p>.
  let g:UltiSnipsExpandTrigger = '<Tab>'
  let g:UltiSnipsJumpForwardTrigger = '<C-b>'
  let g:UltiSnipsJumpBackwardTrigger = '<C-z>'
  let g:UltiSnipsEditSplit = 'vertical'
endif
