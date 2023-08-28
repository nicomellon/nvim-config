-- telescope: fuzzy finder
return {
  {
    "nvim-telescope/telescope.nvim",
    commit = vim.fn.has("nvim-0.9.0") == 0 and "057ee0f8783" or nil,
    cmd = "Telescope",
    version = false, -- telescope did only one release, so use HEAD for now
    keys = {
      -- find
      { "<leader>/", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Fuzzy find in buffer" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fd", "<cmd>Telescope diagnostics bufnr=0<cr>", desc = "Document diagnostics" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Live Grep" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
      { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      -- git
      { "<leader>gc", "<cmd>Telescope git_commits<CR>", desc = "commits" },
      { "<leader>gs", "<cmd>Telescope git_status<CR>", desc = "status" },
      -- lsp
      { "<leader>ds", "<cmd>Telescope lsp_document_symbols<CR>", desc = "LSP document symbols" },
      { "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<CR>", desc = "LSP workspace symbols" },
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    cond = function()
      return vim.fn.executable "make" == 1
    end,
  },
}
