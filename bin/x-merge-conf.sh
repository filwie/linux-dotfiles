#!/usr/bin/env bash
set -e

merge_conf () {

    local xresources=${HOME}/.Xresources
    local xresources_base=${HOME}/.Xresources.common
    local xresources_hidpi=${HOME}/.Xresources.x240


    [[ $(hostname) = *"x240"* ]] \
        && cat ${xresources_base} ${xresources_hidpi} > ${xresources} \
        || cat ${xresources_base} > ${xresources}

    echo "Merged .Xresources"
    }

merge_conf
