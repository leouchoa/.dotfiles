# Dotfiles

## Installation

```bash
git clone https://github.com/leouchoa/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

This bootstrap is idempotent and handles:
- Homebrew package install from `.config/Brewfile`
- Oh My Zsh install (if missing)
- Required Oh My Zsh plugins (`fzf-tab`, `zsh-autosuggestions`)
- TPM install + tmux plugin install
- macOS key repeat tuning (`snappy` profile by default)
- Dotfiles stow + post-install checks (`Ctrl-r`, tab completion)

Optional installer overrides:
- `MAC_KEY_REPEAT_PROFILE=balanced|snappy|teleport` (default: `snappy`)
- `SKIP_MAC_KEY_REPEAT=1` to skip key repeat tuning

Health check only (no changes):

```bash
./install.sh --doctor
```

Manual setup is still available in `.config/NEW_MAC_SETUP.md`.

Quick key repeat commands after setup:
- `keyrepeat-status`
- `keyrepeat-snappy`
- `keyrepeat-teleport`
- `keyrepeat-reset`

To make your changes take effect after edits, restow your config:

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
