-- Neorg
-- Life organization

return {
	"nvim-neorg/neorg",
	build = ":Neorg sync-parsers",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("neorg").setup({
			load = {
				["core.defaults"] = {}, -- Loads default behaviour
				["core.concealer"] = {}, -- Adds pretty icons to your documents
				["core.dirman"] = {  -- Manages Neorg workspaces
					config = {
						workspaces = {
							nester = "~/nester/notes",
						},
						default_workspace = "nester",
					},
				},
				["core.summary"] = {}, -- Creates links and annotations to all files in a given workspace
			},
		})
	end,
}
