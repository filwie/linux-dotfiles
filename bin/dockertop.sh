#!/usr/bin/env zsh
function dockertop () {
    local display_columns=(".Names" ".Status")
    typeset -U display_columns  # unique values

    for arg in ${@}; do
        case "${arg}" in
            .Image|image|im|i)
                display_columns+=(".Image") ;;
            .Mounts|mounts|m|volumes|v)
                display_columns+=(".Mounts") ;;
            .RunningFor|runningfor|age|a)
                display_columns+=(".RunningFor") ;;
            .Size|size|s)
                display_columns+=(".Size") ;;
            .Ports|ports|p)
                display_columns+=(".Ports") ;;
        esac
    done

    local format_template="{{${(j:"}}\t{{":)display_columns}}}"  # '}}\t{{'.join(display_columns) equivalent
    format_template=${format_template:gs/\"/}  # gets rid of the unnecessary quote

    watch --color --no-title --interval 1 --differences "grc docker ps --no-trunc --format 'table ${format_template}'"
}

dockertop ${@}
