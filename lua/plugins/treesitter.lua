return{
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufEnter",
		lazy = true,
		config = function () 
		       	local configs = require("nvim-treesitter.configs")
      			configs.setup({
         			 sync_install = false,
         			 highlight = { enable = true },
    			         indent = { enable = true },  
       			 })
    			end
		}	


}
