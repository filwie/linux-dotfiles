#!/usr/bin/env bash
set -e

background_image="/tmp/lock.png"
tmp_image="/tmp/screen_capture.png"
lock_icons=("/usr/share/icons/Paper/512x512/actions/lock.png")

num_of_displays=$(xrandr -q | grep ' connected' | wc -l)

function create_background_image () {
    scrot "${tmp_image}" --quality 5
    local convert_cmd="convert -scale 5% -blur 0x2.5 -resize 2000%"

    eval "${convert_cmd} ${tmp_image} ${background_image}"
}

function set_background () {
    if [[ -f "${background_image}" ]]; then
        create_background_image &
    else
        create_background_image
    fi

}

function lock_screen () {
    exec i3lock -ti "${background_image}"
}


function main () {
    set_background
    lock_screen
}

time main
