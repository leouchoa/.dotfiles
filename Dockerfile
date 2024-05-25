# Targets ubuntu, probably not working for macos or anything else

FROM python:3.12-slim

# triggered by z, but essential for many other ones
ENV PATH="/root/.local/bin/:${PATH}"

# pyenv
ENV PYTHON_VERSION 3.12
ENV PYENV_ROOT="$HOME/.pyenv"
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"
# Node
ENV NVM_DIR /root/.nvm
ENV NODE_VERSION 22.1.0
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"


WORKDIR /root/

RUN apt-get update && \
  apt-get install -y \ 
  ninja-build gettext libtool libtool-bin \
  autoconf automake cmake g++ pkg-config \
  unzip git dpkg xclip \
  gcc build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
  curl libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
  apt-transport-https ca-certificates curl gnupg2 software-properties-common \
  glibc-source \
  font-config \
  wget \
  htop \
  nnn \
  ripgrep \
  tmux \
  exa \
  bat \
  fd-find \
  stow \
  zsh && \
  chsh -s $(which zsh)

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

RUN git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab && \
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
  rm ~/.zshrc

RUN git clone https://github.com/neovim/neovim && cd neovim && git checkout stable && make install

RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"&& \
  tar xf lazygit.tar.gz lazygit && \
  install lazygit /usr/local/bin

RUN curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash 

RUN curl https://pyenv.run | bash 

RUN pyenv install ${PYTHON_VERSION} && pyenv global ${PYTHON_VERSION}

# attention to switch this to .zshrc when using zsh
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
  && . $NVM_DIR/nvm.sh \
  && nvm install $NODE_VERSION \
  && nvm alias default $NODE_VERSION \
  && nvm use default

RUN curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# idk how to solve this problem to install git-delta, curl corrupts stuff ....
# RUN curl https://github.com/dandavison/delta/releases/download/0.17.0/git-delta_0.17.0_amd64.deb -o delta.deb && dpkg -i delta.deb

RUN git clone -b stow https://github.com/leouchoa/.dotfiles /root/.dotfiles && \
  stow -d ~/.dotfiles .

# Auto-install of tmux plugins not working, gonna install there.
# For more info, check second-to-last cmd of ~/.config/tmux/tmux.conf
RUN git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm && \
  bash .config/tmux/plugins/tpm/bin/install_plugins

ENTRYPOINT ["tmux", "new", "-s"]
CMD ["main"]
