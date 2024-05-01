FROM python:3.12-slim

ENV PYTHON_VERSION 3.12
ENV PYENV_ROOT="$HOME/.pyenv"
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

RUN apt-get update && \
  apt-get install -y \ 
  ninja-build gettext libtool libtool-bin \
  autoconf automake cmake g++ pkg-config \
  unzip git dpkg ripgrep xclip \
  gcc build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev \
  curl libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
  apt-transport-https ca-certificates curl gnupg2 software-properties-common 


RUN git clone https://github.com/neovim/neovim && cd neovim && git checkout stable && make install

RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"&& \
  tar xf lazygit.tar.gz lazygit && \
  install lazygit /usr/local/bin

RUN git clone https://github.com/nvim-lua/kickstart.nvim.git "${XDG_CONFIG_HOME:-$HOME/.config}"/nvim

# RUN curl https://pyenv.run | bash | exec "$SHELL"
RUN curl https://pyenv.run | bash 

RUN pyenv install ${PYTHON_VERSION} && pyenv global ${PYTHON_VERSION}

ENTRYPOINT [ "nvim" , "file.txt"]
# ENTRYPOINT ["sleep 10000"]
