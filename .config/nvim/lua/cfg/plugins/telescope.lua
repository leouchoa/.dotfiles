return {
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',

      -- `build` is used to run some command when the plugin is installed/updated.
      -- This is only run then, not every time Neovim starts up.
      build = 'make',

      -- `cond` is a condition used to determine whether this plugin should be
      -- installed and loaded.
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- requires a Nerd Font.
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    -- [[ Configure Telescope ]]
    -- See `:help telescope` and `:help telescope.setup()`
    local actions = require 'telescope.actions'
    require('telescope').setup {
      -- You can put your default mappings / updates / etc. in here
      --  All the info you're looking for is in `:help telescope.setup()`
      --
      defaults = {
        mappings = {
          i = {
            -- ['<C-h>'] = actions.cycle_history_prev,
            -- ['<C-l>'] = actions.cycle_history_next,
            -- ['<C-K>'] = actions.move_selection_previous,
            -- ['<C-J>'] = actions.move_selection_next,
            ['<C-k>'] = actions.preview_scrolling_up,
            ['<C-j>'] = actions.preview_scrolling_down,

            ['<C-s>'] = actions.which_key,
          },

          n = {
            ['<C-k>'] = actions.preview_scrolling_up,
            ['<C-j>'] = actions.preview_scrolling_down,
            -- ['<C-K>'] = actions.move_selection_previous,
            -- ['<C-J>'] = actions.move_selection_next,

            ['<C-s>'] = actions.which_key,

            -- ['?'] = actions.which_key,
          },
        },
      },
      -- pickers = {}
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_dropdown(),
        },
      },
    }
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- See `:help telescope.builtin`
    local builtin = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = '[F]ind [H]elp' })
    vim.keymap.set('n', '<leader>fk', builtin.keymaps, { desc = '[F]ind [K]eymaps' })
    vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = '[F]ind [F]iles' })
    vim.keymap.set('n', '<leader>fS', builtin.builtin, { desc = '[F]ind [S]elect Telescope' })
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, { desc = '[F]ind current [W]ord' })
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = '[F]ind by [G]rep' })
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { desc = '[F]ind [D]iagnostics' })
    vim.keymap.set('n', '<leader>fr', builtin.resume, { desc = '[F]ind [R]esume' })
    vim.keymap.set('n', '<leader>f.', builtin.oldfiles, { desc = '[F]ind Recent Files ("." for repeat)' })
    vim.keymap.set('n', '<leader>,', builtin.buffers, { desc = '[F]ind Existing Buffers' })
    vim.keymap.set('n', '<leader>fc', builtin.git_commits, { desc = '[F]ind Commits' })
    --- bcommits signature for quick ref
    --- builtin.git_bcommits = require_on_exported_call("telescope.builtin.__git").bcommits
    --- Lists commits for current buffer with diff preview
    ---   - `<cr>`: checks out the currently selected commit
    ---   - `<c-v>`: opens a diff in a vertical split
    ---   - `<c-x>`: opens a diff in a horizontal split
    ---   - `<c-t>`: opens a diff in a new tab
    vim.keymap.set('n', '<leader>fC', builtin.git_bcommits, { desc = '[F]ind BCommits' })
    --- git_status signature for quick ref
    ---   - `<Tab>`: stages or unstages the currently selected file
    vim.keymap.set('n', '<leader>fs', builtin.git_status, { desc = 'Lists git status for current directory' })
    --- git_branches signature for quick ref
    ---   - `<C-t>`: tracks currently selected branch
    ---   - `<C-r>`: rebases currently selected branch
    ---   - `<C-a>`: creates a new branch, with confirmation prompt before creation
    ---   - `<C-d>`: deletes the currently selected branch, with confirmation prompt before deletion
    ---   - `<C-y>`: merges the currently selected branch, with confirmation prompt before deletion
    vim.keymap.set('n', '<leader>fb', builtin.git_branches, { desc = '[F]ind [B]ranches' })
    vim.keymap.set('n', '<leader>fH', builtin.command_history, { desc = '[F]ind [C]ommand History' })
    vim.keymap.set('n', '<leader>fm', builtin.marks, { desc = '[F]ind [M]arks' })
    vim.keymap.set('n', '<leader>ft', '<cmd>TodoTelescope<cr>', { desc = 'Find [T]odo' })

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = '[/] Fuzzily search in current buffer' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
    vim.keymap.set('n', '<leader>f/', function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = 'Live Grep in Open Files',
      }
    end, { desc = '[F]ind [/] in Open Files' })

    -- Shortcut for searching your Neovim configuration files
    vim.keymap.set('n', '<leader>fn', function()
      builtin.find_files { cwd = vim.fn.stdpath 'config' }
    end, { desc = '[F]ind [N]eovim files' })
  end,
}
