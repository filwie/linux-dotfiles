#!/usr/bin/env zsh

local root_dir="${0:a:h}"
local gen_compose_script="${root_dir}/generate_compose.sh"
local compose_file="${root_dir}/docker-compose.yaml"

local current_dir="${PWD}"

cd "${root_dir}"
"${gen_compose_script}" $@ > "${compose_file}" \
    && docker-compose build
cd "${current_dir}"
