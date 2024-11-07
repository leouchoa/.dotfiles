return {
  'folke/trouble.nvim',
  opts = {}, -- for default options, refer to the configuration section for custom setup.
  cmd = 'Trouble',
  keys = {
    {
      '<leader>vv',
      '<cmd>Trouble diagnostics toggle<cr>',
      desc = 'Diagnostics (Trouble)',
    },
    {
      '<leader>vs',
      '<cmd>Trouble<cr>',
      desc = 'Find Trouble Mode',
    },
    {
      '<leader>ve',
      '<cmd>Trouble diagnostics filter = { severity=vim.diagnostic.severity.ERROR }<cr>',
      desc = 'Buffer Error Diagnostics (Trouble)',
    },
    {
      '<leader>vb',
      '<cmd>Trouble diagnostics toggle filter.buf=0<cr>',
      desc = 'Buffer Diagnostics (Trouble)',
    },
    {
      '<leader>vm',
      '<cmd>Trouble symbols toggle focus=false<cr>',
      desc = 'Symbols (Trouble)',
    },
    -- {
    --   '<leader>vl',
    --   '<cmd>Trouble loclist toggle<cr>',
    --   desc = 'Location List (Trouble)',
    -- },
    -- {
    --   '<leader>vq',
    --   '<cmd>Trouble qflist toggle<cr>',
    --   desc = 'Quickfix List (Trouble)',
    -- },
    -- {
    --   '<leader>vr',
    --   '<cmd>Trouble lsp_references toggle<cr>',
    --   desc = 'LSP References (Trouble)',
    -- },
    {
      '<leader>vt',
      '<cmd>Trouble todo toggle<cr>',
      desc = 'Todo (Trouble)',
    },
  },
}
