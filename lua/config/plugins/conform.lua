return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			formatters_by_ft = {
				lua = { "stylua" }, -- installed by cargo
				python = function(bufnr)
					if require("conform").get_formatter_info("ruff_format", bufnr).available then
						return { "ruff_format" } -- installed by ruff standalone installers `curl -LsSf https://astral.sh/ruff/install.sh | sh`
					else
						return { "isort", "black" }
					end
				end,
				javascript = { "prettierd", "prettier", stop_after_first = true }, -- installed by npm
				typescript = { "prettierd", "prettier", stop_after_first = true }, -- installed by npm
				vue = { "prettierd", "prettier", stop_after_first = true }, -- installed by npm
				markdown = { "prettierd", "prettier", stop_after_first = true }, -- installed by npm
				css = { "prettierd", "prettier", stop_after_first = true }, -- installed by npm
				scss = { "prettierd", "prettier", stop_after_first = true }, -- installed by npm
				json = { "prettierd", "prettier", stop_after_first = true }, -- installed by npm
				-- Use the "*" filetype to run formatters on all filetypes.
				["*"] = { "codespell" },
				-- Use the "_" filetype to run formatters on filetypes that don't
				-- have other formatters configured.
				["_"] = { "trim_whitespace" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		})
	end,
}
