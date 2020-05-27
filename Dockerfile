FROM ubuntu:focal
MAINTAINER krishneel

ENV DEBIAN_FRONTEND noninteractive

WORKDIR /home/krishneel/
ENV HOME /home/krishneel/
ENV SHELL /bin/zsh
ENV HOSTNAME krishneel

RUN apt-get update && apt-get install -y\
	tmux \
	fonts-powerline \
	emacs \
	wget \
	git \
	curl \
	python3-pip \
	zsh \
	&& pip3 install virtualenv jedi\
	&& wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
	&& rm -rf /var/lib/apt/lists/*

RUN pip3 install --user git+git://github.com/powerline/powerline &&\
	wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf && \
	wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

RUN mkdir -p  ~/.fonts && mv PowerlineSymbols.otf ~/.fonts/ && \
	fc-cache -vf ~/.fonts/ && mkdir -p ~/.config/fontconfig/conf.d/ && \
	mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

COPY ./ .dotfiles
RUN cp -r .dotfiles/.emacs . \
	&& emacs --daemon 

CMD tail -f /dev/null
