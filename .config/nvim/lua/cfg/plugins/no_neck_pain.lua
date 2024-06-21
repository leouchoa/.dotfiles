return {
  'shortcuts/no-neck-pain.nvim',
  lazy = false,
  version = '*',
  opts = {
    -- width = 115,
    width = 80,
    -- minSideBufferWidth = 0,
    autocmds = {
      -- enableOnTabEnter = true,
      -- enableOnVimEnter = true,
      reloadOnColorSchemeChange = true,
      skipEnteringNoNeckPainBuffer = true,
    },
    mappings = {
      enabled = true,
      toggle = '<Leader>z',
    },
    buffers = {
      wo = {
        fillchars = 'eob: ',
      },
      -- left = {
      --   scratchPad = {
      --     enabled = false,
      --     pathToFile = '~/notes.md',
      --   },
      -- },
      right = {
        enabled = false,
      },
    },
  },
}
