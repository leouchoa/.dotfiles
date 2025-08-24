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
eval "$(pyenv init --path)"

# setup go and cargo
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$PATH
export PATH="$HOME/.cargo/bin:$PATH"
