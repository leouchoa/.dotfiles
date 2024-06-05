-- TODO: read the docs: https://github.com/folke/noice.nvim?tab=readme-ov-file
-- config: i dont want it pop for me to save the file. Do i really want his plugin?
-- i also dont the save messages
-- https://github.com/rcarriga/nvim-notify
-- Maybe the following one?
-- https://github.com/stevearc/dressing.nvim
-- Also check this video
-- https://youtu.be/fFHlfbKVi30?t=2251&si=S7A0k_m98oYZYI3u
return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    -- add any options here
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'rcarriga/nvim-notify',
  },
  config = function()
    require('noice').setup {
      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true, -- requires hrsh7th/nvim-cmp
        },
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = true, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = false, -- add a border to hover docs and signature help
      },
    }
  end,
}
