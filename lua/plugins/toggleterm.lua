return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = true,
  keys = {
    {
      "<leader>T",
      "<cmd>ToggleTerm<cr>",
      desc = "Toggle Terminal",
    },
    {
      "<esc>",
      "<cmd>ToggleTerm<cr>",
      mode = "t",
    },
  },
  opts = {
    shell = vim.o.shell,
  },
}
