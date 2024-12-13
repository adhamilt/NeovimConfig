-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = "yes"

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require("lspconfig").util.default_config
lspconfig_defaults.capabilities =
  vim.tbl_deep_extend("force", lspconfig_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf }

    local wk = require("which-key")
    wk.add({
      { "<leader>cl", "<cmd>LspInfo<cr>", desc = "Lsp Info" },
      { "K", vim.lsp.buf.hover, desc = "Hover", mode = "n", buffer = event.buf },
      { "gd", vim.lsp.buf.definition, desc = "Goto Definition", mode = "n", buffer = event.buf },
      { "gD", vim.lsp.buf.declaration, desc = "Goto Declaration", mode = "n", buffer = event.buf },
      { "gy", vim.lsp.buf.type_definition, desc = "Goto T[y]pe Definition" },
      {
        "gi",
        vim.lsp.buf.implementation,
        desc = "Goto Implementation",
        mode = "n",
        buffer = event.buf,
      },
      {
        "go",
        vim.lsp.buf.type_definition,
        desc = "Goto Type Definition",
        mode = "n",
        buffer = event.buf,
      },
      { "gr", vim.lsp.buf.references, desc = "Goto References", mode = "n", buffer = event.buf },
      { "gs", vim.lsp.buf.signature_help, desc = "Goto Signature", mode = "n", buffer = event.buf },
      { "<F2>", vim.lsp.buf.rename, desc = "Lsp Rename", mode = "n", buffer = event.buf },
      {
        "<F3>",
        function()
          vim.lsp.buf.format({ async = true })
        end,
        desc = "Lsp Format",
        mode = "x",
        buffer = event.buf,
      },
      { "<F4>", vim.lsp.buf.code_action, desc = "Lsp Code Action", mode = "n", buffer = event.buf },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action", mode = { "n", "v" } },
      { "<leader>cc", vim.lsp.codelens.run, desc = "Run Codelens", mode = { "n", "v" } },
      { "<leader>cC", vim.lsp.codelens.refresh, desc = "Refresh & Display Codelens", mode = { "n" } },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
      {
        "<leader>uh",
        function()
          vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end,
        desc = "Toggle Inlay Hints",
        mode = { "n" },
      },
    })
  end,
})

local noop = function() end

require("mason").setup({})
require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      require("lspconfig")[server_name].setup({})
    end,
    rust_analyzer = noop,
  },
})
