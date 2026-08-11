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
        -- nvim-treesitter `main` branch API: setup only accepts `install_dir`.
        -- Highlighting is enabled via `vim.treesitter.start()` in a FileType autocmd
        -- (see lua/icewind/core/autocommands.lua). Folding is handled by Neovim
        -- builtin via `vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"`.
        require("nvim-treesitter").setup({
            install_dir = vim.fn.stdpath("data") .. "/site",
        })

        -- Install missing parsers asynchronously; no-op if already installed.
        require("nvim-treesitter").install({
            "go",
            "lua",
            "python",
            "rust",
            "typescript",
            "markdown",
        })

        -- nvim-ts-autotag has its own setup on the new treesitter branch
        -- (the old `autotag = { enable = true }` module API is deprecated).
        require("nvim-ts-autotag").setup({})
    end,
}
