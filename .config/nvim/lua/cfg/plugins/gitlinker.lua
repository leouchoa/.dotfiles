return {
  'linrongbin16/gitlinker.nvim',
  cmd = 'GitLink',
  opts = {},
  -- TODO: check correct bindings
  keys = {
    { '<leader>y', '<cmd>GitLink<cr>', mode = { 'n', 'v' }, desc = 'Yank git link' },
    { '<leader>Y', '<cmd>GitLink!<cr>', mode = { 'n', 'v' }, desc = 'Open git link' },
  },
}
