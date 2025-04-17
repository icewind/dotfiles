return {
    "shortcuts/no-neck-pain.nvim",
    version = "*",
    config = function()
        require("no-neck-pain").setup({
            -- colorcolumn is not working for some reason
            width = 120,
            mappings = {
                enabled = true,
                toggle = "<leader>lc",
            },
        })
    end,
}
