#!/usr/bin/env zsh
merge_conf () {

    local i3_config_dir="${HOME}/.config/i3"

    local i3_config=${i3_config_dir}/config
    local i3_config_base=${i3_config_dir}/base
    local i3_config_status=${i3_config_dir}/status_bar
    local i3_config_x240=${i3_config_dir}/x240
    local i3_config_workstation=${i3_config_dir}/workstation

    local i3_config_multimedia_keys="${i3_config_dir}/multimedia_keys"

    local configs_to_merge=("${i3_config_base}" "${i3_config_status}" "${i3_config_multimedia_keys}")

    [[ $(hostname) = *"x240"* ]] \
        && configs_to_merge+="${i3_config_x240}" \
        || configs_to_merge+="${i3_config_workstation}"

    cat ${configs_to_merge[@]} > ${i3_config} \
        && echo "Config files: ${configs_to_merge[@]} succesfully merged."
}

merge_conf
