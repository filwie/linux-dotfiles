FROM base/devel

ARG packages="sudo which"

ENV TERM xterm-256color

RUN pacman -Sy --noconfirm ${packages} > /dev/null

WORKDIR /tmp

ADD https://gitlab.com/filip.wiechec/dotfiles/raw/master/setup.sh .

RUN bash setup.sh
