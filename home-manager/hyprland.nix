{
  config,
  pkgs,
  inputs,
  lib,
  ...
}: {
  wayland.windowManager.hyprland = {
    # Whether to enable Hyprland wayland compositor
    enable = true;
    # The hyprland package to use
    # package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    # portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;

    # Whether to enable XWayland
    xwayland.enable = true;

    # Optional
    # Whether to enable hyprland-session.target on hyprland startup
    systemd.enable = true;

    plugins = [
      # inputs.hy3.packages.x86_64-linux.hy3
    ];

    extraConfig = builtins.readFile ./hypr/hyprland.conf;
  };
  home.file.".config/hypr/pyprland.toml" = {
    source = ./hypr/pyprland.toml;
  };
}
