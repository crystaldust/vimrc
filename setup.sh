#!/usr/bin/env bash
# Link this repo's vimrc into place, install vim-plug and all plugins.
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VIMRC_TARGET="${HOME}/.vimrc"
PLUG_FILE="${HOME}/.vim/autoload/plug.vim"
PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

link_vimrc() {
  if [[ -L "${VIMRC_TARGET}" && "$(readlink "${VIMRC_TARGET}")" == "${REPO_DIR}/vimrc" ]]; then
    echo "~/.vimrc already linked"
    return
  fi
  if [[ -e "${VIMRC_TARGET}" || -L "${VIMRC_TARGET}" ]]; then
    local backup
    backup="${VIMRC_TARGET}.bak.$(date +%Y%m%d%H%M%S)"
    mv "${VIMRC_TARGET}" "${backup}"
    echo "Backed up existing ~/.vimrc to ${backup}"
  fi
  ln -s "${REPO_DIR}/vimrc" "${VIMRC_TARGET}"
  echo "Linked ~/.vimrc -> ${REPO_DIR}/vimrc"
}

install_plug() {
  if [[ -f "${PLUG_FILE}" ]]; then
    echo "vim-plug already installed"
    return
  fi
  curl -fLo "${PLUG_FILE}" --create-dirs "${PLUG_URL}"
}

warn_missing() {
  local cmd
  local required=(git curl go)
  if [[ "${VIM_COMPLETION:-coc}" == "ycm" ]]; then
    required+=(python3 cmake)
  else
    required+=(node)
  fi
  for cmd in "${required[@]}"; do
    command -v "${cmd}" >/dev/null 2>&1 || echo "WARN: '${cmd}' not found (see README)"
  done
  if ! ctags --version 2>/dev/null | grep -q 'Universal Ctags'; then
    echo "WARN: tagbar needs universal-ctags (brew install universal-ctags)"
  fi
}

main() {
  warn_missing
  link_vimrc
  install_plug
  vim -es -u "${VIMRC_TARGET}" -i NONE -c 'PlugInstall --sync' -c 'qa' || true
  echo "Done. Open vim and run :PlugStatus to verify."
}

main "$@"
