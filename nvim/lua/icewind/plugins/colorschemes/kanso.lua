return {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        bold = false,
        background = {
            dark = "mist",
        },
        overrides = function(colors)
            return {
                WinSeparator = { fg = colors.palette.gray5 },
            }
        end,
    },
}
