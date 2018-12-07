#!/usr/bin/env bash
set -e
interactive="n"
verbosity=3  # 3 - debug; 2 - info; 1 - warn

packages="git zsh tmux grc vim curl"
dotfiles_repo="https://gitlab.com/filip.wiechec/dotfiles.git"
dotfiles_dir="${HOME}/.dotfiles"
dotfiles_branch="development"

link_dotfiles_script="${dotfiles_dir}/bin/link_dotfiles.sh"

bold="$(tput bold)"
green="$(tput setaf 10)"
yellow="$(tput setaf 11)"
blue="$(tput setaf 12)"
red="$(tput setaf 9)"
reset="$(tput sgr0)"


function display_usage () {
    echo -e "\nUSAGE:\t${0} [-i/--interactive] [-l/--link-only]\n"
}

function ok () {
    echo "${green}${bold} OK${reset}"
}

function fail () {
    echo "${red}${bold} FAIL${reset}" > /dev/stderr
    return 1
}

function debug_msg () {
    if [[ ${verbosity} -ge 3 ]]; then
        local msg="${blue}${bold}[$(date +'%T')] [${BASH_LINENO[0]}] DEBUG: "
        echo -e "${msg}${1}${reset}"
        return "${2:-0}"
    fi
}

function info_msg () {
    if [[ ${verbosity} -ge 2 ]]; then
        local msg="${green}[$(date +'%T')] [${BASH_LINENO[0]}] INFO: "
        echo -e -n "${msg}${1}${reset}"
    fi
}

function warn_msg () {
    local msg="${yellow}[$(date +'%T')] [${BASH_LINENO[0]}] WARN: "
    echo -e "${msg}${1}${reset}"
}

function error_msg () {
    local msg="${red}[$(date +'%T')] [${BASH_LINENO[0]}] ERROR: "
    echo -e "${msg}${1}${reset}" > /dev/stderr
    return "${2:-0}"
}

function sigint_handler() {
    error_msg "Got SIGINT. Aborting..." 1
}

function progress_bar() {
    while true; do
        dot_color=$(shuf -i 1-255 -n 1)
        printf "$(tput setaf ${dot_color})."
        sleep 1
    done
}

function run_log_cmd () {
    if [[ "${#}" -eq 1 ]]; then
        cmd="${1}"
    elif [[ "${#}" -eq 2 ]] && [[ "${1}" =~ -q|--quiet ]]; then
        cmd="${2} > /dev/null"
    elif [[ "${#}" -eq 2 ]] && [[ "${1}" =~ -s|--silent ]]; then
        cmd="${2} &> /dev/null"
    else
        error_msg "${FUNCNAME[0]} invalid arguments. Specify: [-q/--quiet/-s/--silent] CMD_TO_RUN" 1
    fi
    local msg="${green}${bold}[$(date +'%T')] [${BASH_LINENO[0]}] EXECUTING: "
    echo -e -n "${msg}${cmd}${reset} "

    progress_bar &

    eval "${cmd}" && ok || fail
    kill $(jobs -rp) || (exit 0)
    wait $(jobs -rp) 2>/dev/null || (exit 0)
}

function install_packages () {
    local pkg_managers=("apt" "zypper" "pacman")
    local pkg_manager="none"
    local install_cmd=""

    [[ "${#}" -lt 1 ]] \
        && error_msg "${FUNCNAME[0]} invalid arguments. Specify: PACKAGE { PACKAGE }" 1

    for pm in "${pkg_managers[@]}"; do
        info_msg "Checking ${pm}..."
        which "${pm}" &> /dev/null \
            && pkg_manager="${pm}" \
            && echo -e "\t${green}${bold}DETECTED${reset}" \
            && break || echo ""
    done

    case "${pkg_manager}" in
        apt)
            pkg_manager="DEBIAN_FRONTEND=noninteractive apt-get"
            install_cmd="install --yes" ;;
        zypper)
            install_cmd="--non-interactive in" ;;
        pacman)
            install_cmd="--noconfirm -S" ;;
    esac

    local install_pkg_cmd="sudo ${pkg_manager} ${install_cmd}"
    debug_msg "${install_pkg_cmd}"

    if [[ "${pkg_manager}" == "none" ]] || [[ "${install_cmd}" == "" ]]; then
        error_msg "Could not identify package manager. Aborting..." 1
    fi
    debug_msg "Identified package manager: ${pkg_manager}"
    debug_msg "Install command set to: ${install_pkg_cmd}"

    run_log_cmd -s "${install_pkg_cmd} ${@}"
}

function install_utilities () {
    if [[ -d ${HOME}/.oh-my-zsh ]]; then
        info_msg "Oh-My-Zsh found. Continuing...\n"
    else
        warn_msg "Oh-My-Zsh not found. Attempting to install..."
        run_log_cmd -s "git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git ${HOME}/.oh-my-zsh"
    fi

    if [[ -d "${HOME}/.fzf" ]]; then
        info_msg "fzf found. Continuing...\n"
    else
        warn_msg "fzf not found. Attempting to install..."
        run_log_cmd -s "git clone --depth 1 https://github.com/junegunn/fzf.git ${HOME}/.fzf"
    fi

    if [[ -d "${HOME}/.tmux/plugins/tpm" ]]; then
        info_msg "Tmux plugin manager found\n"
    else
        warn_msg "Tmux plugin manager not found. Attempting to install..."
        run_log_cmd -s "git clone https://github.com/tmux-plugins/tpm ${HOME}/.tmux/plugins/tpm"
    fi
    info_msg "Attempting to install Tmux plugins"
    run_log_cmd "${HOME}/.tmux/plugins/tpm/bin/install_plugins"

    if [[ -f "${HOME}/.vim/autoload/plug.vim" ]]; then
        info_msg "Vim plug found. Continuing...\n"
    else
        warn_msg "Vim plug not found. Attempting to install..."
        run_log_cmd -s "curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
    fi

    info_msg "${bold}Press \`<C-a>I\` to install tmux plugins!\n"
}

function obtain_dotfiles () {
    if [[ -d ${dotfiles_dir} ]]; then
        if [ "${interactive}" = "y" ]; then
            warn_msg "Existing .dotfiles directory found. Prompting..."
            read -p "Remove existing directory (${dotfiles_dir})? [y/N] " choice
        else
            warn_msg "Existing .dotfiles directory found. Leaving it be..."
            choice="n"
        fi
        case $choice in
            Y|y|yes)
                warn_msg "Removing..."
                rm -rf "${dotfiles_dir}"
                ;;
            N|n|no|""|"\n")
                info_msg "Not removing existing dotfiles_dir.\n"
                ;;
            * )
                error_msg "Unknown option. Aborting..." 1
                ;;
        esac
    fi
    info_msg "Cloning dotfiles repo...\n"
    run_log_cmd -s "git clone -b ${dotfiles_branch:-master} ${dotfiles_repo} ${dotfiles_dir}"
}

function add_terminfo_profiles () {
    error_msg "TODO: add terminfo"
     echo -e "\nAdding terminfo profiles..."
     tic -x ${dotfiles_dir}/utils/xterm-256color-italic.terminfo \
         && tic -x ${dotfiles_dir}/utils/tmux-256color.terminfo \
         || echo -e "\eUnable to load .terminfo files - do it manually\n\ttic -x ${dotfiles_dir}/utils/xterm-256color-italic.terminfo\n\ttic -x ${dotfiles_dir}/utils/tmux-256color.terminfo \n"
}

function apply_dotfiles (){
    info_msg "Running script to create appropriate symbolic links\n"
    run_log_cmd -q "${link_dotfiles_script}"

    local shell_msg="Currently used shell is ${SHELL}."
    if [[ "${SHELL}" == *"zsh"* ]]; then
        info_msg "${shell_msg} Continuing..."
    else
        warn_msg "${shell_msg} Changing to $(which zsh)..."
        run_log_cmd -s "sudo chsh -s $(which zsh) ${USER}"
    fi
}

function handle_args () {
    if [[ "${#}" -eq 1 ]]; then
        case "${1}" in
            --interactive|-i)
                interactive="y"
                ;;
            *)
                error_msg "Incorrect argument: ${1}"
                display_usage
                exit 1
        esac
    fi
}

function main () {
    pushd "${HOME}" > /dev/null
    trap sigint_handler SIGINT
    handle_args ${@}
    install_packages "${packages}"
    install_utilities
    obtain_dotfiles
    apply_dotfiles
    popd > /dev/null
}


main ${@}
