# Java through the IntelliJ language server.
# The server binary is downloaded by :IntellijServerInstall, so curl and unzip are on PATH.
# nvim-dap stays enabled because the plugin uses it to run and debug.
{ pkgs, ... }:
{
  extraPackages = [
    pkgs.curl
    pkgs.unzip
  ];

  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "intellij-server.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "AlexandrosAlexiou";
        repo = "intellij-server.nvim";
        rev = "366bcf10e9435c34f07e09f99f0c38a38277e290";
        hash = "sha256-XNhdrD9GRrAEbOfhZOpu3iIPkRrK31AiTtbQrEPEnDM=";
      };
    })
  ];

  extraConfigLua = ''
    require("intellij-server").setup()
  '';

  plugins.dap.enable = true;
}
