local M = {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = true
    }
  },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- "jay-babu/mason-nvim-dap.nvim",
    "saghen/blink.cmp"
  },
}

function M.config()
  local on_attach = function(client, bufnr)
    local function buf_set_option(...)
      vim.api.nvim_buf_set_option(bufnr, ...)
    end
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    buf_set_option('formatexpr', 'v:lua.vim.lsp.formatexpr()')
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
    end

    -- map("n", "gD", vim.lsp.buf.declaration, { desc = "Goto Declaration" })
    -- map("n", "gd", vim.lsp.buf.definition, { desc = "Goto Definition" })
    -- map("n", "gr", vim.lsp.buf.references, { desc = "Goto Reference" })
    -- map("n", "gi", vim.lsp.buf.implementation, { desc = "Goto Implementation" })
    -- map("n", "gy", vim.lsp.buf.type_definition, { desc = "Goto T[y]pe Definition" })
    map("n", "gk", function() vim.lsp.buf.signature_help() end, { desc = "Signature Help" })
    map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
    map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
    map("n", "<leader>ll", function() vim.diagnostic.open_float() end, { desc = "Open Diagnostic" })
    map("n", "<leader>q", function() vim.diagnostic.setloclist() end, { desc = "Set Local List" })
    -- map("n", "<leader>F", function() vim.lsp.buf.format({async=True}) end, {desc = "Format File"})
    map("n", "K", function() vim.lsp.buf.hover() end, { desc = "Hover" })
    map("n", "[d", function() vim.diagnostic.goto_prev() end, { desc = "Prev Diagnostic" })
    map("n", "]d", function() vim.diagnostic.goto_next() end, { desc = "Next Diagnostic" })
  end

  local capabilities = require('blink.cmp').get_lsp_capabilities({})

  local default_opts = {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" }
        },
      },
    },
  }

  require("mason").setup()
  require("mason-lspconfig").setup()
  -- require('mason-nvim-dap').setup()
  require('mason-lspconfig').setup_handlers({
    function(server_name)
      require('lspconfig')[server_name].setup(default_opts)
    end,
  })

  vim.api.nvim_create_autocmd("LspProgress", {
    ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
    callback = function(ev)
      local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
      vim.notify(vim.lsp.status(), "info", {
        id = "lsp_progress",
        title = "LSP Progress",
        opts = function(notif)
          notif.icon = ev.data.params.value.kind == "end" and " "
              or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
        end,
      })
    end,
  })
end

return M
