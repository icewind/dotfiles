return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
    },
    config = function()
        local neogit = require("neogit")
        neogit.setup({
            kind = "split",
        })
    end,
}
