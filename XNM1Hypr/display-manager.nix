{pkgs, ...}: {
  # Enable Display Manager

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --r --time --time-format '%I:%M %p | %a • %h | %F' --cmd /home/ilian/.bootscript.sh";
        user = "greeter";
      };
    };
  };

  environment.systemPackages = with pkgs; [
    greetd.tuigreet
  ];
}
