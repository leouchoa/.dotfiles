# New Mac Setup

Use this as the default install path on a fresh macOS machine.

## Quick Start

```bash
xcode-select --install
# wait for install to finish, then:

git clone https://github.com/leouchoa/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

`install.sh` is idempotent, so you can rerun it safely.

## What `install.sh` Automates

1. Installs Homebrew (if missing).
2. Installs packages from `~/.dotfiles/.config/Brewfile`.
3. Installs Oh My Zsh (if missing).
4. Installs required Oh My Zsh plugins:
   - `fzf-tab`
   - `zsh-autosuggestions`
5. Stows dotfiles with:
   - `stow -R -d ~/.dotfiles -t ~ -v .`
6. Installs TPM + tmux plugins.
7. Installs `gh-dash` when `gh` is authenticated.
8. Applies macOS key repeat profile (`snappy` by default).
9. Runs post-install checks for:
   - `Ctrl-r` -> `fzf-history-widget`
   - `Tab` -> `fzf-tab-complete`
   - Ghostty config validation

Installer env overrides:
- `MAC_KEY_REPEAT_PROFILE=balanced|snappy|teleport` (default `snappy`)
- `SKIP_MAC_KEY_REPEAT=1` to skip key repeat tuning

## Doctor Mode (Checks Only)

Use this when you suspect setup drift and want diagnostics without making changes:

```bash
cd ~/.dotfiles
./install.sh --doctor
```

## Verification

```bash
zsh -i -c 'bindkey "^R"; bindkey "^I"; bindkey -M viins "^I"'
which zellij
which nvim
which lazygit
which gh
ghostty +validate-config --config-file ~/.config/ghostty/config
```

Expected keybinding output includes:
- `fzf-history-widget` for `^R`
- `fzf-tab-complete` for `^I`

## Manual Steps That May Still Be Needed

```bash
gh auth login
nvm install 22 && nvm alias default 22
pyenv install 3.12 && pyenv global 3.12
nvim
```

## Key Repeat Commands

```bash
keyrepeat-status
keyrepeat-snappy
keyrepeat-teleport
keyrepeat-reset
```

After applying/resetting key repeat, log out and back in for consistent system-wide behavior.

## Troubleshooting

### Xcode CLT never finishes

```bash
sudo rm -rf /Library/Developer/CommandLineTools
xcode-select --install
```

### `Ctrl-r` or tab completion still wrong

```bash
source ~/.config/zsh/.zshrc
zsh -i -c 'bindkey "^R"; bindkey "^I"; bindkey -M viins "^I"'
```

### tmux plugins not installed

```bash
~/.config/tmux/plugins/tpm/bin/install_plugins
```

### Dry run installer

```bash
cd ~/.dotfiles
./install.sh --dry-run
```
