-- Quarto-nvim configuration for data science workflows
-- Supports both REPL (slime) and Jupyter (molten) workflows

return {
  -- Core quarto plugin with LSP integration
  {
    'quarto-dev/quarto-nvim',
    ft = { 'quarto', 'markdown' },
    dependencies = {
      'jmbuhr/otter.nvim', -- LSP features in code cells
      'nvim-treesitter/nvim-treesitter',
    },
    config = function()
      -- Note: We don't override vim.notify here because noice.nvim handles it
      require('quarto').setup {
      debug = false,
      closePreviewOnExit = true,
      lspFeatures = {
        enabled = true,
        chunks = 'curly', -- Use ```{python} style
        languages = { 'python', 'bash', 'lua', 'html', 'javascript', 'r' },
        diagnostics = {
          enabled = true,
          triggers = { 'BufWritePost' },
        },
        completion = {
          enabled = true,
        },
      },
      codeRunner = {
        enabled = true,
        default_method = 'molten', -- Default to Jupyter workflow (user preference)
        ft_runners = {
          python = 'molten',
        },
        never_run = { 'yaml' }, -- Don't execute YAML frontmatter
      },
      keymap = {
        hover = 'K', -- Show docs (standard LSP binding)
        definition = 'gd', -- Go to definition
        type_definition = 'gD', -- Go to type definition
        rename = '<leader>cr', -- Rename symbol
        format = '<leader>lf', -- Format code
        references = 'gr', -- Find references
        document_symbols = '<leader>ds',
      },
    }
    end,
    keys = {
      { '<leader>qa', ':QuartoActivate<CR>', desc = 'Activate quarto', ft = { 'quarto', 'markdown' } },
      { '<leader>qp', ':QuartoPreview<CR>', desc = 'Preview document', ft = { 'quarto', 'markdown' } },
      { '<leader>qh', ':QuartoHelp ', desc = 'Quarto help', ft = { 'quarto', 'markdown' } },
      {
        '<leader>qe',
        function()
          require('otter').activate()
        end,
        desc = 'Activate otter LSP',
        ft = { 'quarto', 'markdown' },
      },
      {
        '<leader>qq',
        function()
          local cfg = require('quarto.config').config
          local current = cfg.codeRunner.default_method
          local new = current == 'slime' and 'molten' or 'slime'
          cfg.codeRunner.default_method = new
          vim.notify('Code runner: ' .. new, vim.log.levels.INFO)
        end,
        desc = 'Toggle slime/molten',
        ft = { 'quarto', 'markdown' },
      },
      -- Cell navigation
      {
        ']c',
        function()
          require('quarto.runner').run_cell_and_move_down()
        end,
        desc = 'Next cell',
        ft = { 'quarto', 'markdown' },
      },
      {
        '[c',
        function()
          require('quarto.runner').run_cell_and_move_up()
        end,
        desc = 'Previous cell',
        ft = { 'quarto', 'markdown' },
      },
    },
  },

  -- Otter: LSP features in code cells
  {
    'jmbuhr/otter.nvim',
    lazy = true,
    opts = {
      buffers = {
        set_filetype = true,
        write_to_disk = false,
      },
      handle_leading_whitespace = true,
    },
  },

  -- Jupytext: Auto-convert .ipynb ↔ .qmd
  {
    'GCBallesteros/jupytext.nvim',
    ft = { 'ipynb' },
    opts = {
      custom_language_formatting = {
        python = {
          extension = 'qmd',
          style = 'quarto',
          force_ft = 'quarto',
        },
        r = {
          extension = 'qmd',
          style = 'quarto',
          force_ft = 'quarto',
        },
      },
    },
  },

  -- vim-slime: REPL workflow (send code to terminal)
  {
    'jpalardy/vim-slime',
    ft = { 'quarto', 'markdown', 'python' },
    init = function()
      -- Slime target: Neovim terminal
      vim.g.slime_target = 'neovim'
      vim.g.slime_no_mappings = true -- We define our own
      vim.g.slime_python_ipython = 1 -- Use IPython paste mode
      vim.g.slime_dispatch_ipython_pause = 100 -- ms delay for %cpaste

      -- Integration with otter/quarto for Python detection
      vim.b['quarto_is_python_chunk'] = false
      Quarto_is_in_python_chunk = function()
        require('otter.tools.functions').is_otter_language_context 'python'
      end

      -- Smart paste for multi-line Python code
      vim.cmd [[
        function! SlimeOverride_EscapeText_quarto(text)
          call v:lua.Quarto_is_in_python_chunk()
          if exists('g:slime_python_ipython') && len(split(a:text,"\n")) > 1 && b:quarto_is_python_chunk
            return ["%cpaste -q\n", g:slime_dispatch_ipython_pause, a:text, "--", "\n"]
          else
            return [a:text]
          endif
        endfunction
      ]]
    end,
    config = function()
      vim.g.slime_input_pid = false
      vim.g.slime_suggest_default = true
      vim.g.slime_menu_config = false
      vim.g.slime_neovim_ignore_unlisted = true
    end,
    keys = {
      { '<localleader>ss', ':SlimeConfig<CR>', desc = 'Slime config', ft = { 'quarto', 'markdown', 'python' } },
      {
        '<localleader>sc',
        function()
          vim.fn['slime#send']('%cpaste')
        end,
        desc = 'Send %cpaste',
        ft = { 'quarto', 'markdown', 'python' },
      },
      -- Code execution bindings (work when default_method = 'slime')
      {
        '<CR>',
        function()
          require('quarto.runner').run_cell()
        end,
        desc = 'Run cell',
        ft = { 'quarto', 'markdown' },
        mode = 'n',
      },
      {
        '<CR>',
        function()
          require('quarto.runner').run_range()
        end,
        desc = 'Run selection',
        ft = { 'quarto', 'markdown' },
        mode = 'v',
      },
      {
        '<C-CR>',
        function()
          require('quarto.runner').run_cell()
          require('quarto.runner').run_cell_and_move_down()
        end,
        desc = 'Run cell + move',
        ft = { 'quarto', 'markdown' },
        mode = 'n',
      },
    },
  },

  -- molten-nvim: Jupyter workflow (inline output)
  {
    'benlubas/molten-nvim',
    version = '^1.0.0',
    build = ':UpdateRemotePlugins',
    dependencies = {
      { '3rd/image.nvim', optional = true }, -- Optional: only works if terminal supports it
    },
    ft = { 'quarto', 'markdown', 'python' },
    init = function()
      -- Molten configuration
      -- Try to use image.nvim if available, otherwise fall back to none
      local has_image = pcall(require, 'image')
      vim.g.molten_image_provider = has_image and 'image.nvim' or 'none'

      -- Output window settings (smaller to avoid "too long" issue)
      vim.g.molten_output_win_max_height = 12 -- Reduced from 20
      vim.g.molten_auto_open_output = true
      vim.g.molten_wrap_output = true
      vim.g.molten_virt_text_output = true
      vim.g.molten_virt_lines_off_by_1 = true
      vim.g.molten_auto_open_html_in_browser = false
      vim.g.molten_tick_rate = 200 -- Slightly slower to reduce extmark race conditions

      -- Cover all window borders
      vim.g.molten_output_win_border = { '', '─', '', '' }
      vim.g.molten_output_show_more = true
      vim.g.molten_output_virt_lines = false -- More stable, less extmark errors

      -- Don't show the notification every time
      -- if not has_image then
      --   vim.notify('Molten: Image rendering disabled', vim.log.levels.WARN)
      -- end
    end,
    keys = {
      -- Initialization
      { '<localleader>mi', ':MoltenInit python3<CR>', desc = 'Molten init', ft = { 'quarto', 'markdown' } },
      { '<localleader>md', ':MoltenDeinit<CR>', desc = 'Molten deinit', ft = { 'quarto', 'markdown' } },

      -- Evaluation
      {
        '<localleader>mo',
        ':MoltenEvaluateOperator<CR>',
        desc = 'Evaluate operator',
        ft = { 'quarto', 'markdown' },
      },
      {
        '<localleader>mr',
        ':MoltenReevaluateCell<CR>',
        desc = 'Re-run cell',
        ft = { 'quarto', 'markdown' },
      },

      -- Output management
      {
        '<localleader>ms',
        ':noautocmd MoltenEnterOutput<CR>',
        desc = 'Show output',
        ft = { 'quarto', 'markdown' },
      },
      { '<localleader>mh', ':MoltenHideOutput<CR>', desc = 'Hide output', ft = { 'quarto', 'markdown' } },
      { '<localleader>mp', ':MoltenImagePopup<CR>', desc = 'Image popup', ft = { 'quarto', 'markdown' } },
      {
        '<localleader>mb',
        ':MoltenOpenInBrowser<CR>',
        desc = 'Open in browser',
        ft = { 'quarto', 'markdown' },
      },
      { '<localleader>mx', ':MoltenDelete<CR>', desc = 'Delete cell', ft = { 'quarto', 'markdown' } },
    },
  },

  -- image.nvim: Image rendering for plots
  -- NOTE: Requires terminal with Kitty graphics protocol support
  -- In tmux/zellij: requires passthrough enabled (see instructions below)
  {
    '3rd/image.nvim',
    enabled = function()
      -- Only enable if not in tmux/zellij, or if user explicitly enables it
      local tmux = vim.env.TMUX
      local zellij = vim.env.ZELLIJ

      -- If not in multiplexer, enable by default
      if not tmux and not zellij then
        return true
      end

      -- If in multiplexer, check for explicit enable via env var
      -- User can set: export NVIM_IMAGE_ENABLE=1
      return vim.env.NVIM_IMAGE_ENABLE == '1'
    end,
    lazy = true,
    opts = {
      backend = 'kitty', -- Use Kitty graphics protocol (WezTerm compatible)
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { 'markdown', 'quarto' },
        },
        neorg = {
          enabled = false,
        },
      },
      max_width = nil,
      max_height = nil,
      max_width_window_percentage = 80,
      max_height_window_percentage = 60,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { 'cmp_menu', 'cmp_docs', '' },
      editor_only_render_when_focused = true,
      tmux_show_only_in_active_window = true,
    },
  },

  -- img-clip.nvim: Paste images from clipboard
  {
    'HakonHarnes/img-clip.nvim',
    event = 'BufEnter',
    ft = { 'markdown', 'quarto', 'latex' },
    opts = {
      default = {
        dir_path = 'img',
        file_name = '%Y-%m-%d-%H-%M-%S',
        use_absolute_path = false,
        prompt_for_file_name = false,
      },
      filetypes = {
        markdown = {
          url_encode_path = true,
          template = '![$CURSOR]($FILE_PATH)',
          drag_and_drop = {
            download_images = false,
          },
        },
        quarto = {
          url_encode_path = true,
          template = '![$CURSOR]($FILE_PATH)',
          drag_and_drop = {
            download_images = false,
          },
        },
      },
    },
    keys = {
      { '<leader>ii', ':PasteImage<CR>', desc = 'Paste image', ft = { 'markdown', 'quarto' } },
    },
  },
}
