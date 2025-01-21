return {
    "nvim-telescope/telescope.nvim",
    version = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope-ui-select.nvim",
    },
    config = function()
        require("telescope").setup({
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({}),
                },
            },
            defaults = {
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                },
                preview = {
                    treesitter = false,
                },
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<c-d>"] = require("telescope.actions").delete_buffer,
                    },
                },
            },
        })

        -- Key mappings
        vim.keymap.set(
            "n",
            "<leader>sr",
            require("telescope.builtin").oldfiles,
            { desc = "[?] Find recently opened files" }
        )

        -- TODO: Check if this one will be helpful to me
        vim.keymap.set(
            "n",
            "<leader><space>",
            require("telescope.builtin").buffers,
            { desc = "[ ] Find existing buffers" }
        )

        -- TODO: Check if this one will be helpful to me
        vim.keymap.set("n", "<leader>/", function()
            -- You can pass additional configuration to telescope to change theme, layout, etc.
            require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
                winblend = 10,
                previewer = false,
            }))
        end, { desc = "[/] Fuzzily search in current buffer]" })

        vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
        vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
        vim.keymap.set(
            "n",
            "<leader>sw",
            require("telescope.builtin").grep_string,
            { desc = "[S]earch current [W]ord" }
        )
        vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
        vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

        vim.keymap.set("n", "<leader>gs", require("telescope.builtin").git_status, { desc = "[G]it [S]tatus" })

        -- Add backdrop to make floating window more contrast
        -- The code is from https://github.com/nvim-telescope/telescope.nvim/issues/3020#issuecomment-2439446111
        local blend = 70

        vim.api.nvim_create_autocmd("FileType", {
            pattern = "TelescopePrompt",
            callback = function(ctx)
                local backdropName = "TelescopeBackdrop"
                local telescopeBufnr = ctx.buf

                local telescopeZindex = 50

                local backdropBufnr = vim.api.nvim_create_buf(false, true)
                local winnr = vim.api.nvim_open_win(backdropBufnr, false, {
                    relative = "editor",
                    row = 0,
                    col = 0,
                    width = vim.o.columns,
                    height = vim.o.lines,
                    focusable = false,
                    style = "minimal",
                    zindex = telescopeZindex - 1,
                })

                vim.api.nvim_set_hl(0, backdropName, { bg = "#000000", default = true })
                vim.wo[winnr].winhighlight = "Normal:" .. backdropName
                vim.wo[winnr].winblend = blend
                vim.bo[backdropBufnr].buftype = "nofile"

                -- close backdrop when the reference buffer is closed
                vim.api.nvim_create_autocmd({ "WinClosed", "BufLeave" }, {
                    once = true,
                    buffer = telescopeBufnr,
                    callback = function()
                        if vim.api.nvim_win_is_valid(winnr) then
                            vim.api.nvim_win_close(winnr, true)
                        end
                        if vim.api.nvim_buf_is_valid(backdropBufnr) then
                            vim.api.nvim_buf_delete(backdropBufnr, { force = true })
                        end
                    end,
                })
            end,
        })
    end,
}
