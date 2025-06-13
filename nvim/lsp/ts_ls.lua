return function(utils)
    return {
        init_options = {
            preferences = {
                disableSuggestions = true,
            },
        },
        root_dir = utils.root_pattern("project.json"),
        -- single_file_support = false,
    }
end
