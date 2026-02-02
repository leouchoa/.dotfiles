-- https://github.com/yetone/avante.nvim
-- OPTIMAL FREE SETUP: Gemini 2.0 Flash for excellent coding at $0 cost
return {
  enabled = true, -- Free Gemini API covers your entire usage!
  'yetone/avante.nvim',
  event = 'VeryLazy',
  version = false, -- Never set this value to "*"! Never!
  opts = {
    -- Configure to use Gemini 2.0 Flash (free and fast)
    provider = 'gemini',
    providers = {
      gemini = {
        endpoint = 'https://generativelanguage.googleapis.com/v1beta/models',
        model = 'gemini-2.0-flash-exp', -- Latest and fastest free model
        timeout = 30000, -- 30 seconds timeout
        extra_request_body = {
          temperature = 0.1, -- Lower for more consistent code suggestions
          max_tokens = 8192, -- Generous token limit
        },
      },
    },
    -- Use Gemini for auto-suggestions too (free!)
    auto_suggestions_provider = 'gemini',

    -- Optimized behavior for coding
    behaviour = {
      auto_suggestions = false, -- Start disabled, enable later if you like it
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false, -- Manual review recommended
      minimize_diff = true, -- Better diffs for code changes
      enable_token_counting = true, -- Monitor your free tier usage
      support_paste_from_clipboard = false,
    },

    -- Enhanced UI for better coding experience
    windows = {
      position = 'right', -- Sidebar on the right
      wrap = true,
      width = 35, -- Good width for code review
      sidebar_header = {
        enabled = true,
        align = 'center',
        rounded = true,
      },
      input = {
        prefix = '> ',
        height = 8,
      },
      edit = {
        border = 'rounded',
        start_insert = true,
      },
    },

    -- Optional: Add project-specific instructions
    instructions_file = 'avante.md', -- Create this file in your project root for custom prompts
  },

  -- Build configuration
  build = vim.fn.has 'win32' ~= 0 and 'powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false' or 'make',

  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-treesitter/nvim-treesitter',

    -- Enhanced input UI (recommended)
    'stevearc/dressing.nvim',

    -- Optional but useful dependencies
    'nvim-telescope/telescope.nvim', -- for file_selector
    'hrsh7th/nvim-cmp', -- autocompletion for avante commands
    'ibhagwan/fzf-lua', -- alternative file_selector
    'echasnovski/mini.pick', -- another file_selector option
    'nvim-tree/nvim-web-devicons', -- icons

    -- Image support (optional)
    {
      'HakonHarnes/img-clip.nvim',
      event = 'VeryLazy',
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },

    -- Markdown rendering for better chat display
    {
      'MeanderingProgrammer/render-markdown.nvim',
      opts = {
        file_types = { 'markdown', 'Avante' },
      },
      ft = { 'markdown', 'Avante' },
    },
  },
}
