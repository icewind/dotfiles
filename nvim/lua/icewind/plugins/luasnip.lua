return {
    "L3MON4D3/LuaSnip",
    -- follow latest release.
    version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    -- install jsregexp (optional!).
    build = "make install_jsregexp",
    config = function()
        local ls = require("luasnip")

        vim.keymap.set({ "i", "s" }, "<A-j>", function()
            if ls.expand_or_jumpable() then
                ls.expand_or_jump()
            end
        end, { silent = true })

        vim.keymap.set({ "i", "s" }, "<A-k>", function()
            if ls.jumpable(-1) then
                ls.jump(-1)
            end
        end, { silent = true })

        ls.filetype_extend("typescript", { "javascript" })

        require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/icewind/snippets" })
    end,
}
