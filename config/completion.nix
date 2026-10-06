# Insert-mode and command-line completion.
# The first word of a command waits for three characters, so short commands such as :w and :q are left alone.
{ lib, ... }:
{
  plugins.blink-cmp = {
    enable = true;
    settings = {
      keymap.preset = "super-tab";
      appearance.nerd_font_variant = "mono";
      signature.enabled = true;
      cmdline = {
        enabled = true;
        keymap = {
          "<Tab>" = [
            "show"
            "accept"
          ];
          "<S-Tab>" = [
            "show"
            "select_prev"
          ];
          "<CR>" = [
            "accept_and_enter"
            "fallback"
          ];
        };
        completion.menu.auto_show = true;
      };
      completion = {
        documentation = {
          auto_show = true;
          auto_show_delay_ms = 200;
        };
        menu.draw.treesitter = [ "lsp" ];
      };
      sources = {
        default = [
          "lsp"
          "path"
          "snippets"
          "buffer"
          "styled-components"
        ];
        providers.cmdline.min_keyword_length = lib.nixvim.mkRaw ''
          function(ctx)
            if ctx.mode == "cmdline" and string.find(ctx.line, " ") == nil then
              return 3
            end
            return 0
          end
        '';
      };
    };
  };
}
