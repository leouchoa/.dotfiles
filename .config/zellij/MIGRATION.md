# Tmux to Zellij Migration Guide

This guide helps you transition from your tmux setup to the new Zellij configuration.

## Quick Start

### 1. Install Zellij

```bash
# macOS
brew install zellij

# Or build from source
cargo install --locked zellij
```

### 2. Verify Configuration

The Zellij config should already be in place at `~/.config/zellij/`. Verify:

```bash
ls ~/.config/zellij/
# Should show: config.kdl, themes/, layouts/, README.md
```

### 3. Launch Zellij

```bash
zellij
```

That's it! Your keybindings from tmux should work immediately with `Ctrl-e` as the prefix.

## Side-by-Side: Tmux vs Zellij

### Session Management

| Task | Tmux | Zellij |
|------|------|--------|
| List sessions | `tmux ls` | `zellij list-sessions` |
| New session | `tmux new -s name` | `zellij -s name` |
| Attach session | `tmux attach -t name` | `zellij attach name` |
| Detach | `Ctrl-e d` | `Ctrl-e d` (same!) |
| Kill session | `tmux kill-session -t name` | `zellij kill-session name` |

### Keybindings (All the Same!)

| Action | Keybinding |
|--------|------------|
| Enter prefix mode | `Ctrl-e` |
| Split vertical | `Ctrl-e \|` |
| Split horizontal | `Ctrl-e -` |
| Navigate panes | `Ctrl-e h/j/k/l` |
| Maximize pane | `Ctrl-e m` |
| New tab | `Ctrl-e c` |
| Next/prev tab | `Ctrl-e n/p` |
| Lazygit | `Ctrl-e g` |
| Yazi | `Ctrl-e f` |
| Session manager | `Ctrl-e e` |

### Features Comparison

| Feature | Tmux | Zellij |
|---------|------|--------|
| Floating panes | Via plugins/popups | Native, better UX |
| Session persistence | tmux-resurrect plugin | Built-in |
| Session manager | tmux-fzf plugin | Built-in |
| Config format | Shell-like | KDL (cleaner) |
| Plugin system | Shell scripts | WebAssembly |
| Performance | Good | Faster |
| UI | Classic | Modern |

## Workflow Migration

### Daily Usage

Replace your tmux workflow with Zellij equivalently:

**Before (Tmux):**
```bash
# Start/attach to tmux
tmux attach || tmux new

# Or with your alias
tt
```

**After (Zellij):**
```bash
# Start/attach to Zellij
zellij attach -c default

# Or auto-attach (see .zshrc setup below)
zellij
```

### Auto-attach Setup

Add to your `~/.zshrc` (similar to your tmux `tt` alias):

```bash
# Auto-attach to Zellij session
if [[ -z "$ZELLIJ" ]]; then
    # Check if any sessions exist
    if zellij list-sessions 2>/dev/null | grep -q .; then
        # Attach to the most recent session
        zellij attach --index 0
    else
        # Create new session
        zellij
    fi
fi
```

### Aliases

Add these to your `~/.config/aliases`:

```bash
# Zellij aliases (keeping tmux ones too)
alias zj='zellij'
alias zja='zellij attach'
alias zjl='zellij list-sessions'
alias zjk='zellij kill-session'
alias zjka='zellij kill-all-sessions'
alias zjn='zellij -s'  # New named session

# Keep tmux aliases for fallback
# alias tt='...'  # Your existing tmux alias
```

## Testing Phase

During the transition, you can use both:

1. **Primary workflow**: Use Zellij
2. **Fallback**: Keep tmux available with `tmux attach`
3. **Testing**: Compare workflows side-by-side

### Things to Test

- [ ] Basic pane splitting and navigation
- [ ] Tab management
- [ ] Session switching (`Ctrl-e e`)
- [ ] Floating tools (lazygit, yazi, etc.)
- [ ] Copy/paste workflow
- [ ] Scrollback search
- [ ] Pane resizing and swapping
- [ ] Multiple sessions

## Common Issues

### Issue: Keybinding not working

**Solution**: Make sure you're in "normal" mode. Press `Esc` or `Enter` to return to normal mode, then try again.

### Issue: Tool not launching in floating pane

**Cause**: The command might not be installed.

**Solution**:
```bash
# Check if the tool exists
which lazygit yazi lazydocker htop

# Install missing tools
brew install lazygit yazi lazydocker htop gh
brew install taskwarrior-tui glow
```

### Issue: Config changes not taking effect

**Solution**: Reload config with `Ctrl-e r` or restart Zellij completely.

### Issue: Copy/paste not working

**macOS**: Should work with `pbcopy` (default in config)

**Linux X11**: Change in `config.kdl`:
```kdl
copy_command "xclip -selection clipboard"
```

**Linux Wayland**: Change in `config.kdl`:
```kdl
copy_command "wl-copy"
```

### Issue: Missing features from tmux plugins

Some tmux plugins don't have direct Zellij equivalents:

- **Pomodoro timer**: Could create custom Zellij plugin or use separate app
- **Network speed**: Could create custom Zellij plugin or use separate monitor
- **Pane pinning**: Not natively supported, use tab focus as alternative

## Gradual Migration Path

### Week 1: Learn the Basics
- Use Zellij for new sessions
- Keep familiar with `Ctrl-e` prefix
- Test basic splits and navigation

### Week 2: Tool Integration
- Use floating tool launchers (`Ctrl-e g`, `Ctrl-e f`, etc.)
- Practice session switching (`Ctrl-e e`)
- Customize status bar if needed

### Week 3: Advanced Features
- Explore layouts (create custom ones)
- Try without prefix (Alt-based navigation)
- Customize plugins if needed

### Week 4+: Full Migration
- Make Zellij your default in terminal emulator
- Add auto-attach to `.zshrc`
- Keep tmux config as backup

## Rollback Plan

If you need to go back to tmux temporarily:

```bash
# In your shell
tmux attach || tmux new

# Or use your existing alias
tt
```

Your tmux config is unchanged and still works perfectly.

## Need Help?

- **Zellij Docs**: https://zellij.dev/documentation/
- **Your Config**: `~/.config/zellij/README.md`
- **Keybinding Reference**: `~/.config/zellij/README.md` (Quick Reference Card section)

## Feedback

Track your experience:
- What works great?
- What's missing from tmux?
- What's better in Zellij?

Use this feedback to further customize your config!
