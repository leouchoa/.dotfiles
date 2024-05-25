local status_ok, gitlinker = pcall(require, "gitlinker")
if not status_ok then
  return
end


gitlinker.setup({
  opts = {
    remote = nil, -- force the use of a specific remote
    -- adds current line nr in the url for normal mode
    add_current_line_on_normal_mode = true,
    -- callback for what to do with the url
    action_callback = require"gitlinker.actions".copy_to_clipboard,
    -- print the url after performing the action
    print_url = true,
  },
  callbacks = {
        ["github.com"] = require"gitlinker.hosts".get_github_type_url,
        ["gitlab.com"] = require"gitlinker.hosts".get_gitlab_type_url,
        ["try.gitea.io"] = require"gitlinker.hosts".get_gitea_type_url,
        ["codeberg.org"] = require"gitlinker.hosts".get_gitea_type_url,
        ["bitbucket.org"] = require"gitlinker.hosts".get_bitbucket_type_url,
        ["try.gogs.io"] = require"gitlinker.hosts".get_gogs_type_url,
        ["git.sr.ht"] = require"gitlinker.hosts".get_srht_type_url,
        ["git.launchpad.net"] = require"gitlinker.hosts".get_launchpad_type_url,
        ["repo.or.cz"] = require"gitlinker.hosts".get_repoorcz_type_url,
        ["git.kernel.org"] = require"gitlinker.hosts".get_cgit_type_url,
        ["git.savannah.gnu.org"] = require"gitlinker.hosts".get_cgit_type_url
  },
  -- default mapping to call url generation with action_callback
  -- mappings = "<leader>gy"
  -- disable default mappings so I can set them on my own
  mappings = nil,
})

-- Shorten function name
local keymap = vim.api.nvim_set_keymap
keymap('n', '<leader>glc', '<cmd>lua require"gitlinker".get_buf_range_url("n",{})<cr>', {silent = true})
keymap('v', '<leader>glc', '<cmd>lua require"gitlinker".get_buf_range_url("v",{})<cr>', {})
keymap('n', '<leader>glo', '<cmd>lua require"gitlinker".get_buf_range_url("n", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', {silent = true})
keymap('v', '<leader>glo', '<cmd>lua require"gitlinker".get_buf_range_url("v", {action_callback = require"gitlinker.actions".open_in_browser})<cr>', {})
keymap('n', '<leader>glh', '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>', {silent = true})
keymap('n', '<leader>glH', '<cmd>lua require"gitlinker".get_repo_url()<cr>', {silent = true})
