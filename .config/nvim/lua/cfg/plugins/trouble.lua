return {
  'folke/trouble.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  config = function()
    vim.keymap.set('n', '<leader>xx', function()
      require('trouble').toggle()
    end, { desc = 'toggle trouble' })
    vim.keymap.set('n', '<leader>xw', function()
      require('trouble').toggle 'workspace_diagnostics'
    end, { desc = 'trouble workspace diagnostics' })
    vim.keymap.set('n', '<leader>xd', function()
      require('trouble').toggle 'document_diagnostics'
    end, { desc = 'trouble document diagnostics' })
    vim.keymap.set('n', '<leader>xq', function()
      require('trouble').toggle 'quickfix'
    end, { desc = 'trouble quickfix' })
    vim.keymap.set('n', '<leader>xl', function()
      require('trouble').toggle 'loclist'
    end, { desc = 'trouble loclist' })
    vim.keymap.set('n', 'gR', function()
      require('trouble').toggle 'lsp_references'
    end, { desc = '[G]o [R]eferences' })
  end,
}
