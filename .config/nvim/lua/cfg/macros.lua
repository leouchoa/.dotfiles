local M = {}

function M.setup_macros()
  -- <Esc> is ASCII 27 => \027
  -- <CR> is newline => \n (but must be literal in the macro string)
  local macro = '\0270f,a\n\027'
  vim.fn.setreg('q', macro)
end

return M
