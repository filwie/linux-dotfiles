#!/usr/bin/env zsh

function usage () {
    echo -e "USAGE:\t${0} [-h/--help] -n/--name NAME -e/--email EMAIL" > /dev/stderr
    exit 1
}

function _warn () {
    echo "$(tput setaf 3)${1}$(tput sgr0)"
}

function parse_args () {
    local help
    zparseopts -D -E h=help -help=help n:=NAME -name:=NAME e:=EMAIL -email:=EMAIL
    [[ -n "${help}" ]] && usage
    NAME="${${${NAME#-n }#--name }#=}"
    EMAIL="${${${EMAIL#-e }#--email }#=}"
    if [[ -z "${NAME}" ]] || [[ -z "${EMAIL}" ]]; then
        NAME="$(git config user.name)"
        EMAIL="$(git config user.email)"
        _warn "No arguments specified. Falling back to git config. (${NAME}, ${EMAIL})"
    fi
}

function git_filter_name_email () {
    git filter-branch -f --env-filter "
        export GIT_COMMITTER_NAME="${1}"
        export GIT_AUTHOR_NAME="${1}"

        export GIT_COMMITTER_EMAIL="${2}"
        export GIT_AUTHOR_EMAIL="${2}"
    " --tag-name-filter cat -- --branches --tags
}

function main () {
    parse_args "${@}"
    git_filter_name_email "${NAME}" "${EMAIL}"
}

main "${@}"

