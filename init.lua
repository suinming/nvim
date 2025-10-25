require("config.lazy")
require("config.lsp")

vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.swapfile = false

-- clipboard
vim.opt.clipboard:append({ "unnamedplus", "unnamed" })

-- source current file
vim.keymap.set("n", "<space>x", "<cmd>source %<CR>")

-- highlight when yanking (copying) text
--  try it with `yap` in normal mode
--  see `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
