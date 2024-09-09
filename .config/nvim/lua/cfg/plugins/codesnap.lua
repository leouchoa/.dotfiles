return {
  'mistricky/codesnap.nvim',
  build = 'make',
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
  },
  opts = {
    save_path = '~/screenshots/',
    has_breadcrumbs = true,
    bg_theme = 'bamboo',
  },
}
