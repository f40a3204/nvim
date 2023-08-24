return {
	{
		"neovim/nvim-lspconfig",
		event = "BufEnter",
		lazy = true,
		keys = {
			{ "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>" },
			{ "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
			{ "<leader>xf", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
			{ "<leader>f",  "<cmd>lua vim.lsp.buf.format()<CR>" },
			{ "<leader>K",  "<cmd>lua vim.lsp.buf.hover()<CR>" },
			{ "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
			{ "<C-k>",      "<cmd>lua vim.lsp.buf.signature_help()<CR>" },
			{ "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>" },
			{ "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>" },
			{ "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>" },
			{ "<leader>D",  "<cmd>lua vim.lsp.buf.type_definition()<CR>" },
			{ "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>" },
			{ "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>" },
		},
		config = function()
		end
	},
	{
		'hrsh7th/cmp-buffer',
		event = "InsertEnter"
	},

	{
		'hrsh7th/cmp-path',
		event = "InsertEnter",
	},
	{
		'hrsh7th/cmp-nvim-lsp',
		event = "InsertEnter",
	},

	{
		'hrsh7th/nvim-cmp',
		event = 'InsertEnter',
		dependencies = {
			{ 'L3MON4D3/LuaSnip' },
		},
		config = function()
			local has_words_before = function()
				unpack = unpack or table.unpack
				local line, col = unpack(vim.api.nvim_win_get_cursor(0))
				return col ~= 0 and
				    vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match('%s') ==
				    nil
			end


			local cmp = require('cmp')
			local luasnip = require('luasnip')

			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
					end,
				},
				mapping = {
					['<C-b>'] = cmp.mapping.scroll_docs(-4),
					['<C-f>'] = cmp.mapping.scroll_docs(4),
					['<C-Space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm({ select = true }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif has_words_before() then
							cmp.complete()
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				},

				sources = {
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' },
					{ name = 'buffer' },
					{ name = 'path' },
				},
				window = {
					documentation = cmp.config.window.bordered(),
					completion = cmp.config.window.bordered({
						winhighlight = 'Normal:CmpPmenu,CursorLine:PmenuSel,Search:None'
					}),
				},
			})
		end

	},

	{
		'neovim/nvim-lspconfig',
		cmd = 'LspInfo',
		event = { 'BufReadPre', 'BufNewFile' },
		keys = {
			{ "<leader>gd", "<cmd>lua vim.lsp.buf.definition()<CR>" },
			{ "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<CR>" },
			{ "<leader>xf", "<cmd>lua vim.lsp.buf.code_action()<CR>" },
			{ "<leader>f",  "<cmd>lua vim.lsp.buf.format()<CR>" },
			{ "<leader>K",  "<cmd>lua vim.lsp.buf.hover()<CR>" },
			{ "<leader>gi", "<cmd>lua vim.lsp.buf.implementation()<CR>" },
			{ "<C-k>",      "<cmd>lua vim.lsp.buf.signature_help()<CR>" },
			{ "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>" },
			{ "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>" },
			{ "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>" },
			{ "<leader>D",  "<cmd>lua vim.lsp.buf.type_definition()<CR>" },
			{ "<leader>gr", "<cmd>lua vim.lsp.buf.references()<CR>" },
			{ "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>" },
		},
		dependencies = {
			{ 'hrsh7th/cmp-nvim-lsp' },
			{ 'williamboman/mason-lspconfig.nvim' },
			{ 'williamboman/mason.nvim' },
		},
		config = function()
			local lspconfig = require('lspconfig')
			vim.diagnostic.config({
				virtual_text = false,
			})
			lspconfig.clojure_lsp.setup {
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = {
					"/nix/store/cb7jgbpndnkpd1w7vbqwwdz44k28fjpn-system-path/bin/clojure-lsp"
				}
			}
			lspconfig.lua_ls.setup {
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = {
					"/nix/store/cb7jgbpndnkpd1w7vbqwwdz44k28fjpn-system-path/bin/lua-language-server"
				}
			}
			lspconfig.elixirls.setup {
				on_attach = on_attach,
				capabilities = capabilities,
				cmd = {
					"/nix/store/cb7jgbpndnkpd1w7vbqwwdz44k28fjpn-system-path/bin/elixir-ls"
				}
			}
			lspconfig.efm.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "elixir" },
				cmd = {
					" /nix/store/cb7jgbpndnkpd1w7vbqwwdz44k28fjpn-system-path/bin/efm-langserver"
				}
			})
			lspconfig.zls.setup({
				capabilities = capabilities,
				on_attach = on_attach,
				filetypes = { "zig" },
				cmd = {
					"/home/oxynoe/build/zls/zig-out/bin/zls"
				}
			})
		end
	}
}
