return {
  'folke/zen-mode.nvim',
  opts = {
    plugins = {
      twilight = { enabled = true }, -- enable to start Twilight when zen mode opens
      gitsigns = { enabled = false }, -- disables git signs
      tmux = { enabled = false }, -- disables the tmux statusline
      options = { laststatus = 1 },
    },
    window = {
      width = 0.85,
    },
  },
  keys = {
    {
      '<leader>z',
      '<cmd>ZenMode<cr>',
      mode = { 'n', 'v' },
      desc = 'Toggle ZenMode',
    },
  },
}
