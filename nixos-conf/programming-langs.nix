{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    go
    gopls
    (python3Full.withPackages (ps: with ps; [pygobject3 gobject-introspection pyqt6-sip]))
    nodePackages_latest.nodejs
    unstable.deno
    lua
    zig
    numbat
    gnu-cobol
    #gmp is for calculatin with cobal
    gmp
    nim
    nimble
    fasm-bin
    typst
    godot_4
    bear
    gradle
    maven
    sqlite

    # WASM
    wasmedge
    # wasmer
    # lunatic
    wasmi
    # wasm3
  ];
}
