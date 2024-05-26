# Dotfiles

## Instalation

```bash
git clone https://github.com/leouchoa/.dotfiles.git ~/.dotfiles
stow -d ~/.dotfiles -t ~ .
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
bash .config/tmux/plugins/tpm/bin/install_plugins
```

To make your changes take effect, restow your config:

```bash
stow -R -d ~/.dotfiles -t ~ -v .
```

## Docker

You can try the config with:

```bash
docker build -t dev_env .
docker run -it dev_env
```

Attention: the `neovim` clipboard yanking/pasting is not working inside the
docker container, when emulating through macos-m1. Yes I have xclip installed
inside the container.
