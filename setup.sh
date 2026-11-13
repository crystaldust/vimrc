#!/usr/bin/env bash
# Link this repo's vimrc into place, install vim-plug and all plugins.
set -euo pipefail

# Files are copied (not symlinked) so the clone can live in /tmp and be deleted.
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VIM_HOME="${HOME}/.vim"
VIMRC_TARGET="${HOME}/.vimrc"
PLUG_FILE="${VIM_HOME}/autoload/plug.vim"
PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
BACKUP_SUFFIX=".bak.$(date +%Y%m%d%H%M%S)"

# install_file SRC DST — copy SRC to DST, backing up a different existing DST.
install_file() {
  local src="$1" dst="$2"
  if [[ -f "${dst}" && ! -L "${dst}" ]] && cmp -s "${src}" "${dst}"; then
    echo "${dst} is up to date"
    return
  fi
  if [[ -e "${dst}" || -L "${dst}" ]]; then
    mv "${dst}" "${dst}${BACKUP_SUFFIX}"
    echo "Backed up ${dst} to ${dst}${BACKUP_SUFFIX}"
  fi
  mkdir -p "$(dirname "${dst}")"
  cp "${src}" "${dst}"
  echo "Installed ${dst}"
}

install_config() {
  install_file "${REPO_DIR}/vimrc" "${VIMRC_TARGET}"
  install_file "${REPO_DIR}/completion.vim" "${VIM_HOME}/completion.vim"
  install_file "${REPO_DIR}/coc-settings.json" "${VIM_HOME}/coc-settings.json"
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
  install_config
  install_plug
  vim -es -u "${VIMRC_TARGET}" -i NONE -c 'PlugInstall --sync' -c 'qa' || true
  echo "Done. Open vim and run :PlugStatus to verify."
}

main "$@"
