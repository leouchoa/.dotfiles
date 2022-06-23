local status_ok, configs = pcall(require, "orgmode")
if not status_ok then
 return
end

configs.setup_ts_grammar()

configs.setup({
  -- org_agenda_files = {'~/Dropbox/org/*', '~/my-orgs/**/*'},
  -- org_default_notes_file = '~/Dropbox/org/refile.org',
  org_agenda_files = {
    '~/org/*',
    -- '~/my-orgs/**/*'
  },
  -- org_default_notes_file = {
  --   '~/Dropbox/org/refile.org',
  -- },

})

