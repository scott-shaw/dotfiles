return {
	"CopilotC-Nvim/CopilotChat.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim", branch = "master" },
	},
	build = "make tiktoken",
	opts = {
		model = "claude-sonnet-4.5",

		window = {
			layout = "vertical", -- 'vertical', 'horizontal', 'float'
			width = 0.5, -- 50% of screen width
		},

		headers = {
			user = " ", -- Header to use for user questions
			assistant = "  ", -- Header to use for AI answers
			tool = " ", -- Header to use for tool calls
		},

		separator = "━━",
		show_folds = true, -- Disable folding for cleaner look
		auto_insert_mode = false, -- Enter insert mode when opening

		functions = {
			load_directory = {
				description = "Recursively loads all files from a directory into the buffer",
				uri = "directory://{path}",
				schema = {
					type = "object",
					required = { "path" },
					properties = {
						path = {
							type = "string",
							description = "Directory path to load files from",
						},
					},
				},
				resolve = function(input)
					local Path = require("plenary.path")
					local scandir = require("plenary.scandir")
					local results = {}

					local dir_path = vim.fn.expand(input.path)
					scandir.scan_dir(dir_path, {
						hidden = false,
						add_dirs = false,
						respect_gitignore = true,
						search_pattern = "%.py$",
						on_insert = function(file)
							if not file:match("test_") and not file:match("_test%.py$") then
								local content = Path:new(file):read()
								table.insert(results, {
									uri = "file://" .. file,
									mimetype = "text/plain",
									data = content,
								})
							end
						end,
					})

					return results
				end,
			},
		},
	},
}
