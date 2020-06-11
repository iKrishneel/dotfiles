FROM ubuntu:focal
MAINTAINER krishneel

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /home/krishneel/
ENV HOME /home/krishneel/
ENV SHELL /bin/zsh
ENV HOSTNAME krishneel

RUN apt-get update && apt-get install -y\
        zsh \
        emacs \
        wget \
        git \
        curl \
        fontconfig \
        locales \
        python3-dev \
        python3-setuptools \
        python3-pip \
        wget \
        zsh \
        && pip3 install virtualenv \
        && wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
        && git clone https://github.com/iKrishneel/dotfiles.git .dotfiles\
        && cp -r .dotfiles/.emacs . \
        && emacs --daemon \
        && rm -rf /var/lib/apt/lists/*

CMD tail -f /dev/null
Dockerfile (END)
