-- Harpoon
-- Getting where you want with the fewest keystrokes

return {
	"ThePrimeagen/harpoon",
	opts = {
		projects = {
			["$HOME/nester/core"] = {
				term = {
					cmds = {
						"python partisan test",
						"python partisan test --only unit",
						"python partisan test --only feature",
						"python partisan test --only integration",
					},
				},
			},
		},
	},
	config = function(_, opts)
		require("harpoon").setup(opts)

		local function map(mode, l, r, opts_)
			opts_ = opts_ or {}
			vim.keymap.set(mode, l, r, opts_)
		end

		-- file navigation (marks)
		map("n", "<leader>ma", function()
			require("harpoon.mark").add_file()
		end)
		map("n", "<leader>mm", function()
			require("harpoon.ui").toggle_quick_menu()
		end)
		map("n", "<leader>mn", function()
			require("harpoon.ui").nav_file(1)
		end)
		map("n", "<leader>me", function()
			require("harpoon.ui").nav_file(2)
		end)
		map("n", "<leader>mi", function()
			require("harpoon.ui").nav_file(3)
		end)
		map("n", "<leader>mo", function()
			require("harpoon.ui").nav_file(4)
		end)

		-- term commands
		map("n", "<leader>tm", function()
			require("harpoon.cmd-ui").toggle_quick_menu()
		end)
		map("n", "<leader>tn", function()
			require("harpoon.term").gotoTerminal(1)
		end)
		map("n", "<leader>te", function()
			require("harpoon.term").gotoTerminal(2)
		end)
		map("n", "<leader>ti", function()
			require("harpoon.term").gotoTerminal(3)
		end)
		map("n", "<leader>to", function()
			require("harpoon.term").gotoTerminal(4)
		end)
	end,
}
