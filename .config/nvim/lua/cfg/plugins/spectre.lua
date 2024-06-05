return {
  'nvim-pack/nvim-spectre',
  config = function()
    vim.keymap.set('n', '<leader>ro', '<cmd>lua require("spectre").open() <cr>', {})
    vim.keymap.set('n', '<leader>ra', '<cmd>lua require("spectre").open_visual({select_word=true}) <cr>', {})
    vim.keymap.set('n', '<leader>rf', '<cmd>lua require("spectre").open_file_search() <cr>', {})
  end,
}
