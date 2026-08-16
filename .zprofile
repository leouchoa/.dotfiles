# Overal stuff
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$HOME/.config/zsh"
export EDITOR="nvim"

if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS-specific: Homebrew and VS Code
  eval "$(/opt/homebrew/bin/brew shellenv)"
  export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
fi

# Add tmux plugin
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH

# setup pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# Put pyenv shims on PATH without running an expensive rehash in every login.
eval "$(pyenv init --path --no-rehash zsh)"

# setup go and cargo
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH

# Enable image rendering in Neovim (image.nvim) even in tmux/zellij
export NVIM_IMAGE_ENABLE=1

# Added by Obsidian
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"
