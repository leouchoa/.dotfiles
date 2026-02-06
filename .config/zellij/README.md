# Zellij Configuration

This is a comprehensive Zellij configuration ported from the tmux setup. The configuration maintains familiar keybindings and workflows while leveraging Zellij's modern features.

## Installation

Install Zellij on macOS:
```bash
brew install zellij
```

Or on Linux:
```bash
cargo install --locked zellij
```

After cloning this dotfiles repo, the Zellij config will be available at `~/.config/zellij/`.

## Quick Start

Launch Zellij:
```bash
zellij
# Or use the alias (attaches to last session or creates 'main')
zz

# Or use the sessionizer (fuzzy find projects)
zl
```

Launch with a specific session name:
```bash
zellij attach -c mysession
```

List sessions:
```bash
zellij list-sessions
```

## Aliases

- **`zz`** - Attach to last Zellij session or create 'main' session
- **`zl`** - Launch zellij-sessionizer (fuzzy find and switch between projects)

## Key Bindings

### Prefix Key
The prefix key is **`Ctrl-e`** (matching the tmux configuration). Press `Ctrl-e` to enter tmux mode, then press another key for the command.

### Essential Keybindings (Prefix + Key)

#### Pane Management
- `Ctrl-e` then `|` - Split pane vertically (right)
- `Ctrl-e` then `-` - Split pane horizontally (down)
- `Ctrl-e` then `x` - Close current pane
- `Ctrl-e` then `m` - Maximize/fullscreen current pane
- `Ctrl-e` then `q` - Cycle to next pane

#### Navigation (Vim-style)
- `Ctrl-e` then `h` - Move focus left
- `Ctrl-e` then `j` - Move focus down
- `Ctrl-e` then `k` - Move focus up
- `Ctrl-e` then `l` - Move focus right

#### Alternative Navigation (No Prefix)
- `Alt-h` or `Alt-Left` - Move focus left
- `Alt-j` or `Alt-Down` - Move focus down
- `Alt-k` or `Alt-Up` - Move focus up
- `Alt-l` or `Alt-Right` - Move focus right
- `Alt-n` - New pane

#### Tab Management
- `Ctrl-e` then `c` - Create new tab
- `Ctrl-e` then `n` - Go to next tab
- `Ctrl-e` then `p` - Go to previous tab
- `Ctrl-e` then `^` - Go to last tab
- `Ctrl-e` then `1-9` - Go to tab by number
- `Ctrl-e` then `,` - Rename current tab
- `Ctrl-e` then `Left` - Swap tab left
- `Ctrl-e` then `Right` - Swap tab right

#### Session Management
- `Ctrl-e` then `e` - Session manager (fzf-like interface)
- `Ctrl-e` then `i` - Session manager (switch to last session)
- `Ctrl-e` then `d` - Detach from session

#### Pane Resizing
- `Ctrl-e` then `R` - Enter resize mode
  - In resize mode:
    - `h/j/k/l` - Increase size in direction
    - `H/J/K/L` - Decrease size in direction
    - `=` - Increase all
    - `-` - Decrease all
    - `Esc` or `Enter` - Exit resize mode

#### Pane Movement/Swapping
- `Ctrl-e` then `s` - Enter move mode
  - In move mode:
    - `h/j/k/l` - Move pane in direction
    - `n` - Move pane forward
    - `p` - Move pane backward
    - `Esc` or `Enter` - Exit move mode

#### Floating Tool Windows
All tools open in floating windows (like tmux popups):

- `Ctrl-e` then `a` - Scratchpad (floating terminal)
- `Ctrl-e` then `g` - Lazygit (git TUI)
- `Ctrl-e` then `f` - Win (matches tmux binding)
- `Ctrl-e` then `y` - Yazi (file manager)
- `Ctrl-e` then `u` - Lazydocker (Docker TUI)
- `Ctrl-e` then `b` - Htop (system monitor)
- `Ctrl-e` then `;` - GitHub Dashboard (gh dash)
- `Ctrl-e` then `t` - Taskwarrior TUI
- `Ctrl-e` then `v` - Glow (markdown reader)

**Note**: Zellij's floating windows have automatic sizing and centering. They will not be truly "fullscreen" like tmux popups, but will be large centered windows. To hide floating windows, press `?` or `Ctrl-e` then `<?>` to see the hint.

#### Scrollback/Copy Mode
- `Ctrl-e` then `/` - Enter search mode
  - In search mode:
    - `j/k` - Scroll down/up
    - `Ctrl-f` / `PageDown` - Page down
    - `Ctrl-b` / `PageUp` - Page up
    - `d` - Half page down
    - `u` - Half page up
    - `n` - Search next
    - `N` - Search previous
    - `c` - Toggle case sensitivity
    - `w` - Toggle whole word
    - `o` - Toggle wrap
    - `Esc` - Exit search mode

#### Configuration
- `Ctrl-e` then `r` - Reload configuration
- `Ctrl-q` - Quit Zellij

## Configuration Structure

```
.config/zellij/
├── config.kdl              # Main configuration file
├── themes/
│   └── custom-dark.kdl     # Custom dark theme (from tmux)
└── layouts/
    ├── default.kdl         # Default layout
    ├── lazygit.kdl         # Lazygit floating layout
    ├── yazi.kdl            # Yazi floating layout
    ├── lazydocker.kdl      # Lazydocker floating layout
    ├── htop.kdl            # Htop floating layout
    ├── gh-dash.kdl         # GitHub Dashboard floating layout
    ├── taskwarrior.kdl     # Taskwarrior floating layout
    └── glow.kdl            # Glow floating layout

~/.local/bin/
├── zellij-sessionizer      # Project fuzzy finder (like tmux-sessionizer)
└── fzf-zellij              # fzf wrapper for Zellij floating panes

~/.local/share/zellij/plugins/
└── zellij-switch.wasm      # Session switching plugin
```

## Integrations

### Zellij Sessionizer

A fuzzy finder-powered project switcher (inspired by ThePrimeagen's tmux-sessionizer):

**Usage**:
```bash
zl  # alias for zellij-sessionizer
```

**Configuration**: Edit search paths in `.zshrc`:
```bash
export ZELLIJ_SESSIONIZER_SEARCH_PATHS="$HOME/code $HOME/work $HOME/Projects"
export ZELLIJ_SESSIONIZER_SPECIFIC_PATHS="$HOME/.dotfiles $HOME/.config"
```

**Features**:
- Fuzzy search through your project directories
- Automatically creates or switches to named sessions
- Sets working directory to selected project
- Replaces the tmux 't' keybinding workflow

### fzf-Zellij Integration

All fzf commands (like `Ctrl-r`, `Ctrl-t`) now open in Zellij floating panes automatically.

**Configuration**: Already set up in `.zshrc` with the fzf wrapper function.

**Environment variables** (optional customization):
```bash
export FZF_ZELLIJ_HEIGHT="80%"
export FZF_ZELLIJ_WIDTH="80%"
export FZF_ZELLIJ_X="10%"
export FZF_ZELLIJ_Y="10%"
```

## Theme

The custom dark theme is based on the tmux configuration:
- Background: `#333333`
- Foreground: `#ffffff`
- Active pane border: Yellow (`#e5c07b`)
- Status bar positioned at bottom

## Features Ported from Tmux

### ✅ Fully Ported
- Prefix key (`Ctrl-e`)
- Pane splitting and navigation (vim-style)
- Pane maximization
- Tab/window management
- Session management
- Vi-mode copy/search
- Floating popups for tools
- Custom key bindings
- Dark theme with yellow active border

### ⚠️ Partially Ported / Different Implementation
- **Pane pinning** - Not natively supported in Zellij. Use tab focus instead.
- **Tmux plugins** - Zellij has its own plugin system (WASM-based). Session manager plugin is built-in.
- **Alarm clock integration** - Status bar customization differs. Can be added via custom plugins.
- **Pomodoro timer** - Not ported. Can be added via custom plugin.
- **Network speed indicator** - Not ported. Can be added via custom plugin.

### 🔄 Zellij Advantages Over Tmux
- Better default UI with cleaner aesthetics
- Built-in floating panes (no plugin needed)
- Better session management out of the box
- Faster and more responsive
- Modern plugin system (WebAssembly)
- Better mouse support
- Easier configuration (KDL format)

## Tips and Tricks

### Auto-attach to Sessions
Add to your `.zshrc`:
```bash
# Auto-attach to last Zellij session or create new one
if [[ -z "$ZELLIJ" ]]; then
    if zellij list-sessions | grep -q .; then
        zellij attach --index 0
    else
        zellij
    fi
fi
```

### Create Session Aliases
Add to your `.zshrc`:
```bash
alias zj='zellij'
alias zja='zellij attach'
alias zjl='zellij list-sessions'
alias zjk='zellij kill-session'
alias zjka='zellij kill-all-sessions'
```

### Use with WezTerm
WezTerm integrates well with Zellij. You can detect Zellij in WezTerm and adjust settings accordingly.

### Clipboard Integration
The configuration uses `pbcopy` for macOS. For Linux, change in `config.kdl`:
```kdl
copy_command "xclip -selection clipboard"
```

Or for Wayland:
```kdl
copy_command "wl-copy"
```

## Differences from Tmux

| Feature | Tmux | Zellij |
|---------|------|--------|
| Prefix | `Ctrl-e` | `Ctrl-e` (configured) |
| Split vertical | `Ctrl-e \|` | `Ctrl-e \|` (same) |
| Split horizontal | `Ctrl-e -` | `Ctrl-e -` (same) |
| Maximize pane | `Ctrl-e m` | `Ctrl-e m` (same) |
| Config reload | `Ctrl-e r` | `Ctrl-e r` (same) |
| Floating panes | Via plugins | Native support |
| Plugin system | Shell scripts | WebAssembly |
| Session persistence | tmux-resurrect | Built-in serialization |
| Pane pinning | Custom script | Not natively supported |

## Troubleshooting

### Keybinding not working
1. Check if the command exists: `which lazygit`
2. Verify the layout file exists in `~/.config/zellij/layouts/`
3. Reload config: `Ctrl-e` then `r`

### Theme not loading
Ensure the theme file exists at `~/.config/zellij/themes/custom-dark.kdl` and is referenced in the main config.

### Clipboard not working
Check the `copy_command` in `config.kdl` matches your system:
- macOS: `pbcopy`
- Linux (X11): `xclip -selection clipboard`
- Linux (Wayland): `wl-copy`

### Session not persisting
Zellij sessions persist by default. To ensure auto-attach, check the `env` section in `config.kdl`:
```kdl
env {
    ZELLIJ_AUTO_ATTACH "true"
    ZELLIJ_AUTO_EXIT "true"
}
```

## Migration Guide

### Coming from Tmux
Most keybindings work the same way! The main differences:
1. Floating panes work better out of the box
2. Session manager is built-in (no fzf plugin needed)
3. Plugin system is different (if you used tmux plugins)
4. Configuration syntax is KDL instead of shell-like

### Quick Reference Card
Print this for reference while learning:
```
╔═══════════════════════════════════════════════╗
║         Zellij Quick Reference                ║
║         (Prefix: Ctrl-e)                      ║
╠═══════════════════════════════════════════════╣
║ Splits:  | = vertical, - = horizontal         ║
║ Nav:     h/j/k/l = vim-style                  ║
║ Tabs:    c = new, n/p = next/prev             ║
║ Tools:   g = git, f = win, y = yazi           ║
║          u = docker, b = htop, t = tasks      ║
║          a = scratchpad                       ║
║ Session: e = manager, d = detach              ║
║ Resize:  R = resize mode                      ║
║ Search:  / = search/scroll mode               ║
║ Quit:    Ctrl-q                               ║
╚═══════════════════════════════════════════════╝
```

## Further Customization

### Custom Plugins
Zellij plugins are written in Rust and compiled to WebAssembly. See:
- [Plugin documentation](https://zellij.dev/documentation/plugins)
- [Plugin examples](https://github.com/zellij-org/zellij/tree/main/default-plugins)

### Custom Layouts
Create new layout files in `~/.config/zellij/layouts/`. Use them with:
```bash
zellij --layout mylayout
```

### Status Bar Customization
Edit the status bar plugin configuration in `config.kdl` or create a custom status bar plugin.

## Resources

- [Official Documentation](https://zellij.dev/documentation/)
- [GitHub Repository](https://github.com/zellij-org/zellij)
- [Plugin Development](https://zellij.dev/documentation/plugin-api-intro)
- [Configuration Examples](https://zellij.dev/documentation/configuration)
