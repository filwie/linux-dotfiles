FROM base/devel

ARG packages="sudo which"

ENV TERM xterm-256color

RUN pacman -Sy --noconfirm ${packages} > /dev/null

ADD . /repo
WORKDIR /repo

RUN ./setup.sh
