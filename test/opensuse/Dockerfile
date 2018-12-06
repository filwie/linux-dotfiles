FROM opensuse/tumbleweed

ARG packages="sudo which"

ENV TERM xterm-256color
RUN zypper --non-interactive in ${packages} > /dev/null

ADD . /repo
WORKDIR /repo

RUN ./setup.sh
