export ZSH=~/.oh-my-zsh
ZSH_THEME="arrow"
plugins=(git osx brew brew-cask z)
source ${ZSH}/oh-my-zsh.sh
# ---------------------------------------------------------

# Start tmux whith zsh
if [[ -z "${TMUX}" ]] ;then
    # get the ID of a deattached session
    ID="`tmux ls | grep -vm1 attached | cut -d: -f1`"
    # if none exists - create a new one, if
    if [[ -z "${ID}" ]] ;then
        tmux new-session
    else
        tmux attach-session -t "${ID}"
    fi
fi

# Source .bash_aliases if file exists
declare -a FILES_TO_SOURCE=(".bash_aliases" ".zsh_aliases")
if [ -f ~/.bash_aliases ]; then
    source ~/.bash_aliases
fi

# Vim as default text editor (git commits et cetera)
export VISUAL=vim
export EDITOR="${VISUAL}"

source ~/bin/gruvbox_256palette_osx.sh
