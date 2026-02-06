# ================================
# Development Environment Dockerfile
# ================================
# Targets Ubuntu - replicates macOS dotfiles setup
# For testing dotfiles in a clean environment
#
# Build: docker build -f .config/Dockerfile -t dev_env .
# Run:   docker run -it dev_env
# ================================

FROM python:3.12-slim

# ================================
# Environment Variables
# ================================

# Timezone
ENV TZ=UTC

# Path additions
ENV PATH="/root/.local/bin/:${PATH}"

# Python (pyenv)
ENV PYTHON_VERSION=3.12
ENV PYENV_ROOT="$HOME/.pyenv"
ENV PATH="$PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH"

# Node.js (nvm)
ENV NVM_DIR=/root/.nvm
ENV NODE_VERSION=22.1.0
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"

# ================================
# System Dependencies
# ================================

WORKDIR /root/

RUN apt-get update && \
    apt-get install -y \
    # Build essentials
    build-essential gcc g++ make cmake autoconf automake \
    libtool libtool-bin pkg-config unzip gettext \
    # Neovim build dependencies
    ninja-build gettext libtool libtool-bin \
    # Python build dependencies
    libssl-dev zlib1g-dev libbz2-dev libreadline-dev \
    libsqlite3-dev curl libncursesw5-dev xz-utils tk-dev \
    libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev \
    # System utilities
    git wget curl software-properties-common \
    ca-certificates apt-transport-https gnupg2 \
    # CLI tools
    htop tmux zsh ripgrep bat fd-find stow fontconfig \
    # Additional tools
    xclip glibc-source \
    && rm -rf /var/lib/apt/lists/*

# ================================
# Shell Setup
# ================================

# Install Oh-My-Zsh
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Install zsh plugins
RUN git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab && \
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# Set zsh as default shell
RUN chsh -s $(which zsh)

# ================================
# Core Tools
# ================================

# fzf (fuzzy finder)
RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && \
    ~/.fzf/install --all

# ================================
# Neovim
# ================================

RUN git clone https://github.com/neovim/neovim /tmp/neovim && \
    cd /tmp/neovim && \
    git checkout stable && \
    make CMAKE_BUILD_TYPE=RelWithDebInfo && \
    make install && \
    cd / && rm -rf /tmp/neovim

# ================================
# Git Tools
# ================================

# Lazygit
RUN LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*') && \
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" && \
    tar xf lazygit.tar.gz lazygit && \
    install lazygit /usr/local/bin && \
    rm lazygit lazygit.tar.gz

# Lazydocker
RUN curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash

# ================================
# Programming Languages
# ================================

# Python (pyenv)
RUN curl https://pyenv.run | bash && \
    pyenv install ${PYTHON_VERSION} && \
    pyenv global ${PYTHON_VERSION}

# Node.js (nvm)
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash && \
    . $NVM_DIR/nvm.sh && \
    nvm install $NODE_VERSION && \
    nvm alias default $NODE_VERSION && \
    nvm use default

# ================================
# Additional CLI Tools
# ================================

# zoxide (smart cd)
RUN curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh

# eza (modern ls)
RUN wget -c https://github.com/eza-community/eza/releases/latest/download/eza_x86_64-unknown-linux-gnu.tar.gz -O - | tar xz && \
    mv eza /usr/local/bin/

# Zellij (terminal multiplexer)
RUN wget -c https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz -O - | tar xz && \
    mv zellij /usr/local/bin/

# ================================
# Dotfiles Deployment
# ================================

# Clone dotfiles repository
RUN git clone -b stow https://github.com/leouchoa/.dotfiles /root/.dotfiles

# Deploy with stow
RUN cd /root/.dotfiles && stow -d . -t ~ -v .

# ================================
# Tmux Setup
# ================================

# Install TPM (Tmux Plugin Manager)
RUN git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Auto-install tmux plugins
RUN bash ~/.config/tmux/plugins/tpm/bin/install_plugins

# ================================
# Final Setup
# ================================

# Create workspace directories
RUN mkdir -p ~/projects ~/workspace ~/.local/bin

# Set up zsh as default entrypoint
ENV SHELL=/bin/zsh

# ================================
# Entry Point
# ================================

# Default: Start zellij session (primary multiplexer)
# Alternative: Start tmux session
#
# Usage:
#   docker run -it dev_env              # Start zellij
#   docker run -it dev_env tmux         # Start tmux
#   docker run -it dev_env zsh          # Start zsh only

ENTRYPOINT ["zellij", "attach", "-c"]
CMD ["dev"]

# ================================
# Build & Run Instructions
# ================================
#
# Build the image:
#   docker build -f .config/Dockerfile -t dev_env .
#
# Run with zellij (default):
#   docker run -it dev_env
#
# Run with tmux:
#   docker run -it --entrypoint tmux dev_env new -s dev
#
# Run with just zsh:
#   docker run -it --entrypoint zsh dev_env
#
# Run with volume mounts (persist work):
#   docker run -it -v ~/projects:/root/projects dev_env
#
# Run with custom session name:
#   docker run -it dev_env my-session
#
# ================================
# Notes
# ================================
#
# 1. Clipboard (xclip) may not work properly in Docker on macOS M1
# 2. GPU acceleration not available in Docker (affects terminal rendering)
# 3. Fonts may not render perfectly without X11 forwarding
# 4. For full testing, use a Linux VM or native macOS
# 5. Zellij is the primary multiplexer (faster, more modern)
# 6. Tmux is still available for compatibility
#
# ================================
