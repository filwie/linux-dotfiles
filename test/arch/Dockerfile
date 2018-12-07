FROM archlinux/base

ARG packages="base-devel sudo which"

ENV TERM xterm-256color
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
RUN locale-gen
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

RUN pacman -Syu --noconfirm \
        && pacman -Sy --noconfirm ${packages} > /dev/null

ADD . /repo
WORKDIR /repo

RUN ./setup.sh
