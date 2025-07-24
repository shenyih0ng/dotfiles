return {
  "neovim/nvim-lspconfig",

  dependencies = {
    "mason-org/mason.nvim",
    "mason-org/mason-lspconfig.nvim",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "onsails/lspkind.nvim"
  },

  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup {
      ensure_installed = { "lua_ls", "tinymist", "pyright" },
    }

    vim.lsp.config("*", {
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      root_markers = { ".git", ".jj" }
    })

    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          runtime = { version = 'LuaJIT' },
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    })

    vim.lsp.enable({'rust_analyzer', 'pyrefly'})

    local cmp = require("cmp")
    local lspkind = require("lspkind")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }
    cmp.setup({
      window = {
        completion = { border = 'rounded', scrollbar = false },
        documentation = { border = 'rounded', scrollbar = false },
      },

      mapping = {
        ['<Up>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<Down>'] = cmp.mapping.select_next_item(cmp_select),

        ['<C-u>'] = cmp.mapping.scroll_docs(-4),
        ['<C-d>'] = cmp.mapping.scroll_docs(4),

        ['<C-e>'] = cmp.mapping.abort(),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ['<CR>'] = cmp.mapping.confirm({ select = false })
      },

      sources = cmp.config.sources({
        {
          name = "nvim_lsp",
          entry_filter = function(entry, _)
            return require("cmp").lsp.CompletionItemKind.Snippet ~= entry:get_kind()
          end,
        },
      }),

      formatting = {
        format = lspkind.cmp_format({
          mode = "symbol",
          menu = ({
            buffer = "[Buffer]",
            nvim_lsp = "[LSP]",
          })
        }),
      },
    })

    vim.diagnostic.config({
      virtual_lines = true,
      virtual_text = false,
      severity_sort = true,
      float = { border = 'rounded' },
    })

    local autocmd = vim.api.nvim_create_autocmd
    autocmd('LspAttach', {
      callback = function(e)
        local opts = { buffer = e.buf }
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ border = "rounded" }) end, opts)
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end , opts)
        vim.keymap.set("n", "<leader>k", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "<leader>lf", vim.lsp.buf.format)
      end
    })
  end
}
