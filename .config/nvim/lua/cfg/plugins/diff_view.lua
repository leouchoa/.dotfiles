return {
  'sindrets/diffview.nvim',
  config = function() end,
  keys = {
    { '<leader>do', '<cmd>DiffviewOpen<cr>', mode = { 'n', 'v' }, desc = 'Open Diff View' },
    { '<leader>dc', '<cmd>DiffviewClose<cr>', mode = { 'n', 'v' }, desc = 'Close Diff View' },
    { '<leader>df', '<cmd>DiffviewFileHistory %<cr>', mode = { 'n', 'v' }, desc = 'Diff View Current File' },
    { '<leader>db', '<cmd>DiffviewFileHistory<cr>', mode = { 'n', 'v' }, desc = 'Diff View Current Branch' },
    { '<leader>dr', '<cmd>DiffviewRefresh<cr>', mode = { 'n', 'v' }, desc = 'Refresh Diff View' },
  },
}
