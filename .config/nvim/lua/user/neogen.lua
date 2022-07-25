local status_ok, neogen = pcall(require, "neogen")
if not status_ok then
  return
end

-- TODO: config cmp: https://github.com/danymat/neogen#default-cycling-support
neogen.setup({
  snippet_engine = "luasnip"
})
