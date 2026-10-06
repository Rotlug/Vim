# Format before the buffer is written, when a language server can do it.
# If Biome is attached it is the only formatter, so the TypeScript, CSS, and JSON servers do not also rewrite the file.
{
  extraConfigLua = ''
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = vim.api.nvim_create_augroup("nixvim_format_on_save", { clear = true }),
      callback = function(args)
        local clients = vim.lsp.get_clients({
          bufnr = args.buf,
          method = "textDocument/formatting",
        })
        if #clients == 0 then
          return
        end
        local biome = vim.tbl_filter(function(client)
          return client.name == "biome"
        end, clients)
        vim.lsp.buf.format({
          bufnr = args.buf,
          timeout_ms = 2000,
          filter = function(client)
            if #biome > 0 then
              return client.name == "biome"
            end
            return true
          end,
        })
      end,
    })
  '';
}
