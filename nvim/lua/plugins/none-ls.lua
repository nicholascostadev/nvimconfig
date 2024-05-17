return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim"
  },
  config = function()
    local null_ls = require("null-ls")

    -- Auto format on save
    local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.stylua,

        require('none-ls.diagnostics.eslint_d'),
        -- require('none-ls.formatting.eslint_d'),
        require('none-ls.code_actions.eslint_d'),
        -- null_ls.builtins.formatting.prettierd.with({
        --   env = {
        --     PRETTIERD_LOCAL_PRETTIER_ONLY = 1,
        --   },
        -- }),

        -- null_ls.builtins.diagnostics.eslint_d.with({
        --   extra_filetypes = { "svelte" },
        -- }),
        -- null_ls.builtins.code_actions.eslint_d.with({
        --   extra_filetypes = { "svelte" },
        -- }),
        -- null_ls.builtins.formatting.eslint_d.with({
        --   extra_filetypes = { "svelte" },
        -- }),
        -- null_ls.builtins.formatting.prettier.with({
        --   extra_filetypes = { "svelte" },
        -- }),
        null_ls.builtins.formatting.prismaFmt,
      },
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
          -- Format on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
              -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
              vim.lsp.buf.format({ async = false })
            end,
          })
        end
      end,
    })

    vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
  end,
}
