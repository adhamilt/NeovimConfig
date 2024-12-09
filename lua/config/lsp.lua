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
      { "K", "<cmd>lua vim.lsp.buf.hover()<cr>", desc = "Lsp Hover Action", mode = "n", buffer = event.buf },
      { "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", desc = "Goto Definition", mode = "n", buffer = event.buf },
      { "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", desc = "Goto Declaration", mode = "n", buffer = event.buf },
      {
        "gi",
        "<cmd>lua vim.lsp.buf.implementation()<cr>",
        desc = "Goto Implementation",
        mode = "n",
        buffer = event.buf,
      },
      {
        "go",
        "<cmd>lua vim.lsp.buf.type_definition()<cr>",
        desc = "Goto Type Definition",
        mode = "n",
        buffer = event.buf,
      },
      { "gr", "<cmd>lua vim.lsp.buf.references()<cr>", desc = "Goto References", mode = "n", buffer = event.buf },
      { "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", desc = "Goto Signature", mode = "n", buffer = event.buf },
      { "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", desc = "Lsp Rename", mode = "n", buffer = event.buf },
      {
        "<F3>",
        "<cmd>lua vim.lsp.buf.format({async = true})<cr>",
        desc = "Lsp Format",
        mode = "x",
        buffer = event.buf,
      },
      { "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", desc = "Lsp Code Action", mode = "n", buffer = event.buf },
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
