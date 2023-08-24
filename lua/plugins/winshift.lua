return {
	'https://gitlab.com/yorickpeterse/nvim-window.git',
	lazy = true,
	keys = {
		{"<leader>t", "<cmd>lua require('nvim-window').pick()<CR>"},
	},

	config = function()
		require('nvim-window').setup({

			chars = {
				'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
				'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'
			},

			normal_hl = 'Normal',

			hint_hl = 'Bold',

			border = 'single'
		})
	end
}
