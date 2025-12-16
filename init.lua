-- bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

local vim = vim
local Plug = vim.fn['plug#']

-- Setup lazy package manager
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)


require("lazy").setup({
	{ "rebelot/kanagawa.nvim", name = "kanagawa" },
	{
		"nvim-treesitter/nvim-treesitter",
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "elixir", "eex", "heex" },
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{ "preservim/nerdtree", name = "nerdtree" },
	-- Elixir Setup
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			lspconfig.elixirls.setup({
				cmd = { "elixir-ls" },
				-- set default capabilities for cmp lsp completion source
				capabilities = capabilities,
			})
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
		        -- install different completion source
		        "hrsh7th/cmp-nvim-lsp",
		        "hrsh7th/cmp-buffer",
		        "hrsh7th/cmp-path",
		},
		config = function()
		        local cmp = require("cmp")
		        cmp.setup({
		      	  -- add different completion source
		      	  sources = cmp.config.sources({
		      		  { name = "nvim_lsp" },
		      		  { name = "buffer" },
		      		  { name = "path" },
		      	  }),
		      	  -- using default mapping preset
		      	  mapping = cmp.mapping.preset.insert({
		      		  ["<C-Space>"] = cmp.mapping.complete(),
		      		  ["<CR>"] = cmp.mapping.confirm({ select = true }),
		      	  }),
		      	  snippet = {
		      		  -- you must specify a snippet engine
		      		  expand = function(args)
		      			  -- using neovim v0.10 native snippet feature
		      			  -- you can also use other snippet engines
		      			  vim.snippet.expand(args.body)
		      		  end,
		      	  },
		        })
		end,
	},
	{
	    	'nvim-telescope/telescope.nvim', tag = '0.1.8',
	      	dependencies = { 'nvim-lua/plenary.nvim' }
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release"
	},
	{
		"tpope/vim-fugitive"
	},
})

-- Set colorscheme
vim.cmd.colorscheme "kanagawa"

-- General settings
vim.wo.number = true

-- set your leader and local leader key
-- make sure to set `mapleader` and `maplocalleader` before lazy so your mappings are correct
vim.g.mapleader = " " -- using space as leader key
vim.g.maplocalleader = "," -- using comma as local leader

vim.cmd("nnoremap <leader>n :NERDTreeFocus<CR>") vim.cmd("nnoremap <C-n> :NERDTreeToggle<CR>")
vim.cmd("nnoremap <leader>t :NERDTreeFind<CR>")

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

-- System clipboard commands
-- Copy
vim.cmd("vnoremap  <leader>y  \"+y")
vim.cmd("nnoremap  <leader>Y  \"+yg_")
vim.cmd("nnoremap  <leader>y  \"+y")
vim.cmd("nnoremap  <leader>yy  \"+yy")
-- Paste
vim.cmd("nnoremap <leader>p \"+p")
vim.cmd("nnoremap <leader>P \"+P")
vim.cmd("vnoremap <leader>p \"+p")
vim.cmd("vnoremap <leader>P \"+P")

vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  pattern = { "*" },
    command = [[%s/\s\+$//e]],
})
