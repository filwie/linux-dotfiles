#!/usr/bin/env bash
source "${HOME}/.zshenv"

kill $(pidof polybar) 2> /dev/null
while pgrep -x polybar >/dev/null;
do
    sleep 1
done

polybar status &
