-- Telescope
-- Fuzzy finder

return {
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = {
			{ "nvim-lua/plenary.nvim" },
			{ "nvim-tree/nvim-web-devicons" },
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
		cmd = "Telescope",
		lazy = false,
		config = function()
			require("telescope").setup({})
			require("telescope").load_extension("harpoon")
			require("telescope").load_extension("fzf")

			local function map(mode, l, r, opts)
				opts = opts or {}
				vim.keymap.set(mode, l, r, opts)
			end

			map("n", "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Fuzzy find in buffer" })
			map("n", "<leader>fb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
			map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find Files" })
			map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Live Grep" })
			map("n", "<leader>fh", "<cmd>Telescope help_tags<cr>", { desc = "Help Pages" })
			map("n", "<leader>fk", "<cmd>Telescope keymaps<cr>", { desc = "Key Maps" })
			map("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Recent Files" })
			map("n", "<leader>gb", "<cmd>Telescope git_branches<CR>", { desc = "git branches" })
			map("n", "<leader>gc", "<cmd>Telescope git_commits<CR>", { desc = "git commits" })
			map("n", "<leader>fs", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "LSP document symbols" })
			map("n", "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "LSP workspace symbols" })
			map("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "LSP references" })
		end,
	},
}
