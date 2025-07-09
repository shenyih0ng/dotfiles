return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  config = function()
    vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle<CR>")
    require("neo-tree").setup {
      close_if_last_window = true,
      window = { position = "right" },
      filesystem = {
        filtered_items = {
          visible = true,
          never_show = { ".DS_Store" }
        }
      }
    }
  end
}
