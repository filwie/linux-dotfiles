#!/usr/bin/env bash

set -e

function main () {
    local dotfiles_repo="https://github.com/philowisp/dotfiles"
    local destination=~/.dotfiles

    if [[ -d ${destination} ]]; then
        rm -rf ${destination}
    fi

    git clone ${dotfiles_repo} ${destination} &&
    for file in ${destination}/dotfiles/*
    do
        local dotfile=~/."$(basename ${file})"
        [[ -f "${dotfile}" ]] && rm "${dotfile}"
        ln "${file}" "${dotfile}"
    done
}

main
