local g = vim.g
local o = vim.o

o.termguicolors = true

o.number = true
o.relativenumber = true

o.tabstop = 4
--o.softtabstop = 4
o.shiftwidth = 4
--o.expandtab = true

o.smartindent = true

o.wrap = false

--o.mouse = nil

require("Packer")

function needs_packer()

	require('lualine').setup {
		options = {
			theme = 'onedark'
		}
	}

	require('todo-comments').setup()
	require('trouble').setup()

	require("mason").setup()
	require("mason-lspconfig").setup()

	-- NOTE: https://github.com/williamboman/mason-lspconfig.nvim/blob/main/doc/server-mapping.md
	require("mason-lspconfig").setup_handlers {
		-- The first entry (without a key) will be the default handler
		-- and will be called for each installed server that doesn't have
		-- a dedicated handler.
		function (server_name) -- default handler (optional)
			require("lspconfig")[server_name].setup {}
		end,
		-- Next, you can provide a dedicated handler for specific servers.
		-- For example, a handler override for the `rust_analyzer`:

		["sumneko_lua"] = function ()
			require("lspconfig").sumneko_lua.setup {
				settings = {
					Lua = {
						diagnostics = {
							globals = {
								'vim',
								'love',
								'awesome',
								'client',
								'screen',
								'root',
							},
							disable = {'lowercase-global'},
						},
						telemetry = {
							enable = false,
						},
					},
				},
				filetypes = {
					'lua',
				},
			}
		end
	}

	vim.api.nvim_create_autocmd({"VimEnter"}, {command = "CHADopen --nofocus"})
	vim.cmd 'autocmd BufEnter * if (winnr("$") == 1 && &filetype == "CHADTree") | q | endif'

	vim.cmd 'colorscheme onedark'
end

if not pcall(needs_packer) then
	print"you need to type :PackerInstall first"
end

local chadtree_settings = {
	theme = {
		text_colour_set = "nerdtree_syntax_dark",
	}
}

vim.api.nvim_set_var("chadtree_settings", chadtree_settings)



vim.keymap.set('n', '<A-f>', ':CHADopen<CR>')

vim.keymap.set('n', '<A-t>', ':TroubleToggle<CR>')

vim.cmd [[
:tnoremap <A-h> <C-\><C-N><C-w>h
:tnoremap <A-j> <C-\><C-N><C-w>j
:tnoremap <A-k> <C-\><C-N><C-w>k
:tnoremap <A-l> <C-\><C-N><C-w>l
:inoremap <A-h> <C-\><C-N><C-w>h
:inoremap <A-j> <C-\><C-N><C-w>j
:inoremap <A-k> <C-\><C-N><C-w>k
:inoremap <A-l> <C-\><C-N><C-w>l
:nnoremap <A-h> <C-w>h
:nnoremap <A-j> <C-w>j
:nnoremap <A-k> <C-w>k
:nnoremap <A-l> <C-w>l
]]

vim.g.coq_settings = {
	auto_start = 'shut-up'
}

vim.cmd 'hi Normal guibg=NONE ctermbg=NONE'

