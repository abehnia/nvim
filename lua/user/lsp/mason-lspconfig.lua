local status_ok, lspconfig = pcall(require, "mason-lspconfig")
if not status_ok then
   return
end

local M = {}

local on_attach = require("user.lsp.handlers").on_attach
local capabilities = require("user.lsp.handlers").capabilities

local settings_map = {
    rust_analyzer = "user.lsp.settings.rust_analyzer",
    lua_ls = "user.lsp.settings.lua_ls",
    -- jsonls = "user.lsp.settings.jsonls",
}

M.setup = function()
   lspconfig.setup_handlers {
       function(server_name)
          require("lspconfig")[server_name].setup {
              on_attach = on_attach,
              capabilities = capabilities,
              -- settings = require(settings_map[server_name]).settings
          }
       end,
       ["lua_ls"] = function()
          local opts = require("user.lsp.settings.lua_ls")
          require("lspconfig")["lua_ls"].setup {
              on_attach = on_attach,
              capabilities = capabilities,
              settings = opts.settings,
          }
       end
   }
end

return M


--local servers = { 'jsonls', 'sumneko_lua', 'rust_analyzer' }
--
--for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--      on_attach = on_attach,
--      capabilities = capabilities,
--   }
--end
--
---- Register a handler that will be called for all installed servers.
---- Alternatively, you may also register handlers on specific server instances instead (see example below).
--lsp_installer.on_server_ready(function(server)
--
--	 if server.name == "jsonls" then
--	 	local jsonls_opts = require("user.lsp.settings.jsonls")
--	 	opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
--	 end
--
--	 if server.name == "sumneko_lua" then
--	 	local sumneko_opts = require("user.lsp.settings.sumneko_lua")
--	 	opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
--	 end
--
--	 if server.name == "rust_analyzer" then
--	 	local rust_analyzer_opts = require("user.lsp.settings.rust_analyzer")
--	 	opts = vim.tbl_deep_extend("force", rust_analyzer_opts, opts)
--	 end
--
--	-- This setup() function is exactly the same as lspconfig's setup function.
--	-- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--	server:setup(opts)
--end)
