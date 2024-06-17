return {
  'ThePrimeagen/git-worktree.nvim',
  keys = function()
    local telescope = require 'telescope'
    telescope.load_extension 'git_worktree'
    return {
      {
        -- <Enter> - switches to that worktree
        -- <c-d> - deletes that worktree
        -- <c-f> - toggles forcing of the next deletion
        '<leader>ww',
        function()
          telescope.extensions.git_worktree.git_worktrees()
        end,
        desc = 'Telescope Worktrees',
      },
      --require('telescope').extensions.git_worktree.create_git_worktree()
      {
        -- <Enter> - switches to that worktree
        -- <c-d> - deletes that worktree
        -- <c-f> - toggles forcing of the next deletion
        '<leader>we',
        function()
          telescope.extensions.git_worktree.create_git_worktree()
        end,
        desc = 'Telescope Add Worktrees',
      },
    }
  end,
}
