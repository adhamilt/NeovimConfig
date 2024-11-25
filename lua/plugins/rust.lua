return {
  {
    "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    opts = {
      completion = {
        cmp = {
          enabled = true,
        },
      },
    },
  },
  {
    "mrcjkb/rustaceanvim",
    version = vim.fn.has("nvim-0.10.0") == 0 and "^4" or false,
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", "<leader>cR", function()
            vim.cmd.RustLsp("codeAction")
          end, {
            desc = "Code Action",
            buffer = bufnr,
          })
          vim.keymap.set("n", "<leader>dr", function()
            vim.cmd.RustLsp("debuggables")
          end, {
            desc = "Rust Debuggables",
            buffer = bufnr,
          })
        end,
        default_settings = {
          -- rust-analyzer language server configuration
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            -- Add clippy lints for Rust.
            checkOnSave = true,
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
        cmd = function()
          local mason_registry = require("mason-registry")
          if mason_registry.is_installed("rust-analyzer") then
            -- This may need to be tweaked depending on the operating system.
            local ra = mason_registry.get_package("rust-analyzer")
            local ra_filename = ra:get_receipt():get().links.bin["rust-analyzer"]
            return { ("%s/%s"):format(ra:get_install_path(), ra_filename or "rust-analyzer") }
          else
            -- global installation
            print("Using global rust-analyzer install")
            return { "rust-analyzer" }
          end
        end,
      },
    },
    config = function(_, opts)
      vim.g.rustaceanvim = vim.tbl_deep_extend("keep", vim.g.rustaceanvim or {}, opts or {})
      if vim.fn.executable("rust-analyzer") == 0 then
        LazyVim.error("**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/", {
          title = "rustaceanvim",
        })
      end
    end,
  },
}
