#!/usr/bin/env bash
set -e

dotfiles_dir=${HOME}/.dotfiles/dotfiles
config_dir=${dotfiles_dir}/config/
utils_dir=${dotfiles_dir}/../utils/

green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"


function info_msg () {
    local msg="${green}[$(date +'%T')] [${BASH_LINENO[0]}] INFO: "
    echo -e "${msg}${1}${reset}"
}


function warn_msg () {
    local msg="${yellow}[$(date +'%T')] [${BASH_LINENO[0]}] WARN: "
    echo -e "${msg}${1}${reset}"
}


function error_msg () {
    local msg="${red}[$(date +'%T')] [${BASH_LINENO[0]}] ERROR: "
    echo -e "${msg}${1}${reset}"
    (exit "${2:-0}")
}


echo -e "\n"
info_msg "Starting linking dotfiles..."
find ${dotfiles_dir} -maxdepth 1 -type f | while read -r file
do
    dotfile_in_repo="${file}"
    dotfile=${HOME}/".$(basename "${file}")"
    [[ -f "${dotfile}" ]] && rm "${dotfile}" \
        && warn_msg "\t- Removed old ${dotfile}" \
        || info_msg -e "\t- ${dotfile} not present"

    ln -s "${dotfile_in_repo}" "${dotfile}" && info_msg "\t- Created a soft link to ${dotfile}"

done

echo -e "\n"
info_msg "Linking scripts"
[[ -d "${HOME}/bin" ]] || mkdir "${HOME}/bin"
find ${utils_dir} -maxdepth 1 -type f -executable | while read -r executable
do
    script_in_repo="${executable}"
    script_in_home_bin=${HOME}/bin/"$(basename "${executable}")"
    [[ -f "${script_in_home_bin}"  ]] \
        && rm "${script_in_home_bin}" \
            && warn_msg "\t- Removed ${script_in_home_bin}" \
            || info_msg "\t- ${script_in_home_bin} not present"

    ln -s "${script_in_repo}" "${script_in_home_bin}" \
        && info_msg "\t- Symlinked ${script_in_home_bin}"
done

echo -e "\n"
info_msg "\nLinking config directories"

[[ -d "${HOME}/.config" ]] \
    || warn_msg ".config directory not found. Creating..." \
    && mkdir -p "${HOME}/.config"

if [[ ! "$(uname -a)" = *"Darwin"* ]]; then
    ls -1 ${config_dir} | while read -r file
    do
        config_in_repo="${config_dir}/${file}"
        config=${HOME}/.config/"${file}"
        [[ -e "${config}" ]] && rm -rf ${config} \
            && warn_msg "\t- Removed old ${config}" \
            || info_msg "\t- ${config} not present"
        ln -s "${config_in_repo}" "${config}" && info_msg "\t- Symlinked ${config}"
    done
fi
