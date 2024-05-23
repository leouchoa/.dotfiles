#!/bin/bash

# Navigate to the dotfiles directory
cd "$HOME/.dotfiles" || exit

# Check the operating system
if [[ "$OSTYPE" == "darwin"* ]]; then
    # macOS
    stow -t ~ -S zsh_mac
    echo "source ~/.zshrc_mac" > ~/.zshrc
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    # Linux
    stow -t ~ -S zsh
    echo "source ~/.zshrc" > ~/.zshrc
else
    echo "Unsupported operating system."
    exit 1
fi

