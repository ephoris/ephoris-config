return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    animate = { enabled = false },
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true, animate = { enabled = false }, },
    input = { enabled = true },
    lazygit = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
  },
  keys = function()
    local Snacks = require('snacks')
    return {
      { "<leader>,",       function() Snacks.picker.buffers() end,              desc = "Buffers" },
      { "<leader>/",       function() Snacks.picker.grep() end,                 desc = "Grep" },
      { "<leader>:",       function() Snacks.picker.command_history() end,      desc = "Command History" },
      { "<leader><space>", function() Snacks.picker.files() end,                desc = "Find Files" },
      -- find
      { "<leader>fb",      function() Snacks.picker.buffers() end,              desc = "Buffers" },
      { "<leader>ff",      function() Snacks.picker.files() end,                desc = "Find Files" },
      { "<leader>fr",      function() Snacks.picker.recent() end,               desc = "Recent" },
      { "<leader>fh",      function() Snacks.picker.help() end,                 desc = "Help Pages" },
      { "<leader>fc",      function() Snacks.picker.command_history() end,      desc = "Command History" },
      { "<leader>fC",      function() Snacks.picker.commands() end,             desc = "Commands" },
      -- find via grep
      { "<leader>fl",      function() Snacks.picker.lines() end,                desc = "Buffer Lines" },
      { "<leader>fB",      function() Snacks.picker.grep_buffers() end,         desc = "Grep Open Buffers" },
      { "<leader>fg",      function() Snacks.picker.grep() end,                 desc = "Grep" },
      { "<leader>fw",      function() Snacks.picker.grep_word() end,            desc = "Visual selection or word", mode = { "n", "x" } },
      -- git
      { "<leader>gc",      function() Snacks.picker.git_log() end,              desc = "Git Log" },
      { "<leader>gl",      function() Snacks.lazygit() end,                     desc = "Lazygit" },
      -- LSP
      { "gd",              function() Snacks.picker.lsp_definitions() end,      desc = "Goto Definition" },
      { "gD",              function() Snacks.picker.lsp_declarations() end,     desc = "Goto Declarations" },
      { "gr",              function() Snacks.picker.lsp_references() end,       nowait = true,                     desc = "References" },
      { "gi",              function() Snacks.picker.lsp_implementations() end,  desc = "Goto Implementation" },
      { "gy",              function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
      { "<leader>fs",      function() Snacks.picker.lsp_symbols() end,          desc = "LSP Symbols" },
    }
  end,
}
