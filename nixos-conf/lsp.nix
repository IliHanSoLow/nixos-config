{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    python312Packages.python-lsp-server
    nodePackages_latest.nodemon
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.yaml-language-server
    nodePackages_latest.dockerfile-language-server-nodejs
    cmake-language-server
    delve
    gopls
    htmx-lsp
    jdt-language-server
    marksman
    nil
    nixd
    sumneko-lua-language-server
    tinymist
    zls
  ];
  nix.nixPath = ["nixkpgs=${inputs.nixpkgs}"];
}
