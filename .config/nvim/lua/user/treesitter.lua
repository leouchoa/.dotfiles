local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

configs.setup {
  -- ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  autopairs = {
    enable = true,
  },
  highlight = {
    -- `false` will disable the whole extension
    enable = true,
    -- additional_vim_regex_highlighting = { 'org' },
  },
  ensure_installed = {
    'python',
    'json',
    'yaml',
    'vim',
    'dockerfile',
    'org',
    'norg',
  },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<leader>ts"] = "@parameter.inner",
      },
      swap_previous = {
        ["<leader>tS"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true,
      goto_previous_start = {
        ['[f'] = '@function.outer',
        ['[c'] = '@class.outer'
      },
      goto_next_start = {
        [']f'] = '@function.outer',
        [']c'] = '@class.outer'
      },
      goto_previous_end = {
        ['[F'] = '@function.outer',
        ['[C'] = '@class.outer'
      },
      goto_next_end = {
        [']F'] = '@function.outer',
        [']C'] = '@class.outer'
      },
    }
  },
}
