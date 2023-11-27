-- eat warnings
local vim = vim

local lsp = require("lsp-zero")

-- lsp.preset("recommended")

-- supported LSPs here: https://github.com/williamboman/mason-lspconfig.nvim
require("mason").setup()
require("mason-lspconfig").setup{
    ensure_installed = {
        "lua_ls",
        "clangd",
        -- "cmake",
        "marksman", -- markdown
        "pylsp", -- python
        -- "svls", -- system verilog
    },
}

-- local cmp = require("cmp")
-- local cmp_select = {behavior = cmp.SelectBehavior.Select}
-- local cmp_mappings = lsp.defaults.cmp_mappings({
-- 	['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
-- 	['<C-n>'] = cmp.mapping.select_prev_item(cmp_select),
-- 	['<C-y>'] = cmp.mapping.select_prev_item({ select = true }),
-- 	['<C-Space>'] = cmp.mapping.complete(),
-- })

local cmp = require("cmp")
cmp.setup({
    -- mapping = cmp.mapping.preset.insert({
    mapping = ({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<Tab>'] = cmp.mapping.confirm({ select = true }),
        ['<Esc>'] = cmp.mapping.abort(),
    })
})

lsp.set_preferences({
	sign_icons = { }
})

lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
	vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
	vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
	vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
	vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
	vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
	vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
	vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
end)

lsp.setup()

-- do this for each new lsp
lspconfig = require("lspconfig")
lspconfig.lua_ls.setup({})
lspconfig.clangd.setup({})
lspconfig.pylsp.setup({})
