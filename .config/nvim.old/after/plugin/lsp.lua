local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
	-- "bash-language-server",
	-- "docker-compose-language-service",
	-- "dockerfile-language-server",
	-- "json-lsp",
	-- "ltex-ls",
	-- "lua-language-server",
	-- "marksman",
	-- "pyright",
	-- "rust-analyzer",
	-- "vim-language-server",
	-- "yaml-language-server",
	-- "dockerfile-language-server",
	-- "docker-compose-language-service",
	"marksman",
	"pyright",
	"rust_analyzer",
})

-- Fix Undefined global 'vim'
lsp.configure("lua-language-server", {
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
		},
	},
})

lsp.setup_servers({
  "pyright",
  "yaml-language-server",
  "marksman",
	"bash-language-server",
	"docker-compose-language-service",
	"dockerfile-language-server",
	"json-lsp",
	"ltex-ls",
	"lua-language-server",
	"marksman",
	"pyright",
	"rust-analyzer",
	"vim-language-server",
	"yaml-language-server",
	"dockerfile-language-server",
	"docker-compose-language-service",
})

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-k>"] = cmp.mapping.select_prev_item(cmp_select),
	["<C-j>"] = cmp.mapping.select_next_item(cmp_select),
	["<cr>"] = cmp.mapping.confirm({ select = true }),
	-- ["<C-Space>"] = cmp.mapping.complete(),
})

-- cmp_mappings['<Tab>'] = nil
-- cmp_mappings['<S-Tab>'] = nil

lsp.setup_nvim_cmp({
	mapping = cmp_mappings,
})

lsp.set_preferences({
	suggest_lsp_servers = true,
	sign_icons = {
		error = "E",
		warn = "W",
		hint = "H",
		info = "I",
	},
})

lsp.on_attach(function(client, bufnr)
	local opts = { buffer = bufnr, remap = false }

	vim.keymap.set("n", "gd", function()
		vim.lsp.buf.definition()
	end, opts)
	vim.keymap.set("n", "K", function()
		vim.lsp.buf.hover()
	end, opts)
	vim.keymap.set("n", "<leader>lw", function()
		vim.lsp.buf.workspace_symbol()
	end, opts)
	vim.keymap.set("n", "<leader>ld", function()
		vim.diagnostic.open_float()
	end, opts)
	vim.keymap.set("n", "]d", function()
		vim.diagnostic.goto_next()
	end, opts)
	vim.keymap.set("n", "[d", function()
		vim.diagnostic.goto_prev()
	end, opts)
	vim.keymap.set("n", "<leader>lc", function()
		vim.lsp.buf.code_action()
	end, opts)
	vim.keymap.set("n", "<leader>lr", function()
		vim.lsp.buf.references()
	end, opts)
	vim.keymap.set("n", "<leader>lR", function()
		vim.lsp.buf.rename()
	end, opts)
	vim.keymap.set("n", "<C-k>", function()
		vim.lsp.buf.signature_help()
	end, opts)
	vim.keymap.set("n", "<leader>lf", function()
		vim.lsp.buf.format()
	end, opts)
end)

lsp.setup()

vim.diagnostic.config({
	virtual_text = true,
})
