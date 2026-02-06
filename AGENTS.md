# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a personal dotfiles repository managed with GNU Stow, containing configurations for:
- Neovim (primary editor, based on kickstart.nvim)
- Zellij (terminal multiplexer - primary driver)
- Tmux (terminal multiplexer - legacy, still configured)
- Zsh (shell with Oh-My-Zsh)
- WezTerm (terminal emulator)
- Karabiner (macOS keyboard customization)
- Git, Lazygit, and other CLI tools

### Alarm Clock Project

**IMPORTANT**: The `.config/alarm-clock/` directory is a **separate git repository** cloned locally for convenience. It is ignored in the dotfiles `.gitignore` and must NEVER be committed to this repository.

- **Repository**: Separate repo at `git@github.com:leouchoa/alarm-clock.git`
- **Purpose**: Rust + ratatui TUI alarm clock with future MCP integration
- **Location**: `.config/alarm-clock/` (gitignored)
- **Build**: `cd .config/alarm-clock && cargo build --release`
- **Binary**: `.config/alarm-clock/target/release/alarm-clock`

See `.config/alarm-clock/README.md` for full documentation.

## Installation & Deployment

The dotfiles are deployed using GNU Stow:

```bash
# Initial setup
git clone https://github.com/leouchoa/.dotfiles.git ~/.dotfiles
stow -d ~/.dotfiles -t ~ .
git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
bash .config/tmux/plugins/tpm/bin/install_plugins
```

After making changes, restow the configuration:
```bash
stow -R -d ~/.dotfiles -t ~ -v .
# Or use the alias
restow_dotfiles
```

Install packages with Homebrew:
```bash
brew bundle --v
```

Files ignored by Stow are defined in `.stow-local-ignore`.

## Neovim Configuration

### Architecture

The Neovim configuration is based on kickstart.nvim but heavily customized:

- **Entry point**: `nvim/init.lua` → requires `cfg` module
- **Core module**: `nvim/lua/cfg/init.lua` loads:
  - `cfg.options` - Neovim options
  - `cfg.keymaps` - Key mappings
  - `cfg.autocmds` - Autocommands
  - `cfg.lazy` - Plugin configuration (lazy.nvim)
  - `cfg.macros` - Custom macros

### Plugin Management

Uses lazy.nvim for plugin management. Main plugin config at `nvim/lua/cfg/lazy.lua`.

Plugins are modularized in `nvim/lua/cfg/plugins/`:
- LSP: Mason, LSP config, formatters (conform.nvim), linters
- Git: gitsigns, neogit, diffview, octo, git-conflict, gitlinker
- Navigation: telescope, harpoon, oil, nvim-tree
- UI: bufferline, lualine, noice, which-key
- Development: DAP (debugging), treesitter, autopairs
- Language-specific: go.nvim, dadbod (SQL), quarto, avante

### LSP & Formatters

Language servers managed via Mason:
- **Python**: basedpyright, black, isort, flake8
- **Go**: gopls, goimports
- **JavaScript/TypeScript**: ts_ls, eslint-lsp, prettier, biome
- **Lua**: lua_ls, stylua
- **Rust**: rust_analyzer, rustfmt
- **SQL**: sqlls, sqlfluff
- **Others**: clangd, html, cssls, terraformls, buf (protobuf)

Format on save is enabled (1000ms timeout). Use `<leader>lf` to manually format.

### Key Bindings

Leader key: `<Space>`

Notable custom bindings (from `nvim/lua/cfg/keymaps.lua`):
- `mm` - Save file (`:update`)
- `vv` - Close current buffer
- `<C-w><C-w>` - Open new vertical split
- `<C-w>b` - New empty buffer
- `<leader>e` - Toggle NvimTree
- `<leader>R` - Reload config
- Window navigation: `<C-h/j/k/l>`
- Buffer navigation: `<S-h/l>`

LSP mappings are defined in the LspAttach autocmd in `lazy.lua`.

## Zellij Configuration

**PRIMARY MULTIPLEXER**: Zellij is now the main terminal multiplexer for this setup.

Main config: `zellij/config.kdl`

### Structure

- `config.kdl` - Main configuration with keybindings and settings
- `themes/custom-dark.kdl` - Dark theme ported from tmux
- `layouts/` - Layout files for default setup and floating tools
  - `default.kdl` - Default layout with tab/status bars
  - `lazygit.kdl`, `yazi.kdl`, `lazydocker.kdl`, etc. - Tool-specific floating layouts

### Key Features

**Prefix Key**: `Ctrl-e` (matches tmux config for easy transition)

**Essential Keybindings** (Prefix + Key):
- `|` / `-` - Split panes (vertical/horizontal)
- `h/j/k/l` - Vim-like pane navigation
- `m` - Maximize/fullscreen pane
- `c` / `n` / `p` - Tab management (create/next/prev)
- `e` - Session manager (fzf-like)
- `R` - Resize mode
- `s` - Move/swap mode
- `/` - Search/scrollback mode

**Floating Tools** (Prefix + Key):
- `g` - Lazygit
- `f` - Yazi (file manager)
- `u` - Lazydocker
- `b` - Htop
- `;` - GitHub Dashboard
- `t` - Taskwarrior TUI
- `z` - Glow (markdown)
- `a` - Scratchpad

**Alternative Navigation** (No Prefix):
- `Alt-h/j/k/l` or `Alt-Arrow` - Move focus
- `Alt-n` - New pane
- `Ctrl-q` - Quit

### Installation

```bash
brew install zellij  # macOS
# Or: cargo install --locked zellij
```

Launch: `zellij` or `zellij attach -c session-name`

See `zellij/README.md` for comprehensive documentation, migration guide, and tips.

### Ported from Tmux

- All core keybindings maintained
- Custom dark theme with yellow active borders
- Floating popup workflows for tools
- Session management
- Vi-mode copy/search
- Pane and tab management

### Zellij Advantages

- Native floating panes (no plugin needed)
- Better default UI and aesthetics
- Faster and more responsive
- Built-in session manager
- Modern plugin system (WebAssembly)
- Easier configuration (KDL format)

## Tmux Configuration

**NOTE**: Tmux configuration is maintained but Zellij is now the primary driver.

Main config: `tmux/tmux.conf`

Structured configuration:
- `plugins.tmux.cfg` - Plugin declarations
- `bindings.tmux.cfg` - Key bindings
- `looks.tmux.cfg` - Visual appearance
- `plugins_cfg/` - Plugin-specific configs

Uses TPM (Tmux Plugin Manager). Install/update plugins:
```bash
<prefix> + I  # Install plugins
<prefix> + U  # Update plugins
```

Notable plugins:
- tmux-fzf-session-switch
- t-smart-tmux-session-manager
- tmux-logging
- tmux-menus

## Zsh Configuration

Main config: `.config/zsh/.zshrc`

### Platform-specific configs

The `.zshrc` detects OS and sources appropriate configs:
- macOS: `~/.config/zsh/zshrc_mac`
- WSL: `~/.config/zsh/zshrc_wsl`
- Linux: `~/.config/zsh/zshrc_linux`

### Shell initialization order

1. `.zprofile` (at repo root) - Environment setup
2. `.config/zsh/.zshrc` - Main zsh config
3. `.config/aliases` - Git and CLI aliases
4. Custom scripts from `custom_scripts/`

### Key tools configured

- **Oh-My-Zsh**: Plugin manager (robbyrussell theme)
- **pyenv**: Python version management with virtualenv
- **fzf**: Fuzzy finder integration
- **zoxide**: Smart directory jumping
- **direnv**: Environment variable management
- **nvm**: Node version manager

Plugins: git, vi-mode, docker, fzf-tab, zsh-autosuggestions, kubectl, aws, golang, terraform, gcloud, rust

### Custom aliases

See `.config/aliases` for full list. Notable ones:
- `qwe` → nvim
- `gt` → git status
- `gl` → git log with graph
- `tt` → attach to last tmux session
- `zz` → attach to last zellij session (primary multiplexer)
- `zl` → zellij-sessionizer (fuzzy find and switch projects, like tmux-sessionizer with 't')
- `restow_dotfiles` → restow configuration
- `mkpyenv` → create Python venv and activate
- `ls`/`l`/`la`/`ll` → eza with icons and git info

## Custom Scripts

Located in `.config/custom_scripts/`:

- `tmux_attach_last_session.sh` - Attach to most recent tmux session
- `zellij_attach_last_session.sh` - Attach to most recent zellij session (or create new)
- `podman_init.sh` - Initialize Podman machine
- `global_rg.sh` - Global ripgrep wrapper
- `delete_branches.sh` - Clean up git branches
- `pr_checkout.sh` - Checkout GitHub PR

Located in `~/.local/bin/`:

- `zellij-sessionizer` - Fuzzy find and switch between project directories (like tmux-sessionizer)
- `fzf-zellij` - Wrapper to make fzf open in Zellij floating panes

These are sourced/aliased in `.zshrc`.

## WezTerm Configuration

Config: `.config/wezterm/wezterm.lua`

- Font: Hack Nerd Font Mono (size 19)
- Color scheme: iTerm2 Dark Background
- Cursor: SteadyUnderline
- Window decorations: RESIZE only
- Starts maximized
- Custom status bar with workspace, process, and time

## Karabiner Configuration

macOS keyboard customizations at `.config/karabiner/karabiner.json`.

## Git Configuration

Located in `.config/git/` (check this directory for gitconfig, gitignore patterns).

## Development Workflow Notes

### Working with Neovim plugins

When adding/modifying plugins:
1. Edit `nvim/lua/cfg/lazy.lua` or create new file in `nvim/lua/cfg/plugins/`
2. Restart Neovim or run `:Lazy sync`
3. Check health with `:checkhealth`

### Working with shell config

1. Edit appropriate file in `.config/zsh/` or `.config/aliases`
2. Reload with `reload` alias or `source ~/.zshrc`
3. Restow if needed: `restow_dotfiles`

### Testing in Docker

A Dockerfile is provided to test the configuration:
```bash
docker build -t dev_env .
docker run -it dev_env
```

Note: Clipboard (xclip) doesn't work properly in Docker on macOS M1.

## Platform Support

Primary platform: macOS
Secondary platforms: WSL, Linux (Ubuntu/Debian/Fedora/Arch)

The configuration adapts based on `$OSTYPE` detection in zsh config.
