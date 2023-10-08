return {
    "phaazon/hop.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local hop = require("hop")
        local directions = require("hop.hint").HintDirection
        hop.setup()

        vim.keymap.set({ "n", "v" }, "s", function()
            hop.hint_char1({ direction = directions.AFTERCURSOR })
        end, { remap = true })
        vim.keymap.set({ "n", "v" }, "S", function()
            hop.hint_char1({ direction = directions.BEFORECURSOR })
        end, { remap = true })
    end,
}
