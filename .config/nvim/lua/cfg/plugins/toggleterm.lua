return {
  'akinsho/toggleterm.nvim',
  version = '*',
  config = true,
  keys = {
    { '<leader><leader>', '<cmd>:ToggleTerm size=40 direction=float name=terminal<cr>', mode = { 'n', 'v' }, desc = 'ToggleTerm' },
  },
}
