#!/usr/bin/env bash
set -e
interactive="n"
verbosity=3  # 3 - debug; 2 - info; 1 - warn

packages="git zsh tmux grc vim"
dotfiles_repo="https://gitlab.com/filip.wiechec/dotfiles.git"
destination=~/.dotfiles

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

function install_packages () {
    local pkg_managers=("apt" "zypper" "pacman")
    local pkg_manager="none"
    local install_cmd=""

    [[ "${#}" -lt 1 ]] && error_msg "No package specified for installation. Aborting..." 1

    for pm in "${pkg_managers[@]}"; do
        info_msg "Checking ${pm}..."
        which "${pm}" &> /dev/null && pkg_manager="${pm}" && info_msg "\t${pm} confirmed" && break
    done

    case "${pkg_manager}" in
        apt)
            pkg_manager="DEBIAN_FRONTEND=noninteractive apt"
            install_cmd="install --yes" ;;
        zypper)
            install_cmd="--non-interactive in" ;;
        pacman)
            install_cmd="--noconfirm -S" ;;
    esac

    local install_pkg_cmd="sudo ${pkg_manager} ${install_cmd}"
    debug_msg "${install_pkg_cmd}"

    if [ "${pkg_manager}" = "none" ] || [ "${install_cmd}" = "" ]; then
        error_msg "Could not identify package manager. Aborting..." 1
    else
        info_msg "Identified package manager: ${pkg_manager}."
        info_msg "Install command set to: ${install_pkg_cmd}"
    fi

    warn_msg "Running: \`${install_pkg_cmd} ${@}\` (sudo pass might be required)"
    eval "${install_pkg_cmd} ${@}"
}

function configure_shell () {
    [[ -d ${HOME}/.oh-my-zsh ]] \
        && info_msg "Oh-My-Zsh found. Continuing..." \
        || { warn_msg "Oh-My-Zsh not found. Attempting to install..."
             git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
        }

    [[ -d "${HOME}/.fzf" ]] \
        && info_msg "fzf found. Continuing..." \
        || { warn_msg "fzf not found. Attempting to install..."
             git clone --depth 1 https://github.com/junegunn/fzf.git "${HOME}/.fzf"
        }
    [[ -d "${HOME}/.tmux/plugins/tpm" ]] \
        && info_msg "Tmux plugin manager found" \
        || { warn_msg "Tmux plugin manager not found. Attempting to install..."
            git clone https://github.com/tmux-plugins/tpm "${HOME}/.tmux/plugins/tpm"
        }

    info_msg "${bold}Press \`<C-a>I\` to install tmux plugins!"
}

function obtain_dotfiles () {
    info_msg "Going '$HOME'"
    cd "${HOME}"
    if [[ -d ${destination} ]]; then
        if [ "${interactive}" = "y" ]; then
            warn_msg "Existing .dotfiles directory found. Prompting..."
            read -p "Remove existing directory (${destination})? [y/N] " choice
        else
            warn_msg "Existing .dotfiles directory found. Leaving it be..."
            choice="n"
        fi
        case $choice in
            Y|y|yes)
                warn_msg "Removing..."
                rm -rf "${destination}"
                git clone ${dotfiles_repo} ${destination}
                ;;
            N|n|no|""|"\n")
                info_msg "Not removing existing destination."
                ;;
            * )
                error_msg "Unknown option. Aborting..." 1
                ;;
        esac
    else
        info_msg -e "\nCloning dotfiles repo..."
        git clone ${dotfiles_repo} ${destination}
    fi
}

function add_terminfo_profiles () {
    error_msg "TODO: add terminfo"
     echo -e "\nAdding terminfo profiles..."
     tic -x ${destination}/utils/xterm-256color-italic.terminfo \
         && tic -x ${destination}/utils/tmux-256color.terminfo \
         || echo -e "\eUnable to load .terminfo files - do it manually\n\ttic -x ${destination}/utils/xterm-256color-italic.terminfo\n\ttic -x ${destination}/utils/tmux-256color.terminfo \n"
}

function apply_dotfiles (){
    info_msg "Making sure \`${HOME}/bin\` exists"
    [[ -d "${HOME}/bin" ]] || mkdir "${HOME}/bin"

    info_msg "Running script to create appropriate symbolic links"
    ${destination}/utils/link_dotfiles

    local shell_msg="Currently used shell is ${SHELL}."
    [[ "${SHELL}" == *"zsh"* ]] \
        && info_msg "${shell_msg} Continuing..." \
        || { warn_msg "${shell_msg} Changing to Zsh..."
             sudo chsh -s $(which zsh) ${USER} && info_msg "Shell changed."
           }
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
    trap sigint_handler SIGINT
    handle_args ${@}
    install_packages "${packages}"
    configure_shell
    obtain_dotfiles
    apply_dotfiles
}


main ${@}
