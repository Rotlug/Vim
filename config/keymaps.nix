# Leader keymaps.
# Code actions include quick fixes, refactors, and source actions.
# The same source action offered by two servers is listed once.
{ lib, ... }:
{
  keymaps = [
    {
      mode = [
        "n"
        "x"
      ];
      key = "<leader>a";
      action = lib.nixvim.mkRaw ''
        function()
          local seen_source = {}
          vim.lsp.buf.code_action({
            context = {
              only = { "quickfix", "refactor", "source" },
            },
            filter = function(action, client_id)
              local kind = action.kind or ""
              if not vim.startswith(kind, "source") then
                return true
              end
              local client = vim.lsp.get_client_by_id(client_id)
              local name = client and client.name or ""
              local suffix = "." .. name
              local key = (name ~= "" and vim.endswith(kind, suffix)) and kind:sub(1, #kind - #suffix) or kind
              if seen_source[key] then
                return false
              end
              seen_source[key] = true
              return true
            end,
          })
        end
      '';
      options.desc = "Code actions";
    }
    {
      mode = "n";
      key = "<leader>c";
      action = lib.nixvim.mkRaw ''
        function()
          return require("vim._comment").operator() .. "_"
        end
      '';
      options = {
        expr = true;
        desc = "Comment line";
      };
    }
    {
      mode = "x";
      key = "<leader>c";
      action = lib.nixvim.mkRaw ''
        function()
          return require("vim._comment").operator()
        end
      '';
      options = {
        expr = true;
        desc = "Comment selection";
      };
    }
    {
      mode = "n";
      key = "<leader>r";
      action = "<cmd>lua vim.lsp.buf.rename()<cr>";
      options.desc = "Rename";
    }
    {
      mode = "n";
      key = "<leader><space>";
      action = "<cmd>lua Snacks.picker.files()<cr>";
      options.desc = "Find files";
    }
    {
      mode = "n";
      key = "<leader>,";
      action = "<cmd>lua Snacks.picker.buffers()<cr>";
      options.desc = "Buffers";
    }
    {
      mode = "n";
      key = "<leader>/";
      action = "<cmd>lua Snacks.picker.grep()<cr>";
      options.desc = "Grep";
    }
    {
      mode = "n";
      key = "<leader>:";
      action = "<cmd>lua Snacks.picker.command_history()<cr>";
      options.desc = "Command history";
    }
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>lua Snacks.explorer()<cr>";
      options.desc = "File explorer";
    }
    {
      mode = "n";
      key = "<leader>d";
      action = "<cmd>lua Snacks.picker.diagnostics()<cr>";
      options.desc = "Diagnostics";
    }
    {
      mode = "n";
      key = "<leader>h";
      action = "<cmd>lua Snacks.picker.help()<cr>";
      options.desc = "Help";
    }
    {
      mode = "n";
      key = "<leader>k";
      action = "<cmd>lua vim.lsp.buf.hover()<cr>";
      options.desc = "Hover documentation";
    }
    {
      mode = "n";
      key = "gd";
      action = "<cmd>lua Snacks.picker.lsp_definitions()<cr>";
      options.desc = "Goto definition";
    }
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohlsearch<cr>";
      options.desc = "Clear search highlight";
    }
  ];
}
