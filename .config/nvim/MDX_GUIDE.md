# MDX Support in Neovim

This configuration provides comprehensive MDX (Markdown + JSX) support for writing.

## Features Enabled

### 1. **Syntax Highlighting**
- Full MDX syntax support via Treesitter
- JSX/TSX components highlighted properly
- Markdown syntax within MDX

### 2. **LSP Support**
- TypeScript language server handles MDX files
- IntelliSense for React components
- Type checking for props
- Auto-completion for imports

### 3. **Formatting**
- Prettier formats MDX files
- Auto-format on save (1000ms timeout)
- Manual format: `<leader>lf`

### 4. **Auto-tagging**
- JSX tags auto-close: type `<Component` → `<Component></Component>`
- Auto-rename paired tags

### 5. **Emmet Support**
- Fast HTML/JSX expansion
- Trigger: `<C-z>,` (Ctrl+z then comma)
- Example: `div.container>ul>li*3` → expands to full structure

### 6. **Markdown Preview**
- Live preview in browser: `<leader>mp`
- Auto-updates as you type
- Supports markdown features

### 7. **Enhanced Rendering**
- In-editor markdown rendering: `<leader>mr` (toggle)
- Beautiful heading icons
- Code block styling
- Conceals markdown syntax for cleaner view

### 8. **Prose-Friendly Settings** (MDX files only)
- Soft line wrapping at word boundaries
- Visual line navigation (j/k move by display lines)
- Text width: 100 characters
- Spell checking enabled (PT-BR + EN-US)

## Key Mappings for MDX

| Key | Action | Mode |
|-----|--------|------|
| `<leader>mp` | Toggle Markdown Preview | Normal |
| `<leader>mr` | Toggle Markdown Rendering | Normal |
| `<leader>lf` | Format file | Normal |
| `<C-z>,` | Emmet expand | Insert |
| `j` / `k` | Move by visual line | Normal |
| `K` | Show LSP hover docs | Normal |
| `gd` | Go to definition | Normal |

## Installing Required Tools

After restarting Neovim, you'll need to install:

1. **Prettier** (for formatting):
   ```bash
   npm install -g prettier
   # or via Mason: :MasonInstall prettier
   ```

2. **Markdown Preview** (builds automatically on first use):
   Just run `:MarkdownPreview` once

## Tips for Writing MDX

### Component Imports
```mdx
import { MyComponent } from './components'

<MyComponent prop="value" />
```

### Mixing Markdown and JSX
```mdx
# Regular Markdown Heading

<CustomAlert type="info">
  You can use **markdown** inside JSX components!
</CustomAlert>

Regular paragraph continues here.
```

### Using Emmet
Type `div.card>h2+p` then press `<C-z>,`:
```jsx
<div className="card">
  <h2></h2>
  <p></p>
</div>
```

## Troubleshooting

### Syntax highlighting not working?
- Run `:TSInstall mdx` manually
- Check `:TSModuleInfo` to verify mdx parser is loaded

### LSP not providing completions?
- Ensure you have a `package.json` in your project
- Install React types: `npm install --save-dev @types/react`
- Restart LSP: `:LspRestart`

### Preview not opening?
- First run will install dependencies (takes ~1 minute)
- Check Node.js is installed: `node --version`

## Files Modified

- `nvim/lua/cfg/plugins/treesitter.lua` - Added mdx, jsx, tsx parsers
- `nvim/lua/cfg/plugins/mdx.lua` - MDX-specific plugin config
- `nvim/lua/cfg/lazy.lua` - Added mdx to formatters
- `nvim/after/ftplugin/mdx.lua` - MDX filetype settings
