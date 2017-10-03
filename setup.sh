#!/usr/bin/env bash

set -e


function install_vundle_if_needed () {
    local vundle_path=~/.vim/bundle/Vundle.vim
    [[ -f "${vundle_path}" ]] || git clone \
        https://github.com/VundleVim/Vundle.vim.git "${vundle_path}"
}


function main () {
    local dotfiles_repo="https://github.com/philowisp/dotfiles"
    local destination=~/.dotfiles

    if [[ -d ${destination} ]]; then
        rm -rf ${destination}
    fi
    #TODO: install vim, tmux,zsh if not installed, along with oh-my-zsh
    install_vundle_if_needed

    git clone ${dotfiles_repo} ${destination} &&
    for file in ${destination}/dotfiles/*
    do
        local dotfile=~/."$(basename ${file})"
        [[ -f "${dotfile}" ]] && rm "${dotfile}"
        ln "${file}" "${dotfile}"
    done
}

main
