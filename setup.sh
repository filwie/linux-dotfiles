#!/usr/bin/env bash


function main () {
    local dotfiles_repo="https://github.com/philowisp/dotfiles"
    local destination=~/.dotfiles

    [[ -d ${destination} ]] && rm -rf "${destination}"

        git clone ${dotfiles_repo} ${destination} &&
        for file in ${destination}/dotfiles/*
        do
            local dotfile="~/.$(basename ${file})"
            [[ -f "${dotfile}" ]] && rm "${dotfile}"
            ln "${file}" "${dotfile}"
        done
}

main
