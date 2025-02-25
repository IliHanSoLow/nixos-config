# Module to set a default cursor theme
{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.environment.defaultCursor;

  indexThemeText = theme: generators.toINI {} {"icon theme" = {Inherits = "${theme}";};};

  mkDefaultCursorFile = theme:
    pkgs.writeTextDir
    "index.theme"
    "${indexThemeText theme}";

  defaultCursorPkg = mkDefaultCursorFile cfg.theme;
in {
  options = {
    environment.defaultCursor = {
      enable = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Whether to set a default cursor theme for graphical environments.
        '';
      };

      theme = mkOption {
        type = types.str;
        default = "phinger-cursors";
        example = "Adwaita";
        description = "The name of the defualt cursor theme.";
      };
    };
  };

  config = mkIf cfg.enable {
    environment.systemPackages = [
      defaultCursorPkg
    ];
  };
}
