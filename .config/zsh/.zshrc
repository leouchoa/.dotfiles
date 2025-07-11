# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
plugins=(
    # poetry
    git
    vi-mode
    docker
    fd
    docker-compose
    fzf-tab
    zsh-autosuggestions
    copypath
    copyfile
    web-search
    copybuffer
    jsontools
    kubectl
    pyenv
    gh
    # https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/aws
    aws
    golang
    # dbt
    # https://github.com/ziglang/shell-completions
    zig-shell-completions
    rust
    terraform
    gcloud
    # https://github.com/jeffreytse/zsh-vi-mode
    # some problems with entering the execute mode when pasting 
    # text with `:`
    # zsh-vi-mode
)

ZSH_WEB_SEARCH_ENGINES=(yt "https://www.youtube.com/results?search_query=")
source $ZSH/oh-my-zsh.sh

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "OSTYPE is $OSTYPE, sourcing zsh mac config" 
    source ~/.config/zsh/zshrc_mac
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "OSTYPE is $OSTYPE, sourcing zsh linux config" 
    source ~/.config/zsh/zshrc_linux
else
    echo "Unsupported operating system."
    exit 1
fi

if [ -f ~/.config/aliases ]; then
        . ~/.config/aliases
fi

# Custom commands
if [ -f ~/custom_script/custom_cmds ]; then
	. ~/custom_script/custom_cmds
fi
# Alias to attach to the last used tmux session
alias tt='$XDG_CONFIG_HOME/custom_scripts/tmux_attach_last_session.sh'
# alias podman_init='$XDG_CONFIG_HOME/custom_scripts/podman_init.sh'
source $XDG_CONFIG_HOME/custom_scripts/podman_init.sh
source $XDG_CONFIG_HOME/custom_scripts/global_rg.sh



# Enable vi mode
bindkey -v

# requires installation via git clone
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# t-smart-tmux-session-manager
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH

export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

eval "$(fzf --zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

source $HOME/.cargo/env
# https://unix.stackexchange.com/a/469851
autoload -U zmv

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/leonardopedreira/.docker/completions $fpath)
fpath=(~/.config/stripe $fpath)

autoload -Uz compinit && compinit

# export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Auto-select the default Node version for all new shells
nvm use default &> /dev/null
