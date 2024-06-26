local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap('', '<Space>', '<Nop>', opts)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

---------------------------------- Normal ----------------------------------

-- Better window navigation
keymap('n', '<C-h>', '<C-w>h', opts)
keymap('n', '<C-j>', '<C-w>j', opts)
keymap('n', '<C-k>', '<C-w>k', opts)
keymap('n', '<C-l>', '<C-w>l', opts)

-- Resize with arrows
keymap('n', '<S-Up>', ':resize +2<CR>', opts)
keymap('n', '<S-Down>', ':resize -2<CR>', opts)
keymap('n', '<S-Left>', ':vertical resize +2<CR>', opts)
keymap('n', '<S-Right>', ':vertical resize -2<CR>', opts)

-- Navigate buffers
keymap('n', '<S-l>', ':bnext<CR>', opts)
keymap('n', '<S-h>', ':bprevious<CR>', opts)

-- Move text up and down
keymap('n', '<A-j>', '<Esc>:m .+1<CR>==gi', opts)
keymap('n', '<A-k>', '<Esc>:m .-2<CR>==gi', opts)

-- I'm using the old C-w + v and C-w + s
-- keymap('n', '<leader>v', ':vnew <CR>', opts)
-- keymap('n', '<leader>V', ':split <CR>', opts)
keymap('n', '<C-w><C-w>', '<cmd>vnew<CR>', opts)

-- close current buffer. Attention! It will close it regardless of it being saved or not
keymap('n', 'vv', '<cmd>bd!<CR>', opts)
-- keymap('n', 'vv', '<cmd>bd!<CR>', opts)
-- keymap('n', '<Tab><Tab>', '<cmd>q<CR>', opts)
keymap('n', '<C-q>', '%', opts)
keymap('n', '<C-b>', 'ge', opts)
keymap('n', 'z;', 'zO', opts)
-- close quickfix list
keymap('n', 'xz', '<cmd>close<CR>', opts)
-- Set highlight on search, but clear on pressing <Esc> in normal mode
-- needs vim.opt.hlsearch = true
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>', opts)
-- Press qq fast to save file
-- :update writes the file to disk only when there are changes. So, it could be really helpful especially if the file is huge.
keymap('n', 'qq', '<cmd>update<cr>', { desc = 'Save file with update cmd' })
keymap('n', '<C-w>d', '<cmd>windo diffthis<CR>', { desc = 'Diffthis' })
---------------------------------- Insert ----------------------------------
-- keymap('i', 'qq', '<Esc><cmd>update<cr>gi', { desc = 'Save file with update cmd' })
-- vim.keymap.set({ 'n', 'v' }, 'qq', ':update<cr>', opts)
-- <Esc>:update<cr>gi
---------------------------------- Visual ----------------------------------
-- Stay in indent mode
keymap('v', '<', '<gv', opts)
keymap('v', '>', '>gv', opts)
keymap('v', '<C-q>', '%', opts)

-- Move text up and down
keymap('v', '<A-j>', ':m .+1<CR>==', opts)
keymap('v', '<A-k>', ':m .-2<CR>==', opts)
keymap('v', 'p', '"_dP', opts)
keymap('v', '<C-b>', 'ge', opts)

---------------------------------- Visual Block ----------------------------------
-- Move text up and down
keymap('x', 'J', ":move '>+1<CR>gv-gv", opts)
keymap('x', 'K', ":move '<-2<CR>gv-gv", opts)
keymap('x', '<A-j>', ":move '>+1<CR>gv-gv", opts)
keymap('x', '<A-k>', ":move '<-2<CR>gv-gv", opts)
keymap('x', '<C-b>', 'ge', opts)

---------------------------------- Terminal ----------------------------------
-- Better terminal navigation
keymap('t', '<C-h>', '<C-\\><C-N><C-w>h', term_opts)
keymap('t', '<C-j>', '<C-\\><C-N><C-w>j', term_opts)
keymap('t', '<C-k>', '<C-\\><C-N><C-w>k', term_opts)
keymap('t', '<C-l>', '<C-\\><C-N><C-w>l', term_opts)

---------------------------------- Plugins ----------------------------------
vim.keymap.set('n', '<leader>e', vim.cmd.NvimTreeToggle, {})
---------------------------------- LSP ----------------------------------
-- override those so they popup in a floating window
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
-- za to fold/unfold is not cool, zp is better
vim.api.nvim_set_keymap('n', 'zp', 'za', { noremap = true })
