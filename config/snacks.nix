# Picker, file explorer, and small editor helpers. ripgrep and fd are the search tools.
# Previews skip large files so highlighting one does not stall typing.
{ pkgs, ... }:
{
  extraPackages = [
    pkgs.ripgrep
    pkgs.fd
  ];

  plugins.snacks = {
    enable = true;
    settings = {
      bigfile.enabled = true;
      quickfile.enabled = true;
      input.enabled = true;
      notifier.enabled = true;
      explorer.enabled = true;
      picker = {
        enabled = true;
        previewers.file.max_size = 64 * 1024;
      };
    };
  };
}
