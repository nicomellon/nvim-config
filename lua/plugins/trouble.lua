-- Trouble.nvim
-- Useful diagnostics tools
--
local icons = require("config.icons")

return {
	"folke/trouble.nvim",
	opts = {
		signs = {
			error = icons.diagnostics.Error,
			warning = icons.diagnostics.Warn,
			hint = icons.diagnostics.Hint,
			information = icons.diagnostics.Info,
		},
	},
	config = function(_, opts)
		require("trouble").setup(opts)

		local function map(mode, l, r, opts_)
			opts_ = opts_ or {}
			vim.keymap.set(mode, l, r, opts_)
		end

		map("n", "<leader>tt", "<cmd>TroubleToggle<cr>", { desc = "Trouble Toggle" })
		map("n", "<leader>tw", "<cmd>Trouble workspace_diagnostics<cr>", { desc = "Trouble Workspace diagnostics" })
		map("n", "<leader>td", "<cmd>Trouble document_diagnostics<cr>", { desc = "Trouble Document diagnostics" })
	end,
}
