local constants = require("icewind.core.constants")

local function get_highlights(color_scheme)
    if color_scheme:find("everforest") then
        return {
            fill = {
                bg = "#313C41",
                fg = "#7a8478",
            },
        }
    elseif color_scheme:find("gruvbox") then
        return {
            fill = {
                bg = "#262626",
            },
        }
    end

    return {}
end

return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VeryLazy",
    version = "*",
    opts = {
        options = {
            show_close_icon = false,
            show_buffer_close_icons = false,
        },
        highlights = get_highlights(constants.color_scheme),
    },
}
