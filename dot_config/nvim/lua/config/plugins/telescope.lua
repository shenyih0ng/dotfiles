return {
  "nvim-telescope/telescope.nvim",
  tag = "0.1.8",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("telescope").setup {
      defaults = {
        path_display = { "smart" },
        layout_config = {
          horizontal = { prompt_position = "top" },
        }
      },
    }

    local builtin = require("telescope.builtin")
    vim.keymap.set('n', '<leader>ff', builtin.find_files)
    vim.keymap.set('n', '<leader>fg', builtin.live_grep)
    vim.keymap.set('n', '<leader>fb', builtin.buffers)
    vim.keymap.set('n', '<leader>ft', builtin.treesitter)
    vim.keymap.set('n', '<leader>fd', builtin.diagnostics)
    vim.keymap.set('n', '<leader>cc', builtin.colorscheme)
  end
}
