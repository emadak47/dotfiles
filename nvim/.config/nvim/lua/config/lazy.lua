-- load options and keymaps
require("config.options")
require("config.keymaps")

-- grab the manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- load config modules
require("config.autocmds")
require("config.highlights").setup()

-- start steup
require("lazy").setup({
	spec = { { import = "plugins" } },
	checker = {
		enabled = false, -- don't check for plugin updates periodically
		notify = false, -- don't notify on update
	},
	change_detection = {
		enabled = true, -- auto-reload on config file changes
		notify = false, -- don't show notif in status line
	},
})
