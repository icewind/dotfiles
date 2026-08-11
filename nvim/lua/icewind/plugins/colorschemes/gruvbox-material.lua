return {
    "sainnhe/gruvbox-material",
    lazy = true,
    priority = 1000,
    init = function()
        vim.g.gruvbox_material_enable_italic = 0
        vim.g.gruvbox_material_background = "soft"
        vim.g.gruvbox_material_better_performance = 1
        vim.g.gruvbox_material_transparent_background = 0
    end,
}
