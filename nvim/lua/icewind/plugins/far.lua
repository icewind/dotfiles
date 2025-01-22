return {
    "MagicDuck/grug-far.nvim",
    config = function()
        local grug_far = require("grug-far")
        grug_far.setup()

        vim.keymap.set("n", "<leader>fr", function()
            grug_far.open({ transient = true })
        end, { desc = "[?] Find And Replace" })
    end,
}
