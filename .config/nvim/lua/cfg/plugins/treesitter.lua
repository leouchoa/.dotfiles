return { -- Highlight, edit, and navigate code

  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },

  opts = {
    ensure_installed = {
      'bash',
      'c',
      'html',
      'regex',
      'bash',
      'vim',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'vimdoc',
      'python',
      'javascript',
      'typescript',
      'tsx',
      'dockerfile',
      'gitignore',
      'query',
      'css',
      'sql',
      'go',
      'json',
    },
    -- Autoinstall languages that are not installed

    auto_install = true,

    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },

    indent = { enable = true, disable = { 'ruby' } },

    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<C-space>', -- set to `false` to disable one of the mappings
        node_incremental = '<C-space>',
        -- scope_incremental = "grc",
        scope_incremental = false,
        node_decremental = '<bs>',
      },
    },

    textobjects = {
      lsp_interop = {
        enable = true,
        border = 'rounded',
        floating_preview_opts = {},
        peek_definition_code = {
          ['<leader>lc'] = { query = '@class.outer', desc = 'Peek class', silent = true },
          ['<leader>ll'] = { query = '@function.outer', desc = 'Peek function', silent = true },
        },
      },
      select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['af'] = { query = '@function.outer', desc = 'Select outer part of a function region' },
          ['if'] = { query = '@function.inner', desc = 'Select inner part of a function region' },
          ['ac'] = { query = '@class.outer', desc = 'Select outer part of a class region' },
          ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
          ['as'] = { query = '@scope', query_group = 'locals', desc = 'Select language scope' },
          -- ["is"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
          ['a='] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
          ['i='] = { query = '@assignment.inner', desc = 'Select inner part of an assignment' },
          ['L='] = { query = '@assignment.lhs', desc = 'Select left-hand side of an assignment' },
          ['R='] = { query = '@assignment.rhs', desc = 'Select right-hand side of an assignment' },

          ['aa'] = { query = '@parameter.outer', desc = 'Select outer part of a parameter/argument' },
          ['ia'] = { query = '@parameter.inner', desc = 'Select inner part of a parameter/argument' },

          ['ai'] = { query = '@conditional.outer', desc = 'Select outer part of a conditional' },
          ['ii'] = { query = '@conditional.inner', desc = 'Select inner part of a conditional' },

          ['al'] = { query = '@loop.outer', desc = 'Select outer part of a loop' },
          ['il'] = { query = '@loop.inner', desc = 'Select inner part of a loop' },
        },
      },

      swap = {
        enable = true,
        swap_next = {
          ['<leader>sna'] = { query = '@parameter.inner', desc = 'Swap parameters/argument with next' },
          ['<leader>snp'] = { query = '@property.outer', desc = 'Swap object property with next' },
          ['<leader>snf'] = { query = '@function.outer', desc = 'Swap function with next' },
        },
        swap_previous = {
          ['<leader>spa'] = { query = '@parameter.inner', desc = 'Swap parameters/argument with prev' },
          ['<leader>spp'] = { query = '@property.outer', desc = 'Swap object property with prev' },
          ['<leader>spf'] = { query = '@function.outer', desc = 'Swap function with previous' },
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_previous_start = {
          ['[f'] = { query = '@function.outer', desc = 'Previous method/function definition start' },
          ['[c'] = { query = '@class.outer', desc = 'Previous class definition start' },
          ['[i'] = { query = '@conditional.outer', desc = 'Previous conditional start' },
          ['[l'] = { query = '@loop.outer', desc = 'Previous loop start' },
        },
        goto_next_start = {
          [']f'] = { query = '@function.outer', desc = 'Next method/function definition start' },
          [']c'] = { query = '@class.outer', desc = 'Next class definition start' },
          [']i'] = { query = '@conditional.outer', desc = 'Next conditional start' },
          [']l'] = { query = '@loop.outer', desc = 'Next loop start' },
          -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
          -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
          -- [']s'] = { query = '@scope', query_group = 'locals', desc = 'Next scope' },
          [']z'] = { query = '@fold', query_group = 'folds', desc = 'Next fold' },
        },
        goto_previous_end = {
          ['[F'] = { query = '@function.outer', desc = 'Previous method/function definition end' },
          ['[C'] = { query = '@class.outer', desc = 'Previous class definition end' },
          ['[I'] = { query = '@conditional.outer', desc = 'Previous conditional end' },
          ['[L'] = { query = '@loop.outer', desc = 'Previous loop end' },
        },
        goto_next_end = {
          [']F'] = { query = '@function.outer', desc = 'Next method/function definition end' },
          [']C'] = { query = '@class.outer', desc = 'Next class definition end' },
          [']I'] = { query = '@conditional.outer', desc = 'Next conditional end' },
          [']L'] = { query = '@loop.outer', desc = 'Next loop end' },
        },
      },
    },
  },

  config = function(_, opts)
    -- [[ Configure Treesitter ]] See `:help nvim-treesitter`

    -- Prefer git instead of curl in order to improve connectivity in some environments
    require('nvim-treesitter.install').prefer_git = true
    ---@diagnostic disable-next-line: missing-fields
    require('nvim-treesitter.configs').setup(opts)
    local ts_repeat_move = require 'nvim-treesitter.textobjects.repeatable_move'

    -- Repeat movement with ; and ,
    -- ensure ; goes forward and , goes backward regardless of the last direction
    vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

    -- vim way: ; goes to the direction you were moving.
    -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

    -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })
  end,
  -- keys = {
  --   { '<leader>g', '<cmd>Neogit<cr>', mode = { 'n', 'v' }, desc = 'Yank git link' },
  -- },
}
