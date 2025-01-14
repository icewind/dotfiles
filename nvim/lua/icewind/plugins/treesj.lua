return {
    "Wansmer/treesj",
    keys = { "<leader>bm", "<leader>bj", "<leader>bs" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
        require("treesj").setup({
            use_default_keymaps = false,
        })

        vim.keymap.set("n", "<leader>bm", require("treesj").toggle, { desc = "[?] Toggle block split" })

        vim.keymap.set("n", "<leader>bs", require("treesj").split, { desc = "[?] Split block" })

        vim.keymap.set("n", "<leader>bj", require("treesj").split, { desc = "[?] Join block" })
    end,
}
