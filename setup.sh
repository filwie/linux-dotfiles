#!/usr/bin/env bash

set -e


function install_vundle_if_needed () {
    local vundle_path=~/.vim/bundle/Vundle.vim
    if ! [[ -d ${vundle_path} ]]; then
    git clone https://github.com/VundleVim/Vundle.vim.git ${vundle_path}
    fi
}


function main () {
    local dotfiles_repo="https://gitlab.com/filip.wiechec/dotfiles.git"
    local destination=~/.dotfiles
    
    cd
    if [[ -d ${destination} ]]; then
        rm -rf ${destination}
    fi
    #TODO: install vim, tmux,zsh if not installed, along with oh-my-zsh
    install_vundle_if_needed

    git clone ${dotfiles_repo} ${destination} &&
    for file in ${destination}/dotfiles/*
    do
        if [ -f "${file}" ]; then
            local dotfile=~/."$(basename ${file})"
            [[ -f "${dotfile}" ]] && rm "${dotfile}"
            ln "${file}" "${dotfile}" && echo "Linked $(basename ${file})"
        fi
        if [ -d "${file}"] && [[ "$(uname -a)" = "*inux*" ]]; then
            local app="$(basename ${file})"
            local config_dir=~/.config/"$(basename ${file})"

            mkdir -p "${config_dir}" \
                && echo "Created directory for ${app} config" \
                || echo "Directory for ${app} config already existed"

            ln "${file}/*" "${config_dir}/" && echo "Linked config files for ${app}"
        fi
    done

    vim +PluginInstall +qall
    echo "Installing below packages in used virtualenv might be required"
    echo -e "- flake8\n- pylint\n- autopep8"
    tic ./utils/screen-256color-italic.terminfo # load screen with italics to TERM database
}

main
