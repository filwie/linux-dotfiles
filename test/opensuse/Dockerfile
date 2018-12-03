FROM opensuse/tumbleweed

ARG packages="sudo which"

ENV TERM xterm-256color
RUN zypper --non-interactive in ${packages} > /dev/null

WORKDIR /tmp

ADD https://gitlab.com/filip.wiechec/dotfiles/raw/master/setup.sh .

RUN bash setup.sh
