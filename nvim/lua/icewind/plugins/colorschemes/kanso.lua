return {
    "webhooked/kanso.nvim",
    lazy = false,
    priority = 1000,
    opts = {
        bold = false,
        italics = false,
        background = {
            dark = "mist",
        },
        overrides = function(colors)
            return {
                WinSeparator = { fg = colors.palette.gray5 },
                TelescopeBorder = { fg = colors.palette.gray5 },
                Pmenu = { bg = colors.palette.mistBg2 },
            }
        end,
    },
}
