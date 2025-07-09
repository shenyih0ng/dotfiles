return {
  'projekt0n/github-nvim-theme',
  config = function()
    require("github-theme").setup {
      options = {
        styles = {
          comments = "italic",
          keywords = "bold",
          types = "italic,bold"
        },
      },
    }
    vim.cmd("colorscheme github_dark_dimmed")
  end,
}
