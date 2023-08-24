return {
	'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
	config = function()
		-- autocmd BufEnter * setlocal diagnostic.virtual_text = false
		require("lsp_lines").setup()
	end
}
