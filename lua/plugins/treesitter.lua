-- Treesitter
-- highlight, edit, and navigate code

return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
	build = ":TSUpdate",
	opts = {
		ensure_installed = { "bash", "dockerfile", "gitcommit", "lua", "norg", "php", "python", "sql", "yaml" },
		highlight = { enable = true },
		indent = { enable = true },
	},
	config = function(_, opts)
		require("nvim-treesitter.configs").setup(opts)
	end,
}
