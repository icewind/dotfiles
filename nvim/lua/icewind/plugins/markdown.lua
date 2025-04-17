return {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function()
        require("render-markdown").setup({
            code = {
                enabled = true,
                border = "none",
            },
        })
    end,
}
