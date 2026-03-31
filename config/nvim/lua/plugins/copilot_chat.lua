return {
	"CopilotC-Nvim/CopilotChat.nvim",
	-- version = "v3.12.2",
	dependencies = {
		{ "nvim-lua/plenary.nvim", branch = "master" },
	},
	build = "make tiktoken",
	opts = {
		model = "claude-sonnet-4.6",

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
					local exclude_patterns = {
						"__pycache__",
						"%.pyc$",
						"/test/",
						"/tests/",
						"_test%.",
						"%.test%.",
						"/node_modules/",
						"/.git/",
						"/%.git/",
					}

					local function is_excluded(filepath)
						for _, pattern in ipairs(exclude_patterns) do
							if filepath:find(pattern) then
								return true
							end
						end
						return false
					end

					local dir_path = vim.fn.expand(input.path)
					if not Path:new(dir_path):is_dir() then
						vim.notify("Not a valid directory: " .. dir_path, vim.log.levels.WARN)
						return results
					end

					scandir.scan_dir(dir_path, {
						hidden = false,
						add_dirs = false,
						respect_gitignore = true,
						on_insert = function(file)
							if is_excluded(file) then
								return
							end
							local p = Path:new(file)
							if p:is_file() then
								local ok, content = pcall(function()
									return p:read()
								end)
								if ok and content then
									table.insert(results, {
										uri = "file://" .. file,
										mimetype = "text/plain",
										data = content,
									})
								end
							end
						end,
					})

					return results
				end,
			},
			load_wud = {
				description = "Loads all files from wud project into the buffer",
				resolve = function()
					local results = {}
					local load_directory = require("CopilotChat").config.functions.load_directory
					local paths = {
						"/home/sshaw/bdai/projects/watch_understand_do/src/wud/",
						"/home/sshaw/bdai/projects/watch_understand_do/src/config/",
						"/home/sshaw/bdai/projects/watch_understand_do/ws/src/wud_msgs/",
						"/home/sshaw/bdai/projects/watch_understand_do/ws/src/wud_ros/wud_ros/",
						"/home/sshaw/bdai/projects/watch_understand_do/ws/src/wud_ros/config/",
						"/home/sshaw/bdai/projects/watch_understand_do/ws/src/wud_ros/launch",
					}
					for _, path in ipairs(paths) do
						local files = load_directory.resolve({ path = path })
						vim.list_extend(results, files)
					end
					return results
				end,
			},
		},
	},
}
