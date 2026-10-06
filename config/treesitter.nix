# Syntax highlighting, indentation, and automatic closing and renaming of HTML, JSX, and TSX tags.
{ config, ... }:
{
  plugins = {
    ts-autotag.enable = true;

    treesitter = {
      enable = true;
      nixGrammars = true;
      highlight.enable = true;
      indent.enable = true;
      grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
        bash
        css
        html
        java
        javascript
        json
        lua
        markdown
        nix
        python
        query
        regex
        rust
        styled
        toml
        tsx
        typescript
        vim
        vimdoc
        yaml
      ];
    };
  };
}
