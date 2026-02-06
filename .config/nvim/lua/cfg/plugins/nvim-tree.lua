return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = true,
  cmd = { 'NvimTreeToggle', 'NvimTreeFocus', 'NvimTreeFindFile', 'NvimTreeCollapse' },
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle NvimTree' },
  },
  config = function()
    local nvimtree = require 'nvim-tree'
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    nvimtree.setup {

      auto_reload_on_write = true,
      respect_buf_cwd = true,
      update_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = true,
      },
      view = {
        width = 30,
        number = true,
        relativenumber = true,
      },
    }
  end,
}
