#!/usr/bin/env zsh
local prefix="${1:-""}"
local suffix=${2:-""}

echo "# Generated: $(date +'%F %T')"
echo "version: '3'"
echo "services:"
find . -maxdepth 1 -type d -not -name "." |
    while read -r DIR
    do
        local image="$(basename "${DIR}")"
        echo "  ${image}:"
        echo "    build:"
        echo "      context: ${image}/"
        echo "    image: ${prefix}${image}${suffix}"
        echo "    container_name: ${prefix}${image}${suffix}"
    done


