#!/usr/bin/env bash


function main () {
    local dotfiles_repo="https://github.com/philowisp/dotfiles"
    local destination=~/.dotfiles

    if [[ -d ${destination} ]];
    then
        rm -rf ${destination}
        fi

    git clone ${dotfiles_repo} ${destination} &&
        for dotfile in ${destination}/dotfiles/*
        do
            ln ${dotfile} ~/.$(basename ${dotfile})
        done
}

main
