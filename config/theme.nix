# JetBrains colorscheme. setup() has to run before the colorscheme command.
{ pkgs, ... }:
{
  extraPlugins = [
    (pkgs.vimUtils.buildVimPlugin {
      name = "jb.nvim";
      src = pkgs.fetchFromGitHub {
        owner = "nickkadutskyi";
        repo = "jb.nvim";
        rev = "d3f93e573f66d17213c841cd08a23ca63a6ed329";
        hash = "sha256-PlDhHjJvdR8cYf5ziSHqM8xnX0VkMPwVRREXMb1was4=";
      };
    })
  ];

  extraConfigLua = ''
    require("jb").setup()
    vim.cmd.colorscheme("jb")
  '';
}
