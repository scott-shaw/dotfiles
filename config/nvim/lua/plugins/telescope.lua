return {
	{
		"nvim-telescope/telescope.nvim",
		branch = "0.1.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
			{
				"nvim-telescope/telescope-fzf-native.nvim",
				-- Build command to compile the extension
				build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release --target install",
				-- or just 'make' if you prefer
			},
		},
		config = function()
			require("telescope").setup({
				defaults = {
					path_display = { "smart" },
					borderchars = {
						--           N    E    S    W   NW   NE   SE   SW
						prompt = { "─", " ", " ", " ", " ", " ", " ", " " },
						results = { " ", " ", " ", " ", " ", " ", " ", " " },
						preview = { " ", " ", " ", "│", " ", " ", " ", " " },
					},
					layout_config = {
						horizontal = {
							width = function(_, cols, _)
								return cols
							end,
							height = function(_, _, rows)
								return rows
							end,
							mirror = false,
							prompt_position = "bottom",
						},
						preview_cutoff = 10,
						preview_width = 0.5,
					},
					vimgrep_arguments = {
						"rg",
						"--follow", -- Follow symbolic links
						-- "--hidden", -- Search for hidden files
						"--no-heading", -- Don't group matches by each file
						"--with-filename", -- Print the file path with the matched lines
						"--line-number", -- Show line numbers
						"--column", -- Show column numbers
						"--smart-case", -- Smart case search
						"--no-ignore", -- Don't respect .gitignore and other ignore files
						-- "--unrestricted", -- Don't respect .gitignore and other ignore files

						-- Exclude some patterns from search
						"--glob=!**/.git/*",
						"--glob=!**/.idea/*",
						"--glob=!**/.vscode/*",
						"--glob=!**/build/*",
						"--glob=!**/dist/*",
						"--glob=!**/yarn.lock",
						"--glob=!**/package-lock.json",
					},
				},
				extensions = {
					fzf = {
						fuzzy = true,
						override_generic_sorter = true,
						override_file_sorter = true,
						case_mode = "smart_case",
					},
				},
			})
			require("telescope").load_extension("fzf")
		end,
	},
}
