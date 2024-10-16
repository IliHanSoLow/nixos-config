{config, ...}: {
  sops.secrets.NLFREE387043 = {
    sopsFile = ../hosts/common/secrets/secrets.yaml;
    neededForUsers = true;
  };
  networking.wireguard.interfaces = {
    NLFREE387043 = {
      ips = ["10.2.0.2/32"];
      dns = ["10.2.0."];
      listenPort = 51820;
      privateKeyFile = config.sops.secrets.NLFREE387043.path;

      peers = [
        {
          publicKey = "lqxGpBwoRUrxKpUvlq3VhJ9SCHgt8N5KxcGEfuz+Vys=";
          allowedIPs = ["0.0.0.0/0"];
          endpoint = "169.150.196.71:51820";
        }
      ];
    };
  };
}
