FROM ubuntu:bionic

ARG packages="sudo"

ENV TERM xterm-256color

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes ${packages} > /dev/null

ADD . /repo
WORKDIR /repo

RUN ./setup.sh
