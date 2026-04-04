return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPre", "BufNewFile" },
    branch = "main",
    build = ":TSUpdate",
    lazy = false,
    dependencies = {
        "windwp/nvim-ts-autotag",
    },
    config = function()
        ---@diagnostic disable-next-line: missing-fields
        require("nvim-treesitter.config").setup({
            -- Add languages to be installed here that you want installed for treesitter
            ensure_installed = { "go", "lua", "python", "rust", "typescript", "markdown" },

            autotag = {
                enable = true,
            },

            highlight = { enable = true },
            indent = { enable = true, disable = { "python" } },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<c-space>",
                    node_incremental = "<c-space>",
                    scope_incremental = "<c-s>",
                    node_decremental = "<c-backspace>",
                },
            },
        })
    end,
}
