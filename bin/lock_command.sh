#!/usr/bin/env bash

background_image="${HOME}/Pictures/lock.png"
tmp_image="/tmp/screen_capture.png"

function create_background_image () {
    scrot "${tmp_image}" -quality "1"
    local convert_cmd="convert -scale 5% -blur 0x2.5 -resize 2000%"

    eval "${convert_cmd} ${tmp_image} ${background_image}"
}

function lock_screen () {
    i3lock -ti "${background_image}"
}


function main () {
    if [[ -f "${background_image}" ]]; then
        create_background_image &
    else
        create_background_image
    fi
    lock_screen
}

time main
