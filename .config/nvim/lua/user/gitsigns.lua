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

  map('n', '<leader>ghs', gitsigns.stage_hunk)
  map('n', '<leader>ghr', gitsigns.reset_hunk)
  map('v', '<leader>ghs', function() gitsigns.stage_hunk({line("."), line("v")}) end)
  map('v', '<leader>ghh', function() gitsigns.reset_hunk({line("."), line("v")}) end)
  map('n', '<leader>ghS', gitsigns.stage_buffer)
  map('n', '<leader>ghu', gitsigns.undo_stage_hunk)
  map('n', '<leader>ghR', gitsigns.reset_buffer)
  map('n', '<leader>ghp', gitsigns.preview_hunk)
  map('n', '<leader>ghb', function() gitsigns.blame_line{full=true} end)
  map('n', '<leader>ghd', gitsigns.diffthis)
  map('n', '<leader>ghD', function() gitsigns.diffthis('~') end)

  -- Toggles
  map('n', '<leader>gtb', gitsigns.toggle_current_line_blame)
  map('n', '<leader>gtd', gitsigns.toggle_deleted)
  map('n', '<leader>gtw', gitsigns.toggle_word_diff)

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


