{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    basedpyright
    python312Packages.python-lsp-server
    nodePackages_latest.nodemon
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.yaml-language-server
    nodePackages_latest.dockerfile-language-server-nodejs
    sumneko-lua-language-server
    marksman
    nil
    zls
    gopls
    nixd
    delve
    cmake-language-server
    htmx-lsp
    jdt-language-server
  ];
  nix.nixPath = ["nixkpgs=${inputs.nixpkgs}"];
}
