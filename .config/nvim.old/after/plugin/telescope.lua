local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local builtin = require "telescope.builtin"
local actions = require "telescope.actions"

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },

    mappings = {
      i = {
        ["<C-n>"] = actions.cycle_history_next,
        ["<C-p>"] = actions.cycle_history_prev,

        -- ["<C-j>"] = actions.move_selection_next,
        -- ["<C-k>"] = actions.move_selection_previous,

        ["<C-k>"] = actions.preview_scrolling_up,
        ["<C-j>"] = actions.preview_scrolling_down,

        ["<C-c>"] = actions.close,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,

        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        -- ["<C-u>"] = actions.preview_scrolling_up,
        -- ["<C-d>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        ["<C-l>"] = actions.complete_tag,
        ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
      },

      n = {
        ["<esc>"] = actions.close,
        ["<CR>"] = actions.select_default,
        ["<C-x>"] = actions.select_horizontal,
        ["<C-v>"] = actions.select_vertical,
        ["<C-t>"] = actions.select_tab,

        ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
        ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
        ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
        ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

        ["j"] = actions.move_selection_next,
        ["k"] = actions.move_selection_previous,
        ["H"] = actions.move_to_top,
        ["M"] = actions.move_to_middle,
        ["L"] = actions.move_to_bottom,

        ["<Down>"] = actions.move_selection_next,
        ["<Up>"] = actions.move_selection_previous,
        ["gg"] = actions.move_to_top,
        ["G"] = actions.move_to_bottom,

        ["<C-k>"] = actions.preview_scrolling_up,
        ["<C-j>"] = actions.preview_scrolling_down,

        ["<PageUp>"] = actions.results_scrolling_up,
        ["<PageDown>"] = actions.results_scrolling_down,

        ["?"] = actions.which_key,
      },
    },
  },
  pickers = {
    -- Default configuration for builtin pickers goes here:
    -- picker_name = {
    --   picker_config_key = value,
    --   ...
    -- }
    -- Now the picker_config_key will be applied every time you call this
    -- builtin picker
  },
  -- extensions = {
    -- project = {
      -- base_dirs = {
        -- '~/code/',
        -- {path = '~/code/dotfiles/' },
        -- '~/code/fastapi_sqlachemy/',
        -- '~/code/fastapi_with_postgres/',
        -- '~/code/cheatsheets/',
      -- },
      -- hidden_files = false,
      -- theme = "dropdown",
    -- }
  -- },
}

-- telescope.load_extension('projects')
-- telescope.load_extension('neoclip')
-- telescope.load_extension('macroscope')
-- telescope.load_extension('harpoon')




vim.keymap.set("n", "<leader>fp",function()
	builtin.grep_string({search = vim.fn.input("Grep > ") });
end)

vim.keymap.set("n", "<leader>fa", builtin.git_files, {})
--vim.keymap.set("n", "<leader>fw", builtin.grep_string, {}) -- not good, need to improve a bit
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
vim.keymap.set("n", "<leader>fc", builtin.command_history, {})
vim.keymap.set("n", "<leader>fC", builtin.commands, {})
vim.keymap.set("n", "<leader>fs", builtin.search_history, {})
vim.keymap.set("n", "<leader>fm", builtin.marks, {})
vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
vim.keymap.set("n", "<leader>fr", builtin.registers, {})
vim.keymap.set("n", "<leader>fv", builtin.vim_options, {})
vim.keymap.set("n", "<leader>fG", builtin.git_bcommits, {})
vim.keymap.set("n", "<leader>,",  builtin.buffers, {})
vim.keymap.set("n", "<leader>ft", "<cmd>TodoTelescope<cr>", {})
