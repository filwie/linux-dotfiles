#!/usr/bin/env zsh

DOTFILES="${0:A:h}"

XDG_CONFIG_HOME="${XDG_CONFIG_HOME:-${HOME}/.config}"
SCRIPTS_DIR="${HOME}/bin"

NEEDED_DIRS=("${XDG_CONFIG_HOME}"
             "${SCRIPTS_DIR}")

EXISTING_FILE_BACKUPS=()

function info_msg () {
  echo -e "$(tput setaf 3)${1}$(tput sgr0)"
}

function error_msg () {
  echo -e "$(tput setaf 3)${1}$(tput sgr0)" > /dev/stderr
  return "${1:-1}"
}

function run_log_cmd () {
  echo -e "$(tput setaf 12)[$(date +'%H:%M:%S')] RUNNING: ${1}$(tput sgr0)"
  eval "${1}"
}

function create_dirs () {
  echo "${@}"
  for _dir in "${@}"; do
    run_log_cmd "[[ -d ${_dir} ]] || mkdir ${_dir}"
  done
}

function _link_dotfile () {
  [[ -e "${1}" ]] || return
  [[ -n "${2}" ]] || return

  local src dest
  src="${1:A}"
  dest="${2:A}"

  if [[ "${src}" == "${dest}" ]]; then
    info_msg "${dest:t} is up to date. "
    return 0
  fi
  if [[ -e "${dest}" ]]; then
    run_log_cmd "mv ${dest} ${dest}.bak"
    EXISTING_FILE_BACKUPS+=("${dest}.bak")
  fi
  run_log_cmd "ln -s ${src} ${dest}"
}

function link_all_dotfiles () {
  pushd "${DOTFILES}"
  for dotfile in home/*(.); do
    _link_dotfile "${dotfile:A}" "${HOME}/.${dotfile:t}"
  done
  for script in bin/*; do
    _link_dotfile "${script:A}" "${SCRIPTS_DIR}/${script:t}"
  done
  for config in **/config/*; do
    _link_dotfile "${config:A}" "${XDG_CONFIG_HOME}/${config:t}"
  done
  popd > /dev/null
}

function remove_backed_up_oldies () {
  [[ -n "${(j..)EXISTING_FILE_BACKUPS[@]}" ]] || return
  local choice
  echo -e "Backed up files:\n${(j.\n.)EXISTING_FILE_BACKUPS[@]}"
  vared -p 'Delete backed up files? [y/yes/n/no]: ' -c choice
  case "${choice}" in
    y|yes|Y|YES)
      run_log_cmd "rm -rf ${(j. .)EXISTING_FILE_BACKUPS[@]}" ;;
    n|no|N|NO)
      info_msg "Leaving files untouched." ;;
    *)
      error_msg "Wrong input. Assuming 'no'" 0 ;;
  esac
  }

function main () {
  create_dirs "${NEEDED_DIRS[@]}"
  link_all_dotfiles
  remove_backed_up_oldies
}

main
# vim: ft=zsh sw=2 ts=2:
