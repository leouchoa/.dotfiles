return {
  'pwntester/octo.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('octo').setup {
      enable_builtin = true,
      default_merge_method = 'commit',
      ssh_aliases = { ['github.com-work'] = 'github.com' },
    }
  end,
  keys = {
    { '<leader>o', '<cmd>Octo<cr>', mode = { 'n', 'v' }, desc = 'Octo' },
    -- { '<leader>op', '<cmd>Octo pr list<cr>', mode = { 'n', 'v' }, desc = 'Octo PR List' },
    -- { '<leader>oi', '<cmd>Octo issue list<cr>', mode = { 'n', 'v' }, desc = 'Octo Issue List' },
  },
}
