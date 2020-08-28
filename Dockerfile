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
        tmux \
        && pip3 install virtualenv \
        && wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
	&& git clone https://github.com/iKrishneel/dotfiles.git .dotfiles\
	&& pip3 install cpplint \
        && cp -r .dotfiles/.emacs . \
        && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/akash-akya/emacs-flymake-cursor.git $HOME.emacs.d/emacs-flymake-cursor
RUN emacs --daemon

RUN git clone https://github.com/gpakosz/.tmux.git && \
	ln -s -f .tmux/.tmux.conf && \
	cp .tmux/.tmux.conf.local .

RUN echo '\n[[ $- != *i* ]] && return \n[[ -z "$TMUX" ]] && exec tmux\n' >> $HOME/.zshrc

CMD tail -f /dev/null
