# New Mac Setup Guide

This guide will help you set up your new Mac with all your configurations and tools.

## Prerequisites

1. Install Xcode Command Line Tools:
   ```bash
   xcode-select --install
   ```

2. Install Homebrew:
   ```bash
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

## Step 1: Clone Dotfiles

```bash
git clone https://github.com/leouchoa/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

## Step 2: Install Homebrew Packages

```bash
brew bundle --file ~/.dotfiles/.config/Brewfile --v
```

This will install all formulae and casks defined in the Brewfile.

## Step 3: Deploy Dotfiles with Stow

```bash
stow -d ~/.dotfiles -t ~ -v .
```

## Step 4: Critical Workflow Tools Setup

### 4.1 Tmux Plugin Manager (TPM)

```bash
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
```

Then open tmux and install plugins:
```bash
tmux
# Press: <prefix> + I (capital i)
```

### 4.2 t-smart-tmux-session-manager

The `t` script is already installed via TPM in `~/.config/tmux/plugins/t-smart-tmux-session-manager/bin/t`

Your `.zprofile` should already have this in PATH (from stowed dotfiles):
```bash
export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
```

**Alternative: Install sesh (modern Go rewrite)**

The original `t` project has been rewritten in Go as `sesh`. Consider installing it:
```bash
brew install joshmedeski/sesh/sesh
```

Then update your shell aliases to use `sesh` instead of `t`:
```bash
# In your .zshrc or aliases file
alias t='sesh'
```

### 4.3 Zellij Sessionizer

Your custom `zellij-sessionizer` script should be in `~/.local/bin/` (stowed from dotfiles).

Ensure `~/.local/bin` is in your PATH:
```bash
export PATH="$HOME/.local/bin:$PATH"
```

Aliases (should already be in your `.config/aliases`):
```bash
alias zl='zellij-sessionizer'
alias zz='zellij_attach_last_session.sh'
```

### 4.4 GitHub CLI Extensions

```bash
gh auth login  # Authenticate first
gh extension install dlvhdr/gh-dash
```

### 4.5 Oh-My-Zsh Plugins

```bash
# fzf-tab
git clone https://github.com/Aloxaf/fzf-tab ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/fzf-tab

# zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

## Step 5: Python Setup

```bash
# Install Python versions
pyenv install 3.12
pyenv global 3.12

# Verify
python --version
```

## Step 6: Node.js Setup

```bash
# NVM should be configured via your .zshrc
# Install Node versions
nvm install 22
nvm use 22
nvm alias default 22
```

## Step 7: Zellij Setup (Primary Multiplexer)

Zellij should already be installed via Homebrew.

```bash
# Launch zellij
zellij

# Or attach to last session
zz  # alias for zellij_attach_last_session.sh
```

Your Zellij config is at `~/.config/zellij/config.kdl`

## Step 8: Ghostty Terminal Setup

See `GHOSTTY_MIGRATION.md` for detailed configuration instructions.

Quick start:
```bash
# Ghostty config location
~/.config/ghostty/config
```

## Step 9: Neovim Setup

```bash
# Launch Neovim (will auto-install plugins via lazy.nvim)
nvim

# Or use your alias
qwe  # alias for nvim
```

First launch will install all plugins automatically. Wait for completion.

Check health:
```bash
nvim
:checkhealth
```

## Step 10: Verify Everything

Run these commands to verify your setup:

```bash
# Shell
echo $SHELL  # Should be /bin/zsh or similar

# Multiplexers
tmux -V
zellij --version

# Editors
nvim --version
code --version  # if using VSCode

# Version managers
pyenv --version
nvm --version

# Git tools
gh --version
lazygit --version

# Custom scripts
which t  # Should point to t-smart-tmux-session-manager or sesh
which zellij-sessionizer  # Should be in ~/.local/bin
which fzf-zellij  # Should be in ~/.local/bin

# Aliases
alias | grep -E '(qwe|gt|zz|tt)'
```

## Important Workflows to Test

1. **Tmux Session Management with `t`**:
   ```bash
   t  # Should open fzf with sessions and zoxide results
   ```

2. **Zellij Session Management**:
   ```bash
   zz  # Attach to last zellij session
   zl  # Open zellij-sessionizer (fuzzy find projects)
   ```

3. **Git Workflows**:
   ```bash
   lazygit  # Terminal UI for git
   gh dash  # GitHub dashboard
   ```

4. **Neovim**:
   ```bash
   qwe  # Open neovim
   # Inside nvim:
   # <leader>e - Toggle NvimTree
   # <leader>ff - Find files (Telescope)
   # <leader>lg - Lazygit
   ```

## Troubleshooting

### `t` command not found

1. Check if TPM installed the plugin:
   ```bash
   ls ~/.config/tmux/plugins/t-smart-tmux-session-manager
   ```

2. Check PATH:
   ```bash
   echo $PATH | grep t-smart-tmux-session-manager
   ```

3. Manually add to PATH in `~/.zprofile`:
   ```bash
   export PATH=$HOME/.config/tmux/plugins/t-smart-tmux-session-manager/bin:$PATH
   ```

4. Or install `sesh` as alternative:
   ```bash
   brew tap joshmedeski/sesh
   brew install sesh
   ```

### Neovim plugins not installing

```bash
nvim
:Lazy sync
```

### Tmux plugins not working

```bash
# Remove and reinstall
rm -rf ~/.config/tmux/plugins
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm

# Open tmux and install
tmux
# Press: <prefix> + I
```

### Zellij keybindings not working

Check your config:
```bash
cat ~/.config/zellij/config.kdl
```

Prefix should be `Ctrl-e` (matching tmux for easy transition).

## Optional: Additional Tools

### Fonts

Nerd Fonts should be installed via Homebrew, but verify in your terminal:
- Font: Hack Nerd Font Mono
- Size: 19 (adjust for your display)

### Karabiner (macOS Keyboard Customization)

Your config is at `~/.config/karabiner/karabiner.json`

Install Karabiner-Elements from:
https://karabiner-elements.pqrs.org/

Then restart and your config should be loaded.

## Alarm Clock Project (Separate Repo)

The `alarm-clock` project is a separate Git repository. Clone it:

```bash
cd ~/.config
git clone git@github.com:leouchoa/alarm-clock.git
cd alarm-clock
cargo build --release
```

Binary will be at: `~/.config/alarm-clock/target/release/alarm-clock`

**IMPORTANT**: This is gitignored in the main dotfiles repo. Never commit it to `.dotfiles`.

## Final Steps

1. Restart your terminal
2. Test all aliases and custom scripts
3. Open tmux/zellij and verify keybindings
4. Launch Neovim and verify LSPs are working
5. Run `restow_dotfiles` alias to verify stow setup

## Quick Reference

### Essential Aliases
- `qwe` - Open Neovim
- `gt` - Git status
- `gl` - Git log with graph
- `tt` - Attach to last tmux session
- `zz` - Attach to last zellij session
- `zl` - Zellij sessionizer (fuzzy find projects)
- `restow_dotfiles` - Restow configuration
- `ls`/`l`/`la`/`ll` - eza with icons

### Essential Keybindings

**Zellij (Primary Multiplexer)**
- Prefix: `Ctrl-e`
- `<prefix> g` - Lazygit
- `<prefix> f` - Yazi (file manager)
- `<prefix> |/-` - Split panes
- `<prefix> h/j/k/l` - Navigate panes

**Tmux (Legacy)**
- Prefix: `Ctrl-b`
- Similar keybindings as Zellij

**Neovim**
- Leader: `<Space>`
- `mm` - Save file
- `vv` - Close buffer
- `<leader>e` - Toggle file tree

## Backup Your Old Config (Before Fresh Install)

On your old Mac, backup these critical files/dirs:
```bash
# Essential configs
~/.config/
~/.dotfiles/
~/.zprofile
~/.gitconfig

# SSH keys
~/.ssh/

# GPG keys
~/.gnupg/

# Application-specific
~/.local/bin/
~/.aws/
~/.kube/
```

---

**You're all set! Happy coding on your new Mac! 🚀**
