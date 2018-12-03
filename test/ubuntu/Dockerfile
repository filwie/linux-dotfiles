FROM ubuntu:bionic

ARG packages="sudo"

ENV TERM xterm-256color

RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install --yes ${packages} > /dev/null

WORKDIR /tmp

ADD https://gitlab.com/filip.wiechec/dotfiles/raw/master/setup.sh .

RUN bash setup.sh
