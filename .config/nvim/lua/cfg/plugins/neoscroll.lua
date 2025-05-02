-- TODO:finish setup if needed
-- https://www.youtube.com/watch?v=v4XPE3a2zBw
-- https://github.com/karb94/neoscroll.nvim
return {
  enabled = false,
  'karb94/neoscroll.nvim',
  opts = {},
  config = function()
    require('neoscroll').setup { mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>' } }
  end,
}
