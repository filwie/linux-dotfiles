#!/usr/bin/env zsh
merge_conf () {

    local i3_config_dir="${HOME}/.config/i3"

    local i3_config=${i3_config_dir}/config
    local i3_config_base=${i3_config_dir}/base
    local i3_config_x240=${i3_config_dir}/x240
    local i3_config_workstation=${i3_config_dir}/workstation

    local i3_config_xfce4_integration="${i3_config_dir}/xfce4_i3"
    local i3_config_pure_i3="${i3_config_dir}/pure_i3"

    local configs_to_merge=("${i3_config_base}")

    [[ $(hostname) = *"x240"* ]] \
        && configs_to_merge+="${i3_config_x240}" \
        || configs_to_merge+="${i3_config_workstation}"

    [[ "${PURE_I3}" == "true" ]] \
        || configs_to_merge+="${i3_config_xfce4_integration}" \
        && configs_to_merge+="${i3_config_pure_i3}"

    cat ${configs_to_merge[@]} > ${i3_config} \
        && echo "Config files: ${configs_to_merge[@]} succesfully merged."
}

merge_conf