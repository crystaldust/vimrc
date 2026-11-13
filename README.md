# vimrc

Personal Vim 9.x configuration, managed by [vim-plug](https://github.com/junegunn/vim-plug).

## Install

```bash
./setup.sh
```

The script backs up an existing `~/.vimrc`, symlinks this repo's `vimrc`, installs
vim-plug and runs `:PlugInstall`. Opening Vim without vim-plug present also bootstraps it.

External tools:

| Tool | Needed by | Install (macOS) |
|------|-----------|-----------------|
| `node` (>= 22.15) | coc.nvim (default completion) | `brew install node` |
| `cmake`, `python3` | YouCompleteMe build (only with `VIM_COMPLETION=ycm`) | `brew install cmake python` |
| `go` | vim-go, gopls | `brew install go` |
| `universal-ctags` | tagbar (macOS `/usr/bin/ctags` does not work) | `brew install universal-ctags` |
| `golangci-lint` | ALE Go linting | `brew install golangci-lint` |
| `gotags` (optional) | tagbar Go layout | `go install github.com/jstemmer/gotags@latest` |

After install, run `:GoUpdateBinaries` once inside Vim.

## Completion engine

Default is [coc.nvim](https://github.com/neoclide/coc.nvim) (supports Vim >= 9.0.0438
as well as Neovim, despite the name). Extensions `coc-go`, `coc-json`, `coc-yaml` and
`coc-snippets` are installed automatically; settings live in `coc-settings.json`.

YouCompleteMe + UltiSnips is kept as an alternative:

```bash
VIM_COMPLETION=ycm vim            # one-off
VIM_COMPLETION=ycm vim +PlugInstall   # first time: installs and builds YCM
```

Keys are the same in both modes: `<C-n>`/`<C-p>` select, `<Tab>` expands snippets,
`<C-b>`/`<C-z>` jump between placeholders, `<F12>`/`<F10>` go to definition/declaration.
coc adds `gd` `gy` `gi` `K` `[g` `]g` and `<F6>` (rename).

## Daily use

| Command | Purpose |
|---------|---------|
| `:PlugUpdate` | update plugins |
| `:PlugClean` | remove plugins no longer listed |
| `:PlugUpgrade` | update vim-plug itself |
| `:PlugSnapshot` | write a lockfile-like restore script |

## Migration notes (2026)

| Before | Status | Now |
|--------|--------|-----|
| Vundle | unmaintained | vim-plug |
| scrooloose/syntastic | archived; author points to ALE | dense-analysis/ale |
| terryma/vim-multiple-cursors | deprecated by author | mg979/vim-visual-multi |
| chase/vim-ansible-yaml | archived | pearofducks/ansible-vim |
| kien/ctrlp.vim | abandoned | ctrlpvim/ctrlp.vim (drop-in fork) |
| scrooloose/nerdtree, nerdcommenter, majutsushi/tagbar | renamed | preservim/* |
| Valloric/YouCompleteMe | moved, still maintained | ycm-core/YouCompleteMe, now optional; coc.nvim is default |
| altercation/vim-colors-solarized (submodule) | unmaintained | removed |
| tomasr/molokai (submodule) | stable, not archived | default colorscheme, managed by vim-plug |

Kept as-is (still maintained or stable and widely used): vim-fugitive, vim-go, undotree,
emmet-vim, vim-snippets, vim-airline, delimitMate, vim-expand-region,
vim-conflicted, vim-trailing-whitespace.

Also enabled: Vim's bundled `matchit` and `editorconfig` packages, plus persistent undo
in `~/.vim/undo`.
