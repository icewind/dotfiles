return {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    init = function()
        -- `no_plugin_maps` is unrelated to this plugin; remove the stale global.
    end,
    config = function()
        local select = require("nvim-treesitter-textobjects.select")
        local move = require("nvim-treesitter-textobjects.move")
        local swap = require("nvim-treesitter-textobjects.swap")

        require("nvim-treesitter-textobjects").setup({
            select = {
                lookahead = true,
            },
            move = {
                set_jumps = true,
            },
        })

        -- Selection (operator-pending + visual)
        vim.keymap.set({ "x", "o" }, "aa", function()
            select.select_textobject("@parameter.outer")
        end, { desc = "Outer parameter" })
        vim.keymap.set({ "x", "o" }, "ia", function()
            select.select_textobject("@parameter.inner")
        end, { desc = "Inner parameter" })
        vim.keymap.set({ "x", "o" }, "af", function()
            select.select_textobject("@function.outer")
        end, { desc = "Outer function" })
        vim.keymap.set({ "x", "o" }, "if", function()
            select.select_textobject("@function.inner")
        end, { desc = "Inner function" })
        vim.keymap.set({ "x", "o" }, "ac", function()
            select.select_textobject("@class.outer")
        end, { desc = "Outer class" })
        vim.keymap.set({ "x", "o" }, "ic", function()
            select.select_textobject("@class.inner")
        end, { desc = "Inner class" })

        -- Move
        vim.keymap.set({ "n", "x", "o" }, "]m", function()
            move.goto_next_start("@function.outer")
        end, { desc = "Next function start" })
        vim.keymap.set({ "n", "x", "o" }, "]]", function()
            move.goto_next_start("@class.outer")
        end, { desc = "Next class start" })
        vim.keymap.set({ "n", "x", "o" }, "]M", function()
            move.goto_next_end("@function.outer")
        end, { desc = "Next function end" })
        vim.keymap.set({ "n", "x", "o" }, "][", function()
            move.goto_next_end("@class.outer")
        end, { desc = "Next class end" })
        vim.keymap.set({ "n", "x", "o" }, "[m", function()
            move.goto_previous_start("@function.outer")
        end, { desc = "Prev function start" })
        vim.keymap.set({ "n", "x", "o" }, "[[", function()
            move.goto_previous_start("@class.outer")
        end, { desc = "Prev class start" })
        vim.keymap.set({ "n", "x", "o" }, "[M", function()
            move.goto_previous_end("@function.outer")
        end, { desc = "Prev function end" })
        vim.keymap.set({ "n", "x", "o" }, "[]", function()
            move.goto_previous_end("@class.outer")
        end, { desc = "Prev class end" })

        -- Swap
        vim.keymap.set("n", "<leader>a", function()
            swap.swap_next("@parameter.inner")
        end, { desc = "Swap parameter next" })
        vim.keymap.set("n", "<leader>A", function()
            swap.swap_previous("@parameter.inner")
        end, { desc = "Swap parameter prev" })
    end,
}
