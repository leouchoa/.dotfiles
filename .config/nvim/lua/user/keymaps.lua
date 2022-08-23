local opts = { noremap = true, silent = true }

local term_opts = { silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap space as leader key
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

---------------------------------- Normal ----------------------------------
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)


-- Resize with arrows
keymap("n", "<S-Up>", ":resize +2<CR>", opts)
keymap("n", "<S-Down>", ":resize -2<CR>", opts)
keymap("n", "<S-Left>", ":vertical resize +2<CR>", opts)
keymap("n", "<S-Right>", ":vertical resize -2<CR>", opts)

-- Navigate buffers
keymap("n", "<S-l>", ":bnext<CR>", opts)
keymap("n", "<S-h>", ":bprevious<CR>", opts)

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>==gi", opts)
keymap("n", "<A-k>", "<Esc>:m .-2<CR>==gi", opts)

keymap("n", "<leader>v", ":vnew <CR>", opts)
keymap("n", "<leader>V", ":split <CR>", opts)

-- close current buffer. Attention! It will close it regardless of it being saved or not
keymap("n", "xc", ":bd!<CR>", opts)
-- close quickfix list
keymap("n", "xz", ":close<CR>", opts)
---------------------------------- Insert ----------------------------------
-- Press jk fast to enter
-- keymap("i", "jk", "<ESC>", opts)

---------------------------------- Visual ----------------------------------
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

---------------------------------- Visual Block ----------------------------------
-- Move text up and down
keymap("x", "J", ":move '>+1<CR>gv-gv", opts)
keymap("x", "K", ":move '<-2<CR>gv-gv", opts)
keymap("x", "<A-j>", ":move '>+1<CR>gv-gv", opts)
keymap("x", "<A-k>", ":move '<-2<CR>gv-gv", opts)

---------------------------------- Terminal ----------------------------------
-- Better terminal navigation
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)


------------------------------ Plugins --------------------------------

-- Telescope --
-- keymap("n", "<leader>f", "<cmd>Telescope find_files<cr>", opts)
-- keymap("n", "<leader>f", "<cmd>lua require'telescope.builtin'.find_files(require('telescope.themes').get_dropdown({ previewer = false }))<cr>", opts)
keymap("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", opts)
keymap("n", "<leader>fc", "<cmd>Telescope command_history<cr>", opts)
keymap("n", "<leader>fC", "<cmd>Telescope commands<cr>", opts)
keymap("n", "<leader>fs", "<cmd>Telescope search_history<cr>", opts)
keymap("n", "<leader>fm", "<cmd>Telescope marks<cr>", opts)
keymap("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", opts)
keymap("n", "<leader>fr", "<cmd>Telescope registers<cr>", opts)
keymap("n", "<leader>fv", "<cmd>Telescope vim_options<cr>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
keymap("n", "<leader>fG", "<cmd>Telescope git_bcommits<cr>", opts)
keymap("n", "<leader>,", "<cmd>Telescope buffers<cr>", opts)
keymap("n", "<leader>fp", "<cmd>Telescope projects<cr>", opts)
keymap("n", "<leader>ft", "<cmd>TodoTelescope<cr>", opts)


-- NvimTree --
--
keymap("n", "<leader>e", ":NvimTreeToggle<cr>", opts)

-- dap --
--
keymap("n", "<F8>","<cmd>DapToggleBreakpoint<cr>", opts)
-- keymap("n", "F8",":lua require'dap'.toggle_breakpoint()<cr>", opts)
keymap("n", "<F9>","<cmd>DapStepOut<cr>", opts)
keymap("n", "<F10>","<cmd>DapStepOver<cr>", opts)
keymap("n", "<F11>","<cmd>DapStepInto<cr>", opts)
keymap("n", "<F12>","<cmd>DapContinue<cr>", opts)




-- ZenMode and Twilight
--
keymap("n", "<leader>z", "<cmd>ZenMode<cr>", opts)
keymap("n", "<leader>Z", "<cmd>Twilight<cr>", opts)


-- DiffView
--
keymap("n", "<leader>do", "<cmd>DiffviewOpen <cr>", opts)
keymap("n", "<leader>dT", "<cmd> DiffviewToggleFiles <cr>", opts)
keymap("n", "<leader>dt", "<cmd> DiffviewFocusFiles <cr>", opts)
keymap("n", "<leader>dc", "<cmd>DiffviewClose <cr>", opts)
keymap("n", "<leader>df", "<cmd>DiffviewFileHistory % <cr>", opts)
keymap("n", "<leader>dh", "<cmd>DiffviewFileHistory <cr>", opts)
keymap("n", "<leader>dc", "<cmd>DiffviewClose <cr>", opts)
keymap("n", "<leader>dr", "<cmd>DiffviewRefresh <cr>", opts)
keymap("n", "<leader>dc", "<cmd>DiffviewClose <cr>", opts)



-- Gitlinker
--
keymap('n', '<leader>glc', '<cmd>lua require"gitlinker".get_buf_range_url("n",{})<cr>', {silent = true})
keymap('v', '<leader>glc', '<cmd>lua require"gitlinker".get_buf_range_url("v",{})<cr>', {})
keymap('n', '<leader>glo', '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', {silent = true})
keymap('v', '<leader>glo', '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', {})
keymap('n', '<leader>glh', '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>', {silent = true})
keymap('n', '<leader>glH', '<cmd>lua require"gitlinker".get_repo_url()<cr>', {silent = true})


-- Neoclip
--
keymap("n", "<leader>c", "<cmd>Telescope neoclip <cr>", opts)
keymap("n", "<leader>C", "<cmd>Telescope macroscope 3 <cr>", opts) -- the 3 means to save the macro on number 3 because its easier to reach



-- Harpoon
-- TODO: add more keybinds based on use
keymap('n', '<leader>ha', '<cmd>lua require("harpoon.mark").add_file() <cr>', opts)
keymap('n', '<leader>hm', '<cmd>lua require("harpoon.ui").toggle_quick_menu() <cr>', opts)
keymap('n', '<leader>hn', '<cmd>lua require("harpoon.ui").nav_nex() <cr>', opts)
keymap('n', '<leader>hp', '<cmd>lua require("harpoon.ui").nav_prev() <cr>', opts)
keymap('n', '<leader>h1', '<cmd>lua require("harpoon.ui").nav_file(1) <cr>', opts)
keymap('n', '<leader>h2', '<cmd>lua require("harpoon.ui").nav_file(2) <cr>', opts)
keymap('n', '<leader>h3', '<cmd>lua require("harpoon.ui").nav_file(3) <cr>', opts)
keymap('n', '<leader>h4', '<cmd>lua require("harpoon.ui").nav_file(4) <cr>', opts)
keymap('n', '<leader>ht1', '<cmd>lua require("harpoon.term").gotoTerminal(1) <cr>', opts)
keymap('n', '<leader>ht2', '<cmd>lua require("harpoon.term").gotoTerminal(2) <cr>', opts)
keymap('n', '<leader>hc1', '<cmd>lua require("harpoon.term").sendCommand(1, "ls -La") <cr>', opts)
-- keymap('n', '<leader>hc1', '<cmd>lua require("harpoon.term").sendCommand(1, "ls -La") <cr>', opts)
keymap("n", "<leader>ht", "<cmd>Telescope harpoon marks <cr>", opts)



-- Trouble
--
keymap('n', '<leader>xx', '<cmd>TroubleToggle <cr>', opts)
keymap('n', '<leader>xw', '<cmd>TroubleToggle workspace_diagnostics <cr>', opts)
keymap('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics <cr>', opts)
keymap('n', '<leader>xq', '<cmd>TroubleToggle quickfix <cr>', opts)
keymap('n', '<leader>xl', '<cmd>TroubleToggle loclist <cr>', opts)
keymap('n', '<leader>xr', '<cmd>TroubleToggle lsp_references <cr>', opts)
keymap('n', '<leader>xc', '<cmd>TroubleClose <cr>', opts)
keymap('n', '<leader>xt', '<cmd>TodoTrouble <cr>', opts)


-- Spectre
--
keymap('n', '<leader>so', '<cmd>lua require("spectre").open() <cr>', opts)
keymap('n', '<leader>sa', '<cmd>lua require("spectre").open_visual({select_word=true}) <cr>', opts)
keymap('n', '<leader>sf', '<cmd>lua require("spectre").open_file_search() <cr>', opts)



-- neotest
-- TODO: add more cool keybinds
-- improve Config spec
keymap('n', '<leader>tr', '<cmd>lua require("neotest").run.run() <cr>', opts)
keymap('n', '<leader>tf', '<cmd>lua require("neotest").run.run(vim.fn.expand("%")) <cr>', opts)
-- improve integration with dap
keymap('n', '<leader>td', '<cmd>lua require("neotest").run.run({strategy = "dap"}) <cr>', opts)
keymap('n', '<leader>ts', '<cmd>lua require("neotest").run.stop() <cr>', opts)
keymap('n', '<leader>ta', '<cmd>lua require("neotest").run.attach() <cr>', opts)
keymap('n', '<leader>to', '<cmd>lua require("neotest").output.open({ enter = true }) <cr>', opts)
keymap('n', '<leader>tmo', '<cmd>lua require("neotest").summary.open() <cr>', opts)
keymap('n', '<leader>tmc', '<cmd>lua require("neotest").summary.close() <cr>', opts)
keymap('n', '<leader>tmt', '<cmd>lua require("neotest").summary.toggle()<cr>', opts)
-- keymap('n', '<leader>tml', '<cmd> <cr>', opts) -- config summary.runmarked
keymap('n', '[t', '<cmd>lua require("neotest").jump.prev({ status = "failed" })<CR>', opts)
keymap('n', ']t', '<cmd>lua require("neotest").jump.next({ status = "failed" })<CR>', opts)
-- config diagnostic with `vim.diagnostic.config()`


keymap('n', '<leader>af', '<cmd>Neogen func <CR>', opts)
keymap('n', '<leader>ac', '<cmd>Neogen class <CR>', opts)
keymap('n', '<leader>at', '<cmd>Neogen type <CR>', opts)
keymap('n', '<leader>aF', '<cmd>Neogen file <CR>', opts)
keymap('n', '[a', '<cmd>lua require("neogen").jump_prev <CR>', opts)
keymap('n', ']a', '<cmd>lua require("neogen").jump_next <CR>', opts)


-- Neogit
--
keymap('n', '<leader>gn', '<cmd>Neogit<CR>', opts)



-- Neorg
--

-- keymap('n', '<leader>ov', '<cmd>Neorg gtd views<cr>', opts)
-- keymap('n', '<leader>oc', '<cmd>Neorg gtd capture<cr>', opts)
-- keymap('n', '<leader>oe', '<cmd>Neorg gtd edit<cr>', opts)
keymap('n', '<leader>os', '<cmd>NeorgStart<cr><cmd>Neorg workspace gtd<cr>', opts)
keymap('n', '<leader>ocs', '<cmd>Neorg toc split<cr>', opts)
keymap('n', '<leader>oci', '<cmd>Neorg toc inline<cr>', opts)
keymap('n', '<leader>ocq', '<cmd>Neorg toc tocqflist<cr>', opts)
keymap('n', '<leader>occ', '<cmd>Neorg toc close<cr>', opts)
