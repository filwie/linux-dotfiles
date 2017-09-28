#!/usr/bin/env bash


function main () {
    local dotfiles_repo="https://github.com/philowisp/dotfiles"
    local destination=~/.dotfiles

    if [[ -d ${destination} ]]; then
        rm -rf ${destination}
    fi

    git clone ${dotfiles_repo} ${destination} &&
    for file in ${destination}/dotfiles/*
    do
        local dotfile=~/.$(basename ${file})
        [[ -f "${dotfile}" ]] && rm "${dotfile}"
        ln "${dotfile}" "${file}"
    done
}

main
