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
	byobu \
	&& pip3 install virtualenv \
	&& sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
	# && wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true \
	&& git clone https://github.com/iKrishneel/dotfiles.git .dotfiles\
	&& pip3 install --upgrade cpplint black flake8 \
	&& cp -r .dotfiles/.emacs . && cp -r .dotfiles/.p10k.zsh . \
        && rm -rf /var/lib/apt/lists/*

RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k \
	&& git clone https://github.com/akash-akya/emacs-flymake-cursor.git $HOME.emacs.d/emacs-flymake-cursor

SHELL ["/bin/bash", "-c"]
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/g' $HOME/.zshrc
RUN echo "[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh" >> $HOME/.zshrc && \
	echo "export TERM=xterm-256color" >> $HOME/.zshrc

RUN emacs --daemon

CMD tail -f /dev/null
