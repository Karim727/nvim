return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		opts = {
			filesystem = {
				filtered_items = {
					visible = true,
					hide_dotfiles = false,
					hide_gitignored = false, -- Display files ignored by .gitignore in file tree
				},
				follow_current_file = {
					enabled = true,
				},
				hijack_netrw_behavior = "open_default",
			},
			window = {
				position = "left",
				width = 32,
				mappings = {
					["l"] = "open",
					["h"] = "close_node",
					["C"] = "set_root",
					["w"] = {
						function(state)
							local cur_width = vim.api.nvim_win_get_width(0)
							local target = cur_width >= 75 and 32 or 85
							vim.api.nvim_win_set_width(0, target)
							state.win_width = target
							require("neo-tree.ui.renderer").redraw(state)
						end,
						desc = "Toggle width (compact / metadata view)",
					},
					[">"] = {
						function(state)
							local cur_width = vim.api.nvim_win_get_width(0)
							local target = cur_width + 10
							vim.api.nvim_win_set_width(0, target)
							state.win_width = target
							require("neo-tree.ui.renderer").redraw(state)
						end,
						desc = "Increase window width (+10)",
					},
					["<"] = {
						function(state)
							local cur_width = vim.api.nvim_win_get_width(0)
							local target = math.max(20, cur_width - 10)
							vim.api.nvim_win_set_width(0, target)
							state.win_width = target
							require("neo-tree.ui.renderer").redraw(state)
						end,
						desc = "Decrease window width (-10)",
					},
					["."] = {
						function(state)
							local node = state.tree:get_node()
							if not node then
								return
							end
							local path = node:get_id()
							if vim.fn.isdirectory(path) ~= 1 then
								path = vim.fs.dirname(path)
							end
							if path and vim.fn.isdirectory(path) == 1 then
								vim.cmd("cd " .. vim.fn.fnameescape(path))
								pcall(function()
									require("neo-tree.sources.filesystem.commands").set_root(state)
								end)
								vim.notify("CWD: " .. path, vim.log.levels.INFO, { title = "Neo-tree" })
							end
						end,
						desc = "Change CWD to selected directory",
					},
					["o"] = {
						function(state)
							local node = state.tree:get_node()
							if not node then
								return
							end
							local path = node:get_id() or node.path
							if path then
								if vim.fn.executable("xdg-open") == 1 then
									vim.fn.jobstart({ "xdg-open", path }, { detach = true })
								else
									vim.ui.open(path)
								end
								vim.notify(
									"Opened with system app: " .. vim.fs.basename(path),
									vim.log.levels.INFO,
									{ title = "Neo-tree" }
								)
							end
						end,
						desc = "Open with System Application (xdg-open)",
					},
				},
			},
			default_component_configs = {
				file_size = {
					enabled = true,
					required_width = 45, -- Min width to show file size (default was 64)
				},
				type = {
					enabled = false, -- Hide type column to keep it clean
				},
				last_modified = {
					enabled = true,
					required_width = 70, -- Min width to show modified date (default was 88)
					format = "%Y-%m-%d %H:%M",
				},
			},
		},
	},
}
