#!/usr/bin/env zsh

ROOT_DIR="${0:a:h}"
REPO_DIR="$(dirname ${0:a:h})"
TEST_DIR="test"
COMPOSE_FILE="${ROOT_DIR}/docker-compose.yaml"

declare -aU test_images

function build_images () {
    local image_prefix="test-"

    local template=\
"# Generated on: $(date)
version: '3'
services:
"
    for dockerfile in **/Dockerfile; do
            local image_dir="$(dirname "${dockerfile}")"
            local image_name="${image_prefix}${image_dir}"
            test_images+=("${image_name}")
            template+=\
"  ${image_dir}:
    build:
      context: ${REPO_DIR}/
      dockerfile: ./${TEST_DIR}/${image_dir}/Dockerfile
    image: ${image_name}
    container_name: ${image_name}
    volumes:
        - ${REPO_DIR}:/repo
"
    done
    echo "${template}" | tee "${COMPOSE_FILE}"

    docker-compose build

    rm "${COMPOSE_FILE}"

}

function main () {
    build_images
}


main
