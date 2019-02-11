#!/usr/bin/env zsh

function usage () {
    echo -e "USAGE:\t${0} -n/--name NAME -e/--email EMAIL" > /dev/stderr
    exit 1
}

function parse_args () {
    zparseopts -D -E n:=NAME -name:=NAME e:=EMAIL -email:=EMAIL
    NAME="${${${NAME#-n }#--name }#=}"
    EMAIL="${${${EMAIL#-e }#--email }#=}"
    { [[ -z "${NAME}" ]] || [[ -z "${EMAIL}" ]] } && usage
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

