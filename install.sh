#!/usr/bin/env zsh

repo_dir="${0:h:A}"
setup_script="${repo_dir}/setup.sh"
tmp_setup="/tmp/setup.sh"

# source the setup script but do not call main function (last line)
cat ${setup_script} | head -n -1 > "${tmp_setup}"
source "${tmp_setup}"

verbosity=3

dotfiles_dir_repo="${repo_dir}/home"
config_dir_repo="${repo_dir}/home/config"
bin_dir_repo="${repo_dir}/bin"
bin_dir="${HOME}/bin"

old_dotfiles_dir="/tmp/old_dotfiles"

dirs_that_should_exist=("${HOME}/bin" "${HOME}/.config")

function skip () {
    echo "${bright_green}${bold}Skipping...${reset}"
}

function create_dirs () {
    for dir in ${dirs_that_should_exist[@]}; do
        run_log_cmd "[[ -d ${dir} ]] || mkdir ${dir}"
    done
}

function compare_checksums () {
    first="$(realpath -s ${1})"
    second="$(realpath -s ${2})"

    if [[ -e "${first}" ]] && [[ -e "${second}" ]]; then
        if [[ -f "${second}" ]]; then
            first_sum="$(shasum ${first} | cut -d' ' -f1)"
            second_sum="$(shasum ${second} | cut -d' ' -f1)"
            if [[ "${first_sum}" == "${second_sum}" ]]; then
                return 0
            fi
        elif [[ -d "${second}" ]]; then
            diff -qr ${first} ${second}
            return $?
        fi
    fi
    return 1
}

function link_dotfile () {
    if [[ "${#}" -ne 2 ]]; then
        error_msg "${FUNCNAME[0]} invalid arguments. Specify: FILE DESTINATION" 1
    fi
    src_path="$(realpath -s ${1})"
    dest_path="$(realpath -s ${2})"

    if compare_checksums "${src_path}" "${dest_path}"; then
        info_msg "$(basename ${second}) is up to date. " && skip
        return 0
    fi
    [[ -e "${dest_path}" ]] && run_log_cmd "mv ${dest_path} ${dest_path}.bak"
    run_log_cmd "ln -s ${src_path} ${dest_path}"
}

function link_all_dotfiles () {
    pushd "${dotfiles_dir_repo}" > /dev/null
    for dir_or_file in *; do
        if [[ "$(basename ${dir_or_file})" == "config" ]]; then
            local config_dir_repo="${dir_or_file}"
            pushd "${config_dir_repo}" > /dev/null
            for config_dir_or_file in *; do
                link_dotfile \
                    "${config_dir_or_file}" \
                    "${HOME}/.config/$(basename ${config_dir_or_file})"
            done
            popd > /dev/null
        else
            link_dotfile \
                "${dir_or_file}" \
                "${HOME}/.$(basename ${dir_or_file})"
        fi
    done
    pushd "${bin_dir_repo}" > /dev/null
    for script in *; do
        link_dotfile "${script}" "${bin_dir}/$(basename ${script})"
    done
        popd > /dev/null
    popd > /dev/null
}

function main () {
    create_dirs
    link_all_dotfiles
}


main
