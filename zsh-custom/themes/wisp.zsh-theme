PROMPT=$'%{$FG[003]%}%2~%{$reset_color%} $(git_prompt_info)$(bzr_prompt_info)%{$reset_color%}%{$FG[004]%}>%{$reset_color%} '

GIT_CB="git::"
ZSH_THEME_SCM_PROMPT_PREFIX="%{$FG[004]%}"
ZSH_THEME_GIT_PROMPT_PREFIX=$ZSH_THEME_SCM_PROMPT_PREFIX
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=",%{$FG[001]%} ++ "
ZSH_THEME_GIT_PROMPT_CLEAN=",%{$fg[002]%} ok "
