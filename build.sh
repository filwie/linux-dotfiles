#!/usr/bin/env zsh

REPO_DIR="${0:a:h}"
TEST_DIR="${REPO_DIR}/test"

function kek () {
    generate_compose_file
    docker-compose up --build
    rm "${COMPOSE_FILE}"
}

kek
