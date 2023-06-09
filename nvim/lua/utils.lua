local Utils = {}

local path_separator = package.config:sub(1, 1)
local root_path = table.concat({ vim.fn.stdpath("config"), "lua" }, path_separator)

-- Locate all lua files in the specific folder
function Utils.files_in_folder(segments)
	if type(segments) ~= "table" then
		segments = { segments }
	end

	local path = { root_path }
	for _, segment in ipairs(segments) do
		table.insert(path, segment)
	end

	local fullpath = table.concat(path, path_separator)

	local files = vim.fn.split(vim.fn.globpath(fullpath, "*.lua"), "\n")
	local results = {}
	for _, file in ipairs(files) do
		table.insert(results, file:match("^.+/(.+).lua$"))
	end
	return results
end

return Utils
