-- MDX filetype settings
-- Better prose writing settings for MDX files

-- Enable spell checking (already configured globally)
vim.opt_local.spell = true

-- Better text wrapping for prose
vim.opt_local.wrap = true
vim.opt_local.linebreak = true -- Break at word boundaries
vim.opt_local.breakindent = true

-- Show where lines wrap
vim.opt_local.showbreak = '↪ '

-- Concealment for cleaner markdown/MDX view
vim.opt_local.conceallevel = 2

-- Formatting options for prose
vim.opt_local.formatoptions:append('t') -- Auto-wrap text using textwidth
vim.opt_local.formatoptions:append('c') -- Auto-wrap comments
vim.opt_local.formatoptions:append('q') -- Allow formatting comments with gq
vim.opt_local.formatoptions:remove('o') -- Don't continue comments with o/O

-- Wider text width for prose
vim.opt_local.textwidth = 100

-- Better paragraph movement
vim.keymap.set('n', 'j', 'gj', { buffer = true, desc = 'Move down visually' })
vim.keymap.set('n', 'k', 'gk', { buffer = true, desc = 'Move up visually' })
