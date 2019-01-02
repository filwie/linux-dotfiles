#!/usr/bin/env zsh

merge_conf () {

    local i3_config_dir="${HOME}/.config/i3"

    local i3_config="${i3_config_dir}/config"
    local i3_config_base="${i3_config_dir}/base"

    local i3_config_variables="${i3_config_dir}/variables.common"
    local i3_config_variables_x240="${i3_config_dir}/variables.x240"
    local i3_config_variables_workstation="${i3_config_dir}/variables.workstation"

    local i3_config_autostart="${i3_config_dir}/autostart.common"
    local i3_config_autostart_x240="${i3_config_dir}/autostart.x240"
    local i3_config_autostart_workstation="${i3_config_dir}/autostart.workstation"

    local i3_config_multimedia_keys="${i3_config_dir}/multimedia_keys"

    local configs_to_merge=(
        "${i3_config_base}"
        "${i3_config_variables}"
        "${i3_config_autostart}"
        "${i3_config_multimedia_keys}"
    )

    if [[ $(hostname) = *"x240"* ]]; then
        configs_to_merge+=(
            "${i3_config_variables_x240}"
            "${i3_config_autostart_x240}"
        )
    else
        configs_to_merge+=(
            "${i3_config_variables_workstation}"
            "${i3_config_autostart_workstation}"
        )
    fi

    cat ${configs_to_merge[@]} > ${i3_config} \
        && echo "Config files: ${configs_to_merge[@]} succesfully merged."
}

merge_conf
