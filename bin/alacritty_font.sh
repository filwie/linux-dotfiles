#!/usr/bin/env bash
set -e

repo_dir="${HOME}/.dotfiles"
setup_script="${repo_dir}/setup.sh"
tmp_setup="/tmp/setup.sh"

# source the setup script but do not call main function (last line)
cat ${setup_script} | head -n -1 > "${tmp_setup}"
source "${tmp_setup}"

verbosity=3

debug_msg "TODO: sed magick and all the stuff"
