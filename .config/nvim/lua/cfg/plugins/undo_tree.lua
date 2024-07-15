return {
  'mbbill/undotree',
  -- config = function()
  --   require('neogit').setup {
  --   }
  -- end,
  keys = {
    { '<leader>u', vim.cmd.UndotreeToggle, mode = { 'n', 'v' }, desc = 'Undo Tree' },
  },
}
