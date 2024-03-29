{
  pkgs,
  pkgsCross,
  ...
}: {
  environment.systemPackages = with pkgsCross; [
    mingw32
  ];
}
