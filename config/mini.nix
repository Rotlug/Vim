{
  plugins.gitsigns = {
    enable = true;
    settings.current_line_blame = true;
  };

  plugins.mini = {
    enable = true;
    mockDevIcons = true;
    modules = {
      ai = { };
      icons = { };
      pairs = { };

      statusline = {
        content.active = {
          __raw = ''
            function()
              local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
              
              local blame = vim.b.gitsigns_blame_line or ""

              return MiniStatusline.combine_groups({
                { hl = mode_hl, strings = { mode } },
                { hl = "MiniStatuslineDevinfo", strings = { blame } },
              })
            end
          '';
        };
      };

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
    };
  };
}
