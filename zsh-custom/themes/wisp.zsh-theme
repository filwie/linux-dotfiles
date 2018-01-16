PROMPT=$'%{$FG[003]%}%/%{$reset_color%} $(git_prompt_info)$(bzr_prompt_info)%{$FG[008]%}[%n@%m]%{$reset_color%} %{$FG[008]%}[%T]%{$reset_color%}
%{$fg_bold[black]%}>%{$reset_color%} '

PROMPT2="%{$FG[001]%}%_> %{$reset_color%}"

GIT_CB="git::"
ZSH_THEME_SCM_PROMPT_PREFIX="%{$FG[012]%}git: "
ZSH_THEME_GIT_PROMPT_PREFIX=$ZSH_THEME_SCM_PROMPT_PREFIX
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=",%{$FG[001]%} ++ "
ZSH_THEME_GIT_PROMPT_CLEAN=",%{$fg[002]%} ok "
