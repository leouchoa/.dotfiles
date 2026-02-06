local M = {}

-- Compatibility shim for plugins that still expect the legacy
-- `nvim-treesitter.configs` module (e.g. telescope 0.1.x).

function M.setup(_)
  -- No-op on the new nvim-treesitter API.
end

function M.is_enabled(module, lang, bufnr)
  if module ~= 'highlight' then
    return true
  end

  if (not lang or lang == '') and bufnr and vim.api.nvim_buf_is_valid(bufnr) then
    lang = vim.treesitter.language.get_lang(vim.bo[bufnr].filetype)
  end

  if not lang or lang == '' then
    return false
  end

  local ok, parsers = pcall(require, 'nvim-treesitter.parsers')
  return ok and parsers[lang] ~= nil
end

function M.get_module(module)
  if module == 'highlight' then
    return {
      additional_vim_regex_highlighting = false,
    }
  end

  return {}
end

return M
