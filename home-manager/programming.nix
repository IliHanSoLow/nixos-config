{
  inputs,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    arduino
    beekeeper-studio
    black
    burpsuite
    dfu-programmer
    direnv
    gdb
    gf
    ghidra
    jetbrains.clion
    jetbrains.idea-ultimate
    jq
    nmap
    platformio
    prettierd
    qmk
    stylua
    vscodium
  ];
}
