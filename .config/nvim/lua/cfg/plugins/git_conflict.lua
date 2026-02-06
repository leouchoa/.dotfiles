return {
  'akinsho/git-conflict.nvim',
  version = '*',
  config = function()
    local original_highlight = vim.highlight

    if vim.hl then
      ---@diagnostic disable-next-line: inject-field
      vim.highlight = vim.hl
    end

    local bit = require 'bit'
    local color = require 'git-conflict.colors'

    -- Upstream still validates with deprecated short validators ('n').
    color.shade_color = function(rgb_24bit, percent)
      if type(rgb_24bit) ~= 'number' then
        return 'NONE'
      end

      local r = bit.band(bit.rshift(rgb_24bit, 16), 255)
      local g = bit.band(bit.rshift(rgb_24bit, 8), 255)
      local b = bit.band(rgb_24bit, 255)

      local function alter(attr)
        return math.min(math.floor(attr * (100 + percent) / 100), 255)
      end

      return string.format('#%02x%02x%02x', alter(r), alter(g), alter(b))
    end

    local ok, err = pcall(function()
      require('git-conflict').setup()
    end)

    ---@diagnostic disable-next-line: inject-field
    vim.highlight = original_highlight

    if not ok then
      error(err)
    end
  end,
}
