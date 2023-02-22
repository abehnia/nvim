local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

-- require "user.lsp.lsp-installer"
require("mason").setup()
require("user.lsp.mason-lspconfig").setup()
require("user.lsp.handlers").setup()
-- require("lspconfig").setup()
require "user.lsp.null-ls"
