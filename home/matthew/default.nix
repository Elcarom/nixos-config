{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/home/core
  ];

  home.username = "matthew";
  home.homeDirectory = "/home/matthew";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Elcarom";
        email = "signup@elcarom.me";
      };

      gpg.format = "ssh";

      url."git@github.com:".insteadOf = "https://github.com/";

    };

    signing = {
      signByDefault = true;
      key = "~/.ssh/id_ed25519.pub";
    };

  };
}
