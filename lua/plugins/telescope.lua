return {
	{
		"nvim-telescope/telescope.nvim",
		keys = {
			{
				"<leader>ff",
				LazyVim.pick("files", { root = false, no_ignore = true }),
				desc = "Find Files (cwd)",
			},
			{
				"<leader>fg",
				LazyVim.pick("live_grep", { root = false }),
				desc = "Grep Files (cwd)",
			},
		},

		opts = function(_, opts)
			opts.defaults = opts.defaults or {}

			-- Grep only inside cwd, including ignored/hidden files
			opts.defaults.vimgrep_arguments = {
				"rg",
				"--color=never",
				"--no-heading",
				"--with-filename",
				"--line-number",
				"--column",
				"--smart-case",
				"--no-ignore",
				"--hidden",
				"-g",
				"!.git",
			}

			opts.pickers = opts.pickers or {}

			-- Find files only inside cwd
			opts.pickers.find_files = {
				find_command = {
					"rg",
					"--files",
					"--color",
					"never",
					"--no-ignore",
					"--hidden",
					"-g",
					"!.git",
				},
				no_ignore = true,
				hidden = true,
			}

			-- Grep only inside cwd
			opts.pickers.live_grep = {
				additional_args = function()
					return {
						"--no-ignore",
						"--hidden",
						"-g",
						"!.git",
					}
				end,
			}
			opts.defaults.layout_config = {
				horizontal = {
					width = 0.98,
					height = 0.95,
					preview_width = 0.35,
				},
			}
		end,
	},
}
