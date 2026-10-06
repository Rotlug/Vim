# Language servers. JSON, YAML, and Nix are installed with Neovim.
# Every other server is expected on PATH. nixfmt is included because nixd will not format until it is given a command.
# Fidget draws the progress spinner while a server is working.
{
  lib,
  pkgs,
  ...
}:
let
  # vscode-langservers-extracted ships JSON, CSS, and HTML servers together.
  # Only the JSON binary is exposed, so CSS and HTML stay on the user's PATH.
  vscode-json-language-server = pkgs.runCommand "vscode-json-language-server" { } ''
    mkdir -p $out/bin
    ln -s ${pkgs.vscode-langservers-extracted}/bin/vscode-json-language-server \
      $out/bin/vscode-json-language-server
  '';

  useSystemServer = {
    enable = true;
    package = null;
  };
in
{
  plugins = {
    fidget.enable = true;

    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        rust_analyzer = useSystemServer // {
          installCargo = false;
          installRustc = false;
          installRustfmt = false;
        };

        basedpyright = useSystemServer;
        ruff = useSystemServer;

        ts_ls = useSystemServer;
        html = useSystemServer;

        biome = useSystemServer;

        jsonls = {
          enable = true;
          package = vscode-json-language-server;
        };
        yamlls.enable = true;
        nixd = {
          enable = true;
          settings.formatting.command = [ (lib.getExe pkgs.nixfmt) ];
        };
      };
    };
  };
}
