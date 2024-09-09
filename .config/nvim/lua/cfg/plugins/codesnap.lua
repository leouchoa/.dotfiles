return {
  'mistricky/codesnap.nvim',
  build = 'make build_generator',
  keys = {
    {
      '<leader>pc',
      '<cmd>CodeSnap<cr>',
      mode = 'x',
      desc = 'Save selected code snapshot into clipboard',
    },
    {
      '<leader>ps',
      '<cmd>CodeSnapSave<cr>',
      mode = 'x',
      desc = 'Save selected code snapshot in ~/screenshots/',
    },
    {
      '<leader>ph',
      '<cmd>CodeSnapSaveHighlight<cr>',
      mode = 'x',
      desc = 'Save selected code snapshot with highlight',
    },
  },
  opts = {
    save_path = '~/screenshots/',
    has_breadcrumbs = true,
    bg_theme = 'bamboo',
    watermark = '',
  },
}
