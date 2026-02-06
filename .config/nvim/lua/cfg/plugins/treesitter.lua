return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  event = { 'BufReadPre', 'BufNewFile' },
  init = function(plugin)
    local ts_runtime = plugin.dir .. '/runtime'
    if not vim.tbl_contains(vim.opt.runtimepath:get(), ts_runtime) then
      vim.opt.runtimepath:append(ts_runtime)
    end

    -- Force-load bundled parsers early (before lazy plugin load) so we don't
    -- accidentally cache an older parser from plugin runtime.
    for _, lang in ipairs { 'vim', 'vimdoc' } do
      local parser = vim.api.nvim_get_runtime_file('parser/' .. lang .. '.*', false)[1]
      if parser and parser:find('[\\/]lib[\\/]nvim[\\/]parser[\\/]') then
        pcall(vim.treesitter.language.add, lang, { path = parser })
      end
    end
  end,
  dependencies = {
    'nvim-treesitter/nvim-treesitter-textobjects',
  },

  opts = {
    ensure_installed = {
      'bash',
      'c',
      'html',
      'regex',
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
    auto_install = true,
    additional_vim_regex_highlighting = { 'ruby' },
    disable_indent = { 'ruby' },
    textobjects = {
      select = {
        lookahead = true,
        keymaps = {
          ['af'] = { query = '@function.outer', desc = 'Select outer part of a function region' },
          ['if'] = { query = '@function.inner', desc = 'Select inner part of a function region' },
          ['ac'] = { query = '@class.outer', desc = 'Select outer part of a class region' },
          ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class region' },
          ['as'] = { query = '@local.scope', query_group = 'locals', desc = 'Select language scope' },
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
    local ts = require 'nvim-treesitter'
    local ts_parsers = require 'nvim-treesitter.parsers'
    local ts_select = require 'nvim-treesitter-textobjects.select'
    local ts_move = require 'nvim-treesitter-textobjects.move'
    local ts_swap = require 'nvim-treesitter-textobjects.swap'
    local ts_repeat_move = require 'nvim-treesitter-textobjects.repeatable_move'

    local function prefer_builtin_parser(lang)
      local parser_glob = 'parser/' .. lang .. '.*'
      local candidates = vim.api.nvim_get_runtime_file(parser_glob, true)
      if #candidates < 2 then
        return
      end

      local builtin = nil
      for _, path in ipairs(candidates) do
        if path:find('[\\/]lib[\\/]nvim[\\/]parser[\\/]') then
          builtin = path
          break
        end
      end

      if builtin then
        pcall(vim.treesitter.language.add, lang, { path = builtin })
      end
    end

    -- Prefer bundled parsers for vim/vimdoc to avoid ABI/query mismatches.
    prefer_builtin_parser 'vim'
    prefer_builtin_parser 'vimdoc'

    ts.setup({})

    local runtime_group = vim.api.nvim_create_augroup('cfg-treesitter-runtime', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = runtime_group,
      callback = function(event)
        local ft = vim.bo[event.buf].filetype
        local bt = vim.bo[event.buf].buftype

        -- Skip utility/scratch buffers (noice, notify, quickfix, terminal, etc.)
        -- to avoid noisy query errors and unsupported language warnings.
        if bt ~= '' and bt ~= 'acwrite' then
          return
        end

        local lang = vim.treesitter.language.get_lang(ft) or ft

        if not lang or lang == '' or ts_parsers[lang] == nil then
          return
        end

        local ok = pcall(vim.treesitter.start, event.buf)
        if not ok then
          return
        end

        if vim.tbl_contains(opts.additional_vim_regex_highlighting, ft) then
          vim.bo[event.buf].syntax = ft
        end

        if vim.tbl_contains(opts.disable_indent, ft) then
          return
        end

        if pcall(vim.treesitter.get_parser, event.buf) then
          vim.bo[event.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end,
    })

    require('nvim-treesitter-textobjects').setup {
      select = {
        lookahead = opts.textobjects.select.lookahead,
      },
      move = {
        set_jumps = opts.textobjects.move.set_jumps,
      },
    }

    for keymap, map in pairs(opts.textobjects.select.keymaps) do
      vim.keymap.set({ 'x', 'o' }, keymap, function()
        ts_select.select_textobject(map.query, map.query_group)
      end, { desc = map.desc, silent = true })
    end

    for keymap, map in pairs(opts.textobjects.swap.swap_next) do
      vim.keymap.set('n', keymap, function()
        ts_swap.swap_next(map.query, map.query_group)
      end, { desc = map.desc, silent = true })
    end

    for keymap, map in pairs(opts.textobjects.swap.swap_previous) do
      vim.keymap.set('n', keymap, function()
        ts_swap.swap_previous(map.query, map.query_group)
      end, { desc = map.desc, silent = true })
    end

    local move_mappings = {
      goto_previous_start = ts_move.goto_previous_start,
      goto_next_start = ts_move.goto_next_start,
      goto_previous_end = ts_move.goto_previous_end,
      goto_next_end = ts_move.goto_next_end,
    }

    for group_name, move_fn in pairs(move_mappings) do
      for keymap, map in pairs(opts.textobjects.move[group_name]) do
        vim.keymap.set({ 'n', 'x', 'o' }, keymap, function()
          move_fn(map.query, map.query_group)
        end, { desc = map.desc, silent = true })
      end
    end

    vim.keymap.set({ 'n', 'x', 'o' }, ';', ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ 'n', 'x', 'o' }, ',', ts_repeat_move.repeat_last_move_previous)

    vim.keymap.set({ 'n', 'x', 'o' }, 'f', ts_repeat_move.builtin_f_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'F', ts_repeat_move.builtin_F_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 't', ts_repeat_move.builtin_t_expr, { expr = true })
    vim.keymap.set({ 'n', 'x', 'o' }, 'T', ts_repeat_move.builtin_T_expr, { expr = true })

    local telescope = require 'telescope.builtin'
    vim.keymap.set('n', '<leader>lc', telescope.lsp_type_definitions, { desc = 'Peek class/type', silent = true })
    vim.keymap.set('n', '<leader>ll', telescope.lsp_definitions, { desc = 'Peek function/definition', silent = true })
  end,
}
