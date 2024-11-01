{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    go
    gopls
    (python3Full.withPackages (ps: with ps; [pygobject3 gobject-introspection pyqt6-sip]))
    nodePackages_latest.nodejs
    bun
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

    # WASM
    wasmedge
    # wasmer
    # lunatic
    wasmi
    # wasm3

    # RUST
    cargo
    rustc
    clippy
    lldb_16
    taplo #toml formatter & lsp
    cargo-watch
    cargo-deny
    cargo-audit
    cargo-update
    cargo-edit
    cargo-outdated
    cargo-license
    cargo-tarpaulin
    cargo-cross
    cargo-zigbuild
    cargo-nextest
    cargo-spellcheck
    cargo-modules
    cargo-bloat
    cargo-unused-features
    bacon
    evcxr #rust repl
  ];
}
