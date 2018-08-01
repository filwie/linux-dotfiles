#!/usr/bin/env bash

function install_packages () {
    packages=("zsh" "tmux")
    local package_manager="none"
    [[ "$(uname -a)" = *"ARCH"* ]] && echo kek

    [[ package_manager -eq "none" ]] \
        && echo "Could not detect package manager." \
        "Please install below packages manually." \
        && echo


    [[ -d ${HOME}/.oh-my-zsh ]] \
        || git clone --depth=1 https://github.com/robbyrussell/oh-my-zsh.git $HOME/.oh-my-zsh
    }

function main () {
    local dotfiles_repo="git@gitlab.com:filip.wiechec/dotfiles.git"
    local destination=~/.dotfiles

    cd

    if [[ -d ${destination} ]]; then
        echo "Existing .dotfiles directory found. Removing..."
        rm -rf ${destination}
    fi
    echo -e "\nCloning dotfiles repo..."
    git clone ${dotfiles_repo} ${destination}

    echo -e "\nRunning script linking dotfiles..."
    sh "${destination}/utils/link_dotfiles"

    echo -e "\nValidating ~/bin directory exists..."
    [[ -d ~/bin ]] || mkdir ~/bin

    echo -e "\n Linking linking script itself"
    ln -s "${destination}/utils/link_dotfiles" ~/bin/link_dotfiles

    echo -e "\nAdding terminfo profiles..."
    tic -x ${destination}/utils/xterm-256color-italic.terminfo \
        && tic -x ${destination}/utils/tmux-256color.terminfo \
        || echo -e "\eUnable to load .terminfo files - do it manually\n\ttic -x ${destination}/utils/xterm-256color-italic.terminfo\n\ttic -x ${destination}/utils/tmux-256color.terminfo \n"

    echo -e "\nInstalling tmux plugin manager..."
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm \
        && echo -e "\n\nPress C-a I to install tmux plugins!"
}

main
