return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        local gitsigns = require("gitsigns")

        gitsigns.setup({
            numhl = true,
            signcolumn = true,
            on_attach = function(bufnr)
                local function map(mode, lhs, rhs, opts)
                    opts = vim.tbl_extend("force", { noremap = true, silent = true, buffer = bufnr }, opts or {})
                    vim.keymap.set(mode, lhs, rhs, opts)
                end

                -- Navigation
                map("n", "]c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]c", bang = true })
                    else
                        gitsigns.next_hunk()
                    end
                end, { desc = "Next hunk" })
                map("n", "[c", function()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[c", bang = true })
                    else
                        gitsigns.prev_hunk()
                    end
                end, { desc = "Prev hunk" })

                -- Actions
                map({ "n", "v" }, "<leader>hs", function()
                    gitsigns.stage_hunk()
                end, { desc = "Stage hunk" })
                map({ "n", "v" }, "<leader>hr", function()
                    gitsigns.reset_hunk()
                end, { desc = "Reset hunk" })
                map("n", "<leader>hS", function()
                    gitsigns.stage_buffer()
                end, { desc = "Stage buffer" })
                map("n", "<leader>hu", function()
                    gitsigns.undo_stage_hunk()
                end, { desc = "Undo stage hunk" })
                map("n", "<leader>hR", function()
                    gitsigns.reset_buffer()
                end, { desc = "Reset buffer" })
                map("n", "<leader>hp", function()
                    gitsigns.preview_hunk()
                end, { desc = "Preview hunk" })
                map("n", "<leader>hb", function()
                    gitsigns.blame_line({ full = true })
                end, { desc = "Blame line (full)" })
                map("n", "<leader>tb", function()
                    gitsigns.toggle_current_line_blame()
                end, { desc = "Toggle current line blame" })
                map("n", "<leader>hd", function()
                    gitsigns.diffthis()
                end, { desc = "Diff this" })
                map("n", "<leader>hD", function()
                    gitsigns.diffthis("~")
                end, { desc = "Diff this (~)" })
                map("n", "<leader>td", function()
                    gitsigns.toggle_deleted()
                end, { desc = "Toggle deleted" })

                -- Text object
                map({ "o", "x" }, "ih", function()
                    gitsigns.select_hunk()
                end, { desc = "Select hunk" })
            end,
        })
    end,
}
