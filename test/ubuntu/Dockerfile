FROM ubuntu:bionic

ARG packages="sudo apt-utils locales"

ENV TERM xterm-256color
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install --yes ${packages} > /dev/null

ADD . /repo
WORKDIR /repo

RUN ./setup.sh
