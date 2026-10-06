# Styled-components template highlighting and CSS completion inside those templates.
# The lazy.nvim spec is removed so require("styled-components") reaches setup().
# cssls has to be on PATH. It is attached to JavaScript and TypeScript so templates can be completed.
{ lib, pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "styled-components.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "crafts69guy";
        repo = "styled-components.nvim";
        rev = "511b4b4b99726c310d787eafb82064753d2f0691";
        hash = "sha256-phAWtbhoT5jqINlyG1yV/VtYRlcCKtpWIiopSrXvfMs=";
      };
      postPatch = ''
        rm lua/styled-components.lua
      '';
    })
  ];

  extraConfigLua = ''
    require("styled-components").setup({
      enabled = true,
      auto_setup = true,
    })
  '';

  plugins = {
    lsp.servers.cssls = {
      enable = true;
      package = null;
      filetypes = [
        "css"
        "scss"
        "less"
        "javascript"
        "javascriptreact"
        "typescript"
        "typescriptreact"
      ];
    };

    blink-cmp.settings.sources.providers = {
      lsp.override.transform_items = lib.nixvim.mkRaw ''
        require("styled-components.blink").get_lsp_transform_items()
      '';
      styled-components = {
        name = "styled-components";
        module = "styled-components.completion";
        enabled = lib.nixvim.mkRaw ''require("styled-components.blink").enabled'';
      };
    };
  };
}
