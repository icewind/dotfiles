return {
    "nvim-telescope/telescope.nvim",
    version = false,
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-tree/nvim-web-devicons",
        "nvim-telescope/telescope-ui-select.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local lga_actions = require("telescope-live-grep-args.actions")
        telescope.setup({
            extensions = {
                ["ui-select"] = {
                    require("telescope.themes").get_dropdown({}),
                },
                ["live_grep_args"] = {
                    auto_quoting = true,
                    mappings = {
                        i = {
                            ["<C-a>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
                        },
                    },
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
                        ["<c-f>"] = require("telescope.actions").to_fuzzy_refine,
                    },
                },
            },
        })

        telescope.load_extension("live_grep_args")

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
        vim.keymap.set(
            "n",
            "<leader>sg",
            require("telescope").extensions.live_grep_args.live_grep_args,
            { desc = "[S]earch by [G]rep" }
        )
        vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })

        vim.keymap.set("n", "<leader>gs", require("telescope.builtin").git_status, { desc = "[G]it [S]tatus" })
    end,
}
