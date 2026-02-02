-- MDX support configuration
-- Provides syntax highlighting, LSP, formatting, and preview for MDX files

-- Set up filetype detection for MDX
vim.filetype.add({
  extension = {
    mdx = 'mdx',
  },
})

-- Configure treesitter to use markdown parser for MDX files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'mdx',
  callback = function()
    -- Use markdown + tsx for better highlighting
    vim.treesitter.language.register('markdown', 'mdx')
  end,
})

return {
  -- MDX LSP support via typescript-language-server
  {
    'neovim/nvim-lspconfig',
    opts = function(_, opts)
      -- Extend filetypes for ts_ls to include mdx
      if not opts.servers then
        opts.servers = {}
      end

      -- Configure typescript-language-server to handle MDX
      opts.servers.ts_ls = vim.tbl_deep_extend('force', opts.servers.ts_ls or {}, {
        filetypes = {
          'javascript',
          'javascriptreact',
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.tsx',
          'mdx',
        },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      })

      return opts
    end,
  },

  -- Markdown preview with MDX support
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown', 'mdx' },
    build = 'cd app && npm install',
    keys = {
      {
        '<leader>mp',
        '<cmd>MarkdownPreviewToggle<cr>',
        desc = 'Markdown Preview',
        ft = { 'markdown', 'mdx' },
      },
    },
    config = function()
      -- Use a custom markdown script to handle MDX
      vim.g.mkdp_filetypes = { 'markdown', 'mdx' }
      vim.g.mkdp_browser = '' -- Use default browser
      vim.g.mkdp_auto_start = 0
      vim.g.mkdp_auto_close = 1
      vim.g.mkdp_refresh_slow = 0
      vim.g.mkdp_command_for_global = 0
      vim.g.mkdp_open_to_the_world = 0
      vim.g.mkdp_preview_options = {
        mkit = {},
        katex = {},
        uml = {},
        maid = {},
        disable_sync_scroll = 0,
        sync_scroll_type = 'middle',
        hide_yaml_meta = 1,
        sequence_diagrams = {},
        flowchart_diagrams = {},
        content_editable = false,
        disable_filename = 0,
        toc = {},
      }
    end,
  },

  -- Enhanced markdown rendering in-editor (supports MDX)
  {
    'MeanderingProgrammer/render-markdown.nvim',
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    ft = { 'markdown', 'mdx', 'Avante' },
    opts = {
      file_types = { 'markdown', 'mdx', 'Avante' },
      code = {
        sign = false,
        width = 'block',
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = { '󰲡 ', '󰲣 ', '󰲥 ', '󰲧 ', '󰲩 ', '󰲫 ' },
      },
    },
    keys = {
      {
        '<leader>mr',
        '<cmd>RenderMarkdown toggle<cr>',
        desc = 'Toggle Markdown Render',
        ft = { 'markdown', 'mdx' },
      },
    },
  },

  -- Emmet for fast HTML/JSX expansion in MDX
  {
    'mattn/emmet-vim',
    ft = { 'html', 'css', 'javascript', 'typescript', 'javascriptreact', 'typescriptreact', 'mdx' },
    init = function()
      vim.g.user_emmet_leader_key = '<C-z>'
      vim.g.user_emmet_settings = {
        javascript = {
          extends = 'jsx',
        },
        typescript = {
          extends = 'tsx',
        },
        mdx = {
          extends = 'jsx',
        },
      }
    end,
  },

}
