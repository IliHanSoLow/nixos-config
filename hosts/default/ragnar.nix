{
  config,
  pkgs,
  ...
}:
# Ragnar WM
let
  myragnar = pkgs.ragnarwm.overrideAttrs (oldAttrs: rec {
    src = /home/ilian/dotfiles/nixos/git_packages/ragnar;
    buildInputs = oldAttrs.buildInputs ++ [pkgs.xorg.libXrandr];
  });
in {
  services.xserver.windowManager.ragnarwm = {
    enable = true;
    package = myragnar;
  };
}
