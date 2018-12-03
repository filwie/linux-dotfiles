#!/bin/bash
set -e
interactive="n"
verbosity=3  # 3 - debug; 2 - info; 1 - warn

bold="$(tput bold)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
red="$(tput setaf 1)"
reset="$(tput sgr0)"



function display_usage () {
    echo -e "\nUSAGE:\t${0} [-i/--interactive]\n"
}

function debug_msg () {
    (( ${verbosity} >= 3 )) && {
        local msg="${blue}${bold}[$(date +'%T')] [${BASH_LINENO[0]}] DEBUG: "
        echo -e "${msg}${1}${reset}"
        (exit "${2:-0}")
    }
}

function info_msg () {
    (( ${verbosity} >= 2 )) && {
        local msg="${green}[$(date +'%T')] [${BASH_LINENO[0]}] INFO: "
        echo -e "${msg}${1}${reset}"
    }
}

function warn_msg () {
    local msg="${yellow}[$(date +'%T')] [${BASH_LINENO[0]}] WARN: "
    echo -e "${msg}${1}${reset}"
}

function error_msg () {
    local msg="${red}[$(date +'%T')] [${BASH_LINENO[0]}] ERROR: "
    echo -e "${msg}${1}${reset}" > /dev/stderr
    (exit "${2:-0}")
}

function sigint_handler() {
    error_msg "Got SIGINT. Aborting..." 1
}

function handle_args () {
    if [[ "${#}" -eq 1 ]]; then
        case "${1}" in
            --interactive|-i)
                interactive="y"
                info_msg "Interactive flag set."
                ;;
            *)
                error_msg "Incorrect argument: ${1}"
                display_usage
                exit 1
        esac
    fi
}

function append_block_to_file_if_not_there () {
    [[ "${#}" -ne 2 ]] && echo -e "Usage:\t${0} FILE BLOCK" && return 1
    local config_file="${1}"
    local block="${2}"

    local config_file_modified="${config_file}.modified"
    local config_file_bak="${config_file}.bak.$(date +'%F_%H:%M')"

    [[ -f "${config_file}" ]] || error_msg "Specified file (${config_file}) does not exist." 1

    if [[ "$(<${conf_file})" == *"${block}"* ]]; then
        warn_msg "Block:\n${block}\nalready present in ${config_file}"
        return 0
    else
        info_msg "Block:\n${block}\nnot found in ${config_file}. Attempting to append..."
    fi

    sudo cp "${config_file}" "${config_file_bak}" \
        && info_msg "Created a backup file: ${config_file_bak}"

    sudo cp "${config_file}" "${config_file_modified}"
    echo "${2}" | sudo tee -a "${config_file_modified}" > /dev/null \

    info_msg "Dispalying difference between ORIGINAL and MODIFIED:"
    diff --color "${config_file}" "${config_file_modified}"

    if [[ "${interactive}" == "y" ]]; then
        read -p "Apply changes to ${config_file} [Y/n]?" choice
    else
        choice="yes"
    fi
    case "${choice}" in
        Y|y|yes|""|"\n")
            sudo mv "${config_file_modified}" "${config_file}" \
                && info_msg "File modified!" \
                || error_msg "Could not modify the file!" 1
            ;;
        N|n|no)
            info_msg "Leaving the file unmodified."
            ;;
        *)
            error_msg "Unknown option. Aborting..." 1
            ;;
        esac
}



function modify_config_files () {
    info_msg "Granting Redshift access to location..."
    local conf_file="/etc/geoclue/geoclue.conf"
    local block="
[redshift]
allowed=true
system=false
users=
"
    append_block_to_file_if_not_there "${conf_file}" "${block}"
}


function main () {
    handle_args ${@}
    modify_config_files
}


main ${@}
