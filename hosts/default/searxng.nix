{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    searxng
  ];
  services.searx = {
    enable = true;
    settings = {
      server = {
        port = 8888;
        bind_address = "127.0.0.1";
        secret_key = "fb3f326ddb42160fd74eb56ea5c4a1ecc8e61af0709ee15cf460ab41d68d4352";
      };
    };
  };
}
