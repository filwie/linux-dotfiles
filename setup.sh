#!/usr/bin/env bash

set -e


function install_vundle_if_needed () {
    local branch=master
    local vundle_path=~/.vim/bundle/Vundle.vim
    if ! [[ -d ${vundle_path} ]]; then
    timeout 10 git clone git@gitlab.com:filip.wiechec/dotfiles.git ${vundle_path} -b ${branch} || \
        git clone https://gitlab.com/filip.wiechec/dotfiles.git ${vundle_path} -b ${branch}
    fi
}


function main () {
    local dotfiles_repo="git@gitlab.com:filip.wiechec/dotfiles.git"
    local destination=~/.dotfiles
    
    cd
    if [[ -d ${destination} ]]; then
        rm -rf ${destination}
    fi
    #TODO: install vim, tmux,zsh if not installed, along with oh-my-zsh
    install_vundle_if_needed

    git clone ${dotfiles_repo} ${destination}

    bash "{destination}/utils/utils/link_dotfiles.sh"

    vim +PluginInstall +qall
    vim +GoInstallBinaries +qall
    echo "Installing below packages in used virtualenv might be required"
    echo -e "- flake8\\n- pylint\\n- autopep8"
    
    tic -x ${destination}/utils/xterm-256color-italic.terminfo
    tic -x ${destination}/utils/tmux-256color.terminfo
    wget https://raw.githubusercontent.com/Valloric/ycmd/3ad0300e94edc13799e8bf7b831de8b57153c5aa/cpp/ycm/.ycm_extra_conf.py ~/.ycm_extra_conf.py 
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

main
