local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
	debug = false,
	sources = {
		-- formatting.prettier.with { extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } },
		----- python -----
		formatting.black.with({ extra_args = { "--fast" } }),
		formatting.isort,
		diagnostics.flake8,
		----- lua -----
		formatting.stylua,
		----- yaml -----
		formatting.yamlfmt,
		diagnostics.yamllint,
		----- json -----
		formatting.fixjson,
		diagnostics.jsonlint,
		----- markdown -----
		diagnostics.markdownlint,
		formatting.markdownlint,
		----- rust -----
		formatting.rustfmt,
		----- etc -----
		null_ls.builtins.code_actions.gitsigns,
	},
	-- on_attach = function(client, bufnr)
	--   if client.supports_method("textDocument/formatting") then
	--     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	--     vim.api.nvim_create_autocmd("BufWritePre", {
	--       group = augroup,
	--       buffer = bufnr,
	--       callback = function()
	--         -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
	--         vim.lsp.buf.format({ bufnr = bufnr })
	--       end,
	--     })
	--   end
	-- end,
})
