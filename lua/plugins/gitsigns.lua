-- Gitsigns.nvim
-- Adds git related signs to the gutter, as well as utilities for managing changes

local icons = require("config.icons")

return {
	"lewis6991/gitsigns.nvim",
	opts = {
		signs = {
			add = { text = icons.git.added },
			change = { text = icons.git.modified },
			delete = { text = icons.git.removed },
			topdelete = { text = icons.git.removed },
			changedelete = { text = icons.git.removed },
		},
		on_attach = function(bufnr)
			local gs = package.loaded.gitsigns

			local function map(mode, l, r, opts)
				opts = opts or {}
				opts.buffer = bufnr
				vim.keymap.set(mode, l, r, opts)
			end

			map("n", "[h", gs.prev_hunk, { desc = "Previous hunk" })
			map("n", "]h", gs.next_hunk, { desc = "Next hunk" })
			map("n", "<leader>hd", gs.diffthis, { desc = "Hunk diff" })
			map("n", "<leader>hr", gs.reset_hunk, { desc = "Reset hunk" })
		end,
	},
}
