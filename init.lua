-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = " "
vim.g.maplocalleader = ","

-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-- start plugins
require("lazy").setup("plugins")

-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Set relative line numbers
vim.o.relativenumber = true

-- Enable mouse mode
vim.o.mouse = "a"

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = "menuone,noselect"

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Keep visual selection after indenting
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- [[ Format the tabline ]]
-- See `:help setting-tabline`
local tabline_group = vim.api.nvim_create_augroup("TablineUpdate", { clear = true })
vim.api.nvim_create_autocmd({ "TabEnter", "TabLeave" }, {
	callback = function()
		local s = ""

		for tabn = 1, vim.fn.tabpagenr("$") do
			-- select the highlighting
			if tabn == vim.fn.tabpagenr() then
				s = s .. "%#TabLineSel#"
			else
				s = s .. "%#TabLine#"
			end

			-- set the tab page number (for mouse clicks)
			s = s .. "%" .. tabn .. "T"

			-- set the text label for the tag
			local cwd = vim.fn.getcwd(-1, tabn)
			while true do
				local i = string.find(cwd, "/", 0)
				if i ~= nil then
					cwd = string.sub(cwd, i + 1)
				else
					break
				end
			end
			s = s .. " " .. cwd .. " "
		end

		-- after the last tab fill with TabLineFill and reset tab page nr
		s = s .. "%#TabLineFill#%T"

		-- right-align the label to close the current tab page
		if vim.fn.tabpagenr("$") > 1 then
			s = s .. "%=%#TabLine#%999Xclose"
		end

		vim.o.tabline = s
	end,
	group = tabline_group,
	pattern = "*",
})
