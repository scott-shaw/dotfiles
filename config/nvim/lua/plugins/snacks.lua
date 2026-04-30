return {
	"folke/snacks.nvim",
	---@type snacks.Config
	opts = {
		image = {
			enabled = true,
			doc = {
				inline = true, -- Render math/images inline in the document
				conceal = false, -- Hide the LaTeX source code when rendered
			},
		},
		indent = {
			enabled = true,
		},
		input = {
			enabled = true,
		},
		-- gh = {
		-- 	-- enabled = true,
		-- },
		-- picker = {
		-- 	-- enabled = true,
		-- 	sources = {
		-- 		gh_pr = {
		-- 			enabled = true,
		-- 		},
		-- 	},
		-- },
	},
	-- keys = {
	-- 	{
	-- 		"<leader>gp",
	-- 		function()
	-- 			Snacks.picker.gh_pr()
	-- 		end,
	-- 		desc = "GitHub Pull Requests (open)",
	-- 	},
	-- 	{
	-- 		"<leader>gP",
	-- 		function()
	-- 			Snacks.picker.gh_pr({ state = "all" })
	-- 		end,
	-- 		desc = "GitHub Pull Requests (all)",
	-- 	},
	-- },
}
