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

## Language support (coc.nvim)

coc.nvim is a generic LSP client: any language with a language server works.
There are two ways to add one.

### Option 1: coc extensions (recommended)

Extensions download and configure the language server for you. Either add them to
`g:coc_global_extensions` in `completion.vim` (installed automatically on next start,
and reproducible on a new machine):

```vim
let g:coc_global_extensions = ['coc-go', 'coc-json', 'coc-yaml', 'coc-snippets',
      \ 'coc-pyright', 'coc-tsserver', 'coc-clangd']
```

or install one ad hoc inside Vim with `:CocInstall coc-pyright`.

| Language | Extension | Extra requirement | Status (2026-11) |
|----------|-----------|-------------------|------------------|
| Go | `coc-go` *(enabled)* | `go` | active |
| JSON | `coc-json` *(enabled)* | — | active |
| YAML | `coc-yaml` *(enabled)* | — | active |
| Snippets | `coc-snippets` *(enabled)* | — | active |
| TypeScript / JavaScript | `coc-tsserver` | — (bundles tsserver) | active |
| ESLint / Prettier | `coc-eslint`, `coc-prettier` | project-local `eslint` / `prettier` | active |
| Python | `coc-pyright` | `python3` | active |
| Rust | `coc-rust-analyzer` | `rustup` (downloads rust-analyzer on first use) | active |
| C / C++ | `coc-clangd` | `clangd` (Xcode CLT or `brew install llvm`) | active |
| Java | `coc-java` | JDK 21+ | active |
| HTML / CSS | `coc-html`, `coc-css` | — | active |
| Ansible | `coc-ansible` | `ansible`, optionally `ansible-lint` | active |
| Shell | `coc-sh` | — (`shellcheck` recommended) | low activity |
| Lua, VimL, Dockerfile | `coc-lua`, `coc-vimlsp`, `coc-docker` | — | unmaintained since 2023; prefer option 2 |

### Option 2: configure a language server directly

For languages without a maintained extension, point coc at a server you installed
yourself, in `coc-settings.json`:

```json
"languageserver": {
  "lua": {
    "command": "lua-language-server",
    "filetypes": ["lua"],
    "rootPatterns": [".luarc.json", ".git/"]
  },
  "dockerfile": {
    "command": "docker-langserver",
    "args": ["--stdio"],
    "filetypes": ["dockerfile"]
  }
}
```

Install the servers first, e.g. `brew install lua-language-server` and
`npm install -g dockerfile-language-server-nodejs`. The coc wiki page
[Language servers](https://github.com/neoclide/coc.nvim/wiki/Language-servers) has
ready-made snippets for many more languages (Haskell, Zig, Kotlin, Terraform, …).

### Managing extensions

| Command | Purpose |
|---------|---------|
| `:CocList extensions` | list installed extensions (toggle / uninstall from the list) |
| `:CocUpdate` | update all extensions |
| `:CocUninstall coc-xxx` | remove an extension (also drop it from `g:coc_global_extensions`) |
| `:CocInfo` | versions and server logs, useful for troubleshooting |
| `:CocConfig` | open `coc-settings.json` |
| `:CocCommand workspace.showOutput` | show a language server's output |

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
