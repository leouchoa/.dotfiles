-- Docs: https://github.com/danymat/neogen
return {
  'danymat/neogen',
  config = true,
  -- Uncomment next line if you want to follow only stable versions
  -- version = "*"
  keys = {
    {
      '<leader>nd',
      ":lua require('neogen').generate()<CR>",
      mode = { 'n', 'v' },
      desc = 'Neogen Generate Docs',
    },
  },
}
