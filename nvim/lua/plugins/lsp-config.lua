return {
  {
    "NvChad/nvim-colorizer.lua",
    dependencies = {
      { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
    },
    lazy = false,
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "tsserver", "svelte" },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      vim.keymap.set("n", "<leader>L", vim.diagnostic.open_float)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
      vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist)

      local handlers = {
        ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
          silent = true,
        }),
        ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help),
        ["textDocument/publishDiagnostics"] = vim.lsp.with(
          vim.lsp.diagnostic.on_publish_diagnostics
        ),
      }

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
      })

      lspconfig.eslint.setup({
        capabilities = capabilities,
        handlers = handlers,
        on_attach = function(client, bufnr)
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            command = "EslintFixAll",
          })
        end,
        settings = {
          codeAction = {
            disableRuleComment = {
              enable = true,
              location = "separateLine"
            },
            showDocumentation = {
              enable = true
            }
          },
          codeActionOnSave = {
            enable = false,
            mode = "all"
          },
          format = true,
          nodePath = "",
          onIgnoredFiles = "off",
          packageManager = "npm",
          quiet = false,
          rulesCustomizations = {},
          run = "onType",
          useESLintClass = false,
          validate = "on",
          workingDirectory = {
            mode = "location"
          }
        }
      })

      lspconfig.tsserver.setup({
        capabilities = capabilities,
        on_attach = function(client)
          client.resolved_capabilities.document_formatting = false
        end,
      })

      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        filetypes = { "rust" },
        root_dir = require("lspconfig/util").root_pattern("Cargo.toml"),
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
            },
          },
        },
      })

      -- SVELTE AUTO GENERATED TYPES -- START
      local function on_attach(on_attach2)
        vim.api.nvim_create_autocmd("LspAttach", {
          callback = function(args)
            local buffer = args.buf
            local client = vim.lsp.get_client_by_id(args.data.client_id)
            on_attach2(client, buffer)
          end,
        })
      end

      on_attach(function(client)
        vim.api.nvim_create_autocmd("BufWritePre", {
          pattern = { "*.rs" },
          callback = function()
            vim.cmd([[ RustFmtRange ]])
          end,
        })
      end)

      on_attach(function(client)
        vim.api.nvim_create_autocmd("BufWritePost", {
          pattern = { "*.js", "*.ts" },
          callback = function(ctx)
            if client.name == "svelte" then
              client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.file })
            end
          end,
        })
      end)

      -- SVELTE AUTO GENERATED TYPES -- END
      lspconfig.svelte.setup({
        capabilities = capabilities,
        flags = {
          debounce_text_changes = 150,
        },
      })

      lspconfig.tailwindcss.setup({})

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local telescope_builtins = require("telescope.builtin")
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "gr", telescope_builtins.lsp_references, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
        end,
      })
    end,
  },
}
