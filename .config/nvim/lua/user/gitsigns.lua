local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  return
end



local line = vim.fn.line

--  TODO(lewis6991): doesn't work properly
-- vim.keymap.set('n', 'M', '<cmd>Gitsigns debug_messages<cr>')
-- vim.keymap.set('n', 'm', '<cmd>Gitsigns dump_cache<cr>')

local function on_attach(bufnr)
  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    vim.keymap.set(mode, l, r, opts)
  end

  map('n', ']c', function()
    if vim.wo.diff then return ']c' end
    vim.schedule(gitsigns.next_hunk)
    return '<Ignore>'
  end, {expr=true})

  map('n', '[c', function()
    if vim.wo.diff then return '[c' end
    vim.schedule(gitsigns.prev_hunk)
    return '<Ignore>'
  end, {expr=true})

  map('n', '<leader>hs', gitsigns.stage_hunk)
  map('n', '<leader>hr', gitsigns.reset_hunk)
  map('v', '<leader>hs', function() gitsigns.stage_hunk({line("."), line("v")}) end)
  map('v', '<leader>hh', function() gitsigns.reset_hunk({line("."), line("v")}) end)
  map('n', '<leader>hS', gitsigns.stage_buffer)
  map('n', '<leader>hu', gitsigns.undo_stage_hunk)
  map('n', '<leader>hR', gitsigns.reset_buffer)
  map('n', '<leader>hp', gitsigns.preview_hunk)
  map('n', '<leader>hb', function() gitsigns.blame_line{full=true} end)
  map('n', '<leader>hd', gitsigns.diffthis)
  map('n', '<leader>hD', function() gitsigns.diffthis('~') end)
  map('n', '<leader>]', gitsigns.next_hunk)
  map('n', '<leader>[', gitsigns.prev_hunk)

  -- Toggles
  map('n', '<leader>htb', gitsigns.toggle_current_line_blame)
  map('n', '<leader>htd', gitsigns.toggle_deleted)
  map('n', '<leader>htw', gitsigns.toggle_word_diff)

  map('n', '<leader>ghQ', function() gitsigns.setqflist('all') end)
  map('n', '<leader>ghq', gitsigns.setqflist)

  map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
end

gitsigns.setup{
  debug_mode = true,
  max_file_length = 1000000000,
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    delete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    topdelete = { hl = "GitSignsDelete", text = "契", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn" },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
  },
  on_attach = on_attach,
  preview_config = {
    border = 'rounded',
  },
  current_line_blame = true,
  current_line_blame_formatter_opts = {
    relative_time = true
  },
  current_line_blame_opts = {
    delay = 50
  },
  count_chars = {
    '⒈', '⒉', '⒊', '⒋', '⒌', '⒍', '⒎', '⒏', '⒐',
    '⒑', '⒒', '⒓', '⒔', '⒕', '⒖', '⒗', '⒘', '⒙', '⒚', '⒛',
  },
  update_debounce = 50,
  _extmark_signs = true,
  _threaded_diff = true,
  word_diff = false,
}


