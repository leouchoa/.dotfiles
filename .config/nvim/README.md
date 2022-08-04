# Neovim dotfiles

This heavily inspired in the [LunarVim](https://github.com/LunarVim/Neovim-from-scratch) project.


## Things to do When configuring new nvim

1. Remember to update `lua/user/cmp.lua` with your lsp completions. Usually it means updating:
  - sources 
  - vim_item.menu

2. Run `TSInstall language` to download syntax highlighting. For options please consult the lsp [homepage](https://github.com/nvim-treesitter/nvim-treesitter). Usually I install:

- json, yaml, toml, python, markdown, orgmode 

3. **IMPORTANT:** the `manual_mode` option in the `project` plugin is set to true. Otherwise it will fk up my telescope `find_files`. Because of that, remember that to add a new directory as project you have to use the `:ProjectRoot` command!

## Todo

- Configure other telescope binds [ref](https://youtu.be/OhnLevLpGB4?t=407)
  - Configure  [lsp keybinds](https://github.com/nvim-telescope/telescope.nvim#neovim-lsp-pickers)
- Configure more lsp commands
- Make a list of the most used commands
- Configure `toggleterm` (basically create and bind other terminal-related function)
- Try to get signature_help working in python
  - screenshot the behaviour of <C-k> in `require` function of init.lua 
  - show that the same does not work when using python scripts with pyright enabled
- Configure format-on-save 

