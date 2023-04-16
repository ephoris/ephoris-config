return {
    "lukas-reineke/indent-blankline.nvim",
    event = "VeryLazy",
    config = function()
        vim.o.list = true
        vim.opt.listchars:append('lead:⋅')

        require("indent_blankline").setup({
            space_char_blankline = " ",
            show_current_context = true,
            show_current_context_start = true,
        })
    end,
}

