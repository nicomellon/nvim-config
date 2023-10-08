local icons = require("config.icons")

-- LSP Configuration & Plugins
return {

	{ "folke/neodev.nvim" }, -- Provides useful lua config for nvim

	{
		-- Hook external tools into nvim's LSP
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			null_ls.setup({
				sources = {
					null_ls.builtins.diagnostics.mypy,
					null_ls.builtins.formatting.autoflake,
					null_ls.builtins.formatting.black,
					null_ls.builtins.formatting.isort,
					null_ls.builtins.formatting.stylua,
				},
			})
		end,
	},

	{
		"neovim/nvim-lspconfig",
		dependencies = {},
		config = function()
			local lspconfig = require("lspconfig")
			lspconfig.clangd.setup({})
			lspconfig.lua_ls.setup({})
			lspconfig.pyright.setup({})

			-- Create an augroup that is used for managing our formatting autocmds.
			--      We need one augroup per client to make sure that multiple clients
			--      can attach to the same buffer without interfering with each other.
			local _augroups = {}
			local get_augroup = function(client)
				if not _augroups[client.id] then
					local group_name = "lsp-format-" .. client.name
					local id = vim.api.nvim_create_augroup(group_name, { clear = true })
					_augroups[client.id] = id
				end

				return _augroups[client.id]
			end

			-- Use LspAttach autocommand to only map the following keys
			-- after the language server attaches to the current buffer
			vim.api.nvim_create_autocmd("LspAttach", {
				group = vim.api.nvim_create_augroup("UserLspConfig", {}),
				callback = function(ev)
					-- Enable completion triggered by <c-x><c-o>
					vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

					-- Buffer local mappings.
					-- See `:help vim.lsp.*` for documentation on any of the below functions
					vim.keymap.set(
						"n",
						"gD",
						vim.lsp.buf.declaration,
						{ buffer = ev.buf, desc = "Lsp [G]oto [D]eclaration" }
					)
					vim.keymap.set(
						"n",
						"gd",
						vim.lsp.buf.definition,
						{ buffer = ev.buf, desc = "Lsp [G]oto [d]efinition" }
					)
					vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = ev.buf, desc = "Lsp Hover documentation" })
					vim.keymap.set(
						"i",
						"<C-k>",
						vim.lsp.buf.signature_help,
						{ buffer = ev.buf, desc = "LSP Signature Help" }
					)
					vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, { buffer = ev.buf, desc = "Lsp [r]e[n]ame" })
					vim.keymap.set(
						{ "n", "v" },
						"<space>ca",
						vim.lsp.buf.code_action,
						{ buffer = ev.buf, desc = "Lsp [c]ode [a]ction" }
					)

					-- Format on save for clients that support vim.lsp.buf.format()
					local client = vim.lsp.get_client_by_id(ev.data.client_id)
					if not client.server_capabilities.documentFormattingProvider then
						return
					end

					vim.api.nvim_create_autocmd("BufWritePre", {
						group = get_augroup(client),
						buffer = ev.buf,
						callback = function()
							vim.lsp.buf.format({
								async = false,
								filter = function(c)
									return c.id == client.id
								end,
							})
						end,
					})
				end,
			})

			-- Override diagnostic signs in the gutter
			local signs = {
				Error = icons.diagnostics.Error,
				Warn = icons.diagnostics.Warn,
				Hint = icons.diagnostics.Hint,
				Info = icons.diagnostics.Info,
			}
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end
		end,
	},
}
