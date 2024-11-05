{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    python311Packages.python-lsp-server
    nodePackages_latest.nodemon
    nodePackages_latest.typescript
    nodePackages_latest.typescript-language-server
    nodePackages_latest.vscode-langservers-extracted
    nodePackages_latest.yaml-language-server
    nodePackages_latest.dockerfile-language-server-nodejs
    sumneko-lua-language-server
    marksman
    nil
    unstable.nixd
    zls
    gopls
    delve
    cmake-language-server
    htmx-lsp
    jdt-language-server
  ];
  nix.nixPath = ["nixkpgs=${inputs.nixpkgs}"];
}
