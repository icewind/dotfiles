return {
    "NeogitOrg/neogit",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
    },
    config = function()
        local actions = require("diffview.actions")
        require("diffview").setup({
            view = {
                merge_tool = {
                    layout = "diff3_mixed",
                },
            },
            keymaps = {
                view = {
                    {
                        "n",
                        "<leader>ao",
                        actions.conflict_choose("ours"),
                        { desc = "Apply the OURS version of a conflict" },
                    },
                    {
                        "n",
                        "<leader>at",
                        actions.conflict_choose("theirs"),
                        { desc = "Apply the THEIRS version of a conflict" },
                    },
                    {
                        "n",
                        "<leader>ab",
                        actions.conflict_choose("base"),
                        { desc = "Apply the BASE version of a conflict" },
                    },
                    {
                        "n",
                        "<leader>aa",
                        actions.conflict_choose("all"),
                        { desc = "Apply all the versions of a conflict" },
                    },
                    {
                        "n",
                        "<leader>aO",
                        actions.conflict_choose_all("ours"),
                        { desc = "Apply the OURS version of a conflict for the whole file" },
                    },
                    {
                        "n",
                        "<leader>aT",
                        actions.conflict_choose_all("theirs"),
                        { desc = "Apply the THEIRS version of a conflict for the whole file" },
                    },
                    {
                        "n",
                        "<leader>aB",
                        actions.conflict_choose_all("base"),
                        { desc = "Apply the BASE version of a conflict for the whole file" },
                    },
                    {
                        "n",
                        "<leader>aA",
                        actions.conflict_choose_all("all"),
                        { desc = "Apply all the versions of a conflict for the whole file" },
                    },
                },
            },
        })

        local neogit = require("neogit")
        neogit.setup({
            kind = "split",
        })

        vim.keymap.set("n", "<leader>ng", ":Neogit<CR>", { desc = "[N]eo[G]it" })
    end,
}
