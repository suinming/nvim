local keymap = vim.keymap -- for conciseness

vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		-- Buffer local mappings.
		-- See `:help vim.lsp.*` for documentation on any of the below functions
		local opts = { buffer = ev.buf, silent = true }

		-- set keybinds
		opts.desc = "See available code actions"
		keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts) -- see available code actions, in visual mode will apply to selection

		opts.desc = "Smart rename"
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts) -- smart rename

		opts.desc = "Show buffer diagnostics"
		keymap.set("n", "<leader>D", "<cmd>Telescope diagnostics bufnr=0<CR>", opts) -- show  diagnostics for file

		opts.desc = "Show line diagnostics"
		keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts) -- show diagnostics for line

		opts.desc = "Go to previous diagnostic"
		keymap.set("n", "[d", function()
			vim.diagnostic.jump({ count = -1, float = true })
		end, opts) -- jump to previous diagnostic in buffer
		--
		opts.desc = "Go to next diagnostic"
		keymap.set("n", "]d", function()
			vim.diagnostic.jump({ count = 1, float = true })
		end, opts) -- jump to next diagnostic in buffer
	end,
})

local severity = vim.diagnostic.severity

vim.diagnostic.config({
	signs = {
		text = {
			[severity.ERROR] = " ",
			[severity.WARN] = " ",
			[severity.HINT] = "󰠠 ",
			[severity.INFO] = " ",
		},
	},
})

-- vue(https://github.com/vuejs/language-tools/wiki/Neovim)
local vue_language_server_path = vim.fn.expand("$MASON/packages")
	.. "/vue-language-server"
	.. "/node_modules/@vue/language-server"

local tsserver_filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue" }

local vue_plugin = {
	name = "@vue/typescript-plugin",
	location = vue_language_server_path,
	languages = { "vue" },
	configNamespace = "typescript",
}

local ts_ls_config = {
	init_options = {
		plugins = {
			vue_plugin,
		},
	},
	filetypes = tsserver_filetypes,
}

local vue_ls_config = {}

vim.lsp.config("vue_ls", vue_ls_config)
vim.lsp.config("ts_ls", ts_ls_config)

vim.lsp.enable({ "ts_ls", "vue_ls", "jdtls", "pyright", "ruff" })
