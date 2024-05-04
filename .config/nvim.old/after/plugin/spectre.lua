vim.keymap.set('n', '<leader>so', '<cmd>lua require("spectre").open() <cr>',{})
vim.keymap.set('n', '<leader>sa', '<cmd>lua require("spectre").open_visual({select_word=true}) <cr>',{})
vim.keymap.set('n', '<leader>sf', '<cmd>lua require("spectre").open_file_search() <cr>',{})

