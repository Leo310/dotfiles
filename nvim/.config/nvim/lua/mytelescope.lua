local actions = require("telescope.actions")
local trouble = require("trouble.providers.telescope")
require('telescope').setup({
      defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        -- ..
				prompt_prefix = "> ",
				mappings = {
					i = {
							["<C-k>"] = actions.move_selection_previous,	
							["<C-j>"] = actions.move_selection_next,	
							["<C-h>"] = actions.move_to_top,
							["<C-i>"] = actions.move_to_middle, 
							["<C-l>"] = actions.move_to_bottom,
							["<C-u>"] = actions.preview_scrolling_up,
							["<C-n>"] = actions.preview_scrolling_down,
							["<c-t>"] = trouble.open_with_trouble,
					},
					n = { 
							["<c-t>"] = trouble.open_with_trouble,
					},
				},
				file_ignore_patterns = {
					".git",
					"node_modules",
					"venv"
				}
      },
	  pickers = {
		  find_files = {
			  hidden = true
		  },
		  file_browser = {
			  hidden = true
		  }
	  },
	  extensions = {
		  fzy_native = {
			  override_generic_sorter = false,
			  override_file_sorter = true
		  },
			["ui-select"] = {
				require("telescope.themes").get_dropdown {
					-- even more opts
				}
			},
			project = {
				hidden_files = true, -- default: false
				theme = "dropdown",
				display_type = 'full'
			}
		},
})

require('telescope').load_extension('fzy_native')
require("telescope").load_extension("ui-select")
require("telescope").load_extension("project")
require("telescope").load_extension("notify")
