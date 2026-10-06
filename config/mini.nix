# Statusline, tabline, pairs, surround, and the key-hint popup.
# The popup opens immediately. Surround is bound to gs so that s stays substitute.
{ lib, ... }:
{
  plugins.mini = {
    enable = true;
    mockDevIcons = true;
    modules = {
      ai = { };
      icons = { };
      pairs = { };
      diff.view.style = "sign";
      statusline = { };
      tabline = { };
      surround.mappings = {
        add = "gsa";
        delete = "gsd";
        find = "gsf";
        find_left = "gsF";
        highlight = "gsh";
        replace = "gsr";
        update_n_lines = "gsn";
      };
      clue = {
        window.delay = 0;
        triggers = [
          {
            mode = "n";
            keys = "<Leader>";
          }
          {
            mode = "x";
            keys = "<Leader>";
          }
          {
            mode = "n";
            keys = "g";
          }
          {
            mode = "x";
            keys = "g";
          }
          {
            mode = "n";
            keys = "z";
          }
          {
            mode = "x";
            keys = "z";
          }
          {
            mode = "n";
            keys = "[";
          }
          {
            mode = "n";
            keys = "]";
          }
        ];
        clues = lib.nixvim.mkRaw ''
          {
            require("mini.clue").gen_clues.builtin_completion(),
            require("mini.clue").gen_clues.g(),
            require("mini.clue").gen_clues.marks(),
            require("mini.clue").gen_clues.registers(),
            require("mini.clue").gen_clues.windows(),
            require("mini.clue").gen_clues.z(),
          }
        '';
      };
    };
  };
}
