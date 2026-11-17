return {
	-- Quick letter navigation (flash.nvim with jump labels, freeing 'S' for surround)
	{
		"folke/flash.nvim",
		keys = {
			-- { "S", mode = { "n", "x", "o" }, false }, -- Free 'S' for nvim-surround
		},
		opts = {
			modes = {
				char = {
					jump_labels = true, -- Shows direct letter labels for f/F/t/T navigation
				},
			},
		},
	},

	-- nvim-surround with visual mode 's'
	{
		"kylechui/nvim-surround",
		version = "*",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("nvim-surround").setup(opts)
			vim.keymap.set("x", "s", "<Plug>(nvim-surround-visual)", {
				desc = "Add a surrounding pair around a visual selection",
			})
		end,
	},

	-- Commenting engine with custom hardware language support
	{
		"folke/ts-comments.nvim",
		opts = {
			lang = {
				sdc = "# %s",
				xdc = "# %s",
				upf = "# %s",
				cpf = "# %s",
				tcl = "# %s",
			},
		},
	},
}
