# Quarto-nvim Usage Guide

## ✅ Setup Complete!

Your quarto-nvim setup is now fully functional with:
- ✅ Molten (Jupyter-style inline output) - DEFAULT
- ✅ Slime (REPL terminal workflow) - available via toggle
- ✅ LSP features in code blocks (autocomplete, hover, etc.)
- ✅ All 7 plugins configured and working

## 🚀 Quick Start

### Open a quarto document
```bash
nvim ~/.dotfiles/.config/nvim/test-quarto.qmd
# Or create new: nvim my-analysis.qmd
```

### Basic Workflow (Molten - Jupyter-style)

1. **Activate quarto**: `<space>qa`
2. **Initialize kernel**: `<space>mi`
3. **Move cursor into Python code block**
4. **Run cell**: `<Enter>` (in normal mode)
5. **See output appear inline below the cell!**

## ⌨️ All Keybindings

### Quarto Commands (`<space>q*`)
- `<space>qa` - Activate quarto for current buffer
- `<space>qp` - Preview document in browser (requires Quarto CLI)
- `<space>qh` - Show quarto help
- `<space>qe` - Activate otter LSP (if autocomplete not working)
- `<space>qq` - **Toggle between molten ↔ slime**

### Molten (Jupyter) - Default (`<space>m*`)
- `<space>mi` - Initialize kernel (start)
- `<space>md` - Deinitialize kernel (stop)
- `<Enter>` - Run current cell (normal mode)
- `<Enter>` - Run selection (visual mode)
- `<space>mr` - Re-run last cell
- `<space>ms` - Show output window
- `<space>mh` - Hide output window
- `<space>mo` - Evaluate operator (advanced)
- `<space>mx` - Delete cell output

### Slime (REPL) (`<space>s*`)
First toggle to slime: `<space>qq`

1. Open terminal: `:split | terminal`
2. Start IPython: `ipython`
3. Configure slime: `<space>ss` (selects terminal)
4. Run cell: `<Enter>` on code block

- `<space>ss` - Configure/select terminal
- `<space>sc` - Send %cpaste (for multi-line code)
- `<Enter>` - Run cell (sends to terminal)

### Navigation
- `]c` - Next cell
- `[c` - Previous cell
- `<C-Enter>` - Run cell and move to next

### Images
- `<space>ii` - Paste image from clipboard

## 📝 Code Block Format

```markdown
\```{python}
# Your Python code here
import pandas as pd
df = pd.DataFrame({'a': [1, 2, 3]})
print(df)
\```
```

## 🎯 Common Tasks

### Run all cells in document
```vim
:MoltenEvaluateVisual
# Or manually run each cell with <Enter>
```

### Switch workflows
```vim
<space>qq  " Toggle molten ↔ slime
```

### Restart kernel (if things break)
```vim
<space>md  " Stop kernel
<space>mi  " Start new kernel
```

### Check kernel status
```vim
:MoltenInfo
```

## 🐛 Troubleshooting

### Output too long?
Already configured to max 12 lines. To change:
```vim
:let g:molten_output_win_max_height = 20
```

### Autocomplete not working in code blocks?
```vim
<space>qe  " Activate otter LSP
:LspInfo   " Verify basedpyright is attached
```

### Kernel won't start?
Check Python can find jupyter:
```bash
python3 -c "import jupyter_client; print('OK')"
jupyter kernelspec list
```

### Function doesn't exist error?
```vim
:Lazy load molten-nvim
:UpdateRemotePlugins
:quit
# Restart Neovim
```

## 📊 What Works

✅ **Print statements** - appear inline
✅ **DataFrames** - formatted tables
✅ **Plots** - show as text (images disabled in tmux/zellij)
✅ **Errors** - show tracebacks inline
✅ **Rich output** - HTML, Markdown, etc.
✅ **Re-execution** - update outputs dynamically
✅ **LSP features** - autocomplete, hover, diagnostics
✅ **Multiple kernels** - different files can have different kernels

## 🎨 Customization

### Enable image rendering (optional)

If you want matplotlib plots to render as images:

1. Exit tmux/zellij and open nvim directly in WezTerm:
   ```bash
   # Don't use: zz or tt (multiplexers)
   # Just: nvim file.qmd
   ```

2. Or enable passthrough in tmux:
   ```bash
   # Add to ~/.config/tmux/tmux.conf:
   set -g allow-passthrough on

   # Then set env var:
   export NVIM_IMAGE_ENABLE=1
   ```

### Change default workflow to slime

Edit `~/.dotfiles/.config/nvim/lua/cfg/plugins/quarto.lua` line 30:
```lua
default_method = 'slime',  -- Instead of 'molten'
```

## 📚 Resources

- **Test document**: `~/.dotfiles/.config/nvim/test-quarto.qmd`
- **Requirements file**: `~/.dotfiles/.config/nvim/quarto-requirements.txt`
- **Config**: `~/.dotfiles/.config/nvim/lua/cfg/plugins/quarto.lua`
- **Quarto docs**: https://quarto.org/docs/computations/python.html
- **Molten docs**: https://github.com/benlubas/molten-nvim

## 🎉 You're Ready!

Try the test document to see everything in action:
```bash
nvim ~/.dotfiles/.config/nvim/test-quarto.qmd
```

Then:
1. `<space>qa` (activate)
2. `<space>mi` (init kernel)
3. Put cursor in first code block
4. `<Enter>` (run!)

Happy data science! 🚀
