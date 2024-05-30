return {
  'David-Kunz/gen.nvim',
  opts = {
    model = 'llama3', -- The default model to use.
    show_model = true,
  },
  --   config = function()
  --   require('gen').setup({})
  -- end,
  keys = {
    { '<leader>;', ':Gen<CR>', mode = { 'n', 'v' }, desc = 'GenAI' },
  },
}
