local actions = require("telescope.actions")
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
			},
		},
      },
	  extensions = {
		  fzy_native = {
			  override_generic_sorter = false,
			  override_file_sorter = true
		  }
	  },
})

require('telescope').load_extension('fzy_native')
