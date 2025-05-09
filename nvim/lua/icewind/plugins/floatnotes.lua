return {
    "icewind/floatnotes.nvim",
    opts = {},
    config = function()
        require("floatnotes").setup({
            global_notes_file_path = os.getenv("GLOBAL_NOTES_PATH"),
        })
        vim.keymap.set("n", "<leader>fn", ":FloatNotes<CR>", { silent = true, noremap = true })
    end,
}
