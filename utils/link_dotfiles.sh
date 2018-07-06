#!/usr/bin/env bash
set -e
dotfiles_dir=~/.dotfiles/dotfiles
config_dir=~/.dotfiles/dotfiles/config/

find ${dotfiles_dir} -maxdepth 1 -type f | while read -r file
do
    dotfile_in_repo="${file}"
    dotfile=~/".$(basename "${file}")"
    [ -f "${dotfile}" ] && rm "${dotfile}" && echo "Removed old ${dotfile}" || echo "${dotfile} not present"
    [[ "$(uname -a)" = *"Darwin"* ]] \
        && ln "${dotfile_in_repo}" "${dotfile}" && echo "Created hard link to ${dotfile}" \
        || ln -s "${dotfile_in_repo}" "${dotfile}" && echo "Created a soft link to ${dotfile}"

done

if [[ ! "$(uname -a)" = *"Darwin"* ]]; then
    ls -1 ${config_dir} | while read -r file
    do
        config_in_repo="${config_dir}/${file}"
        config=~/.config/"${file}"
        [ -e "${config}" ] && rm -rf ${config} \
            && echo "Removed old ${config}" \
            || echo "${config} not present"
        ln -s "${config_in_repo}" "${config}" && echo "Symlinked ${config}"
    done
fi
