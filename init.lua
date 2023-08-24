vim.wo.relativenumber = true
vim.wo.number = true
vim.g.netrw_banner = 0
vim.opt.smartindent = true
vim.o.mouse = ""
vim.api.nvim_set_option('mouse', '')

vim.o.termguicolors = true

vim.api.nvim_exec([[
	au BufEnter * setlocal cursorline
	au BufLeave * setlocal nocursorline
]], false)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("lazy").setup('plugins')


require("oxynoe")
