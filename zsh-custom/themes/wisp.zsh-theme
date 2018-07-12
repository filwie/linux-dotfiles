# Escape codes
local rgb_prefix=$'%{\x1b[38;2;'
local rgb_suffix=$'m%}'
local start_italics=$'%{\x1b[3m%}'
local end_italics=$'%{\x1b[0m%}'

# Colors
local git_info_color=${rgb_prefix}"213;196;161"${rgb_suffix}
local path_color=${rgb_prefix}"124;111;100"${rgb_suffix}
local distinct_color=${rgb_prefix}"7;102;120"${rgb_suffix}
local warning_color=${rgb_prefix}"225;148;59"${rgb_suffix}
local critical_color=${rgb_prefix}"177;63;32"${rgb_suffix}

ZSH_THEME_SCM_PROMPT_PREFIX=${git_info_color}" "${start_italics}
ZSH_THEME_GIT_PROMPT_PREFIX=$ZSH_THEME_SCM_PROMPT_PREFIX
ZSH_THEME_GIT_PROMPT_SUFFIX=${end_italics}

ZSH_THEME_GIT_PROMPT_DIRTY=${warning_color}"✗%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_CLEAN="✔%{$reset_color%} "


local path_short=${path_color}'%2~%{$reset_color%}'
local git_prompt=$' $(git_prompt_info)$(bzr_prompt_info)'
local ret_status="%(?:"${path_color}":"${critical_color}")"$'%{$reset_color%} '

PROMPT=${path_short}${git_prompt}${ret_status}
GIT_CB="git::"

# vim: set filetype=zsh:
