return {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    dependencies = { 'nvim-orgmode/org-bullets.nvim' },
    config = function()
        local orgpath = vim.ORGFILES_PATH or '~/projects/orgfiles/'
        require('orgmode').setup({
            org_agenda_files = orgpath .. '**/*',
            org_default_notes_file = vim.fs.joinpath(orgpath, 'refile.org'),
            org_capture_templates = {
                n = {
                    description = "Note",
                    template = "",
                    target = vim.fs.joinpath(orgpath, 'notes.org'),
                }
            },
            mappings = {
                org_return_uses_meta_return = false,
                org = {
                    org_toggle_checkbox = { 'cix', desc = 'Toggle checkbox' },
                }
            },
        })

        require('org-bullets').setup({
            symbols = {
                checkboxes = {
                    half = { "-", "@org.checkbox.halfchecked" },
                    done = { "✓", "@org.keyword.done" },
                    todo = { " ", "@org.keyword.todo" },
                },
            },
        })
    end,
}
