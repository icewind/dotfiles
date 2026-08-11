return {
    "icewind/floatnotes.nvim",
    event = "VeryLazy",
    config = function()
        require("floatnotes").setup({
            global_notes_file_path = os.getenv("GLOBAL_NOTES_PATH"),
            win = {
                border = "rounded",
            },
        })
        vim.keymap.set("n", "<leader>fn", ":FloatNotes<CR>", { silent = true, noremap = true })
    end,
}
