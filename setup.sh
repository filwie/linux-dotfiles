#!/usr/bin/env bash


function main () {
    local dotfiles_repo="https://github.com/philowisp/dotfiles"
    local destination=~/.dotfiles

    if [[ -f ${destination} ]];
    then
        rm -rf ${destination}
    fi

    git clone ${dotfiles_repo} ${destination} &&
        for dotfile in ${destination}/dotfiles/*
        do
            echo "${dotfile}"
        done
}

main
