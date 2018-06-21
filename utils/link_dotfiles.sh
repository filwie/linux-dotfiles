#!/usr/bin/env bash
set -e
dotfiles_dir=~/.dotfiles/dotfiles

find ${dotfiles_dir} -maxdepth 1 -type f | while read -r file
do
    dotfile_in_repo="${file}"
    dotfile=~/".$(basename "${file}")"
    [ -f "${dotfile}" ] && rm "${dotfile}" && echo "Removed old ${dotfile}" || echo "${dotfile} not present"
    [[ "$(uname -a)" = *"Darwin"* ]] \
        && ln "${dotfile_in_repo}" "${dotfile}" && echo "Created hard link to ${dotfile}" \
        || ln -s "${dotfile_in_repo}" "${dotfile}" && echo "Created a soft link to ${dotfile}"
done
