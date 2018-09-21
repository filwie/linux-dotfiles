#!/usr/bin/env zsh
merge_conf () {

    local xresources=${HOME}/.Xresources
    local xresources_base=${HOME}/.Xresources_base
    local xresources_hidpi=${HOME}/.Xresources_hidpi


    [[ $(hostname) = *"x240"* ]] \
        && cat ${xresources_base} ${xresources_hidpi} > ${xresources} \
        || cat ${xresources_base} > ${xresources}

    }

merge_conf
