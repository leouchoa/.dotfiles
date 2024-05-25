# Dotfiles

## Instalation

```bash
git clone https://github.com/leouchoa/.dotfiles.git ~/.dotfiles
stow -d ~/.dotfiles -t ~ .
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
