#!/usr/bin/env bash
LOG_FILE="${HOME}/.log"
echo "[$(date --iso-8601=seconds)] ${0} sourced." >> ${LOG_FILE}

kill $(pidof polybar) 2> /dev/null
while pgrep -x polybar >/dev/null;
do
    sleep 1
done

polybar status &
