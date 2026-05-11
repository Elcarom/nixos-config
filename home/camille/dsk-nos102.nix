{
  ...
}:

{
  imports = [
    ../../modules/home/core

    ../../modules/home/optional/firefox.nix
  ];

  home.username = "camille";
  home.homeDirectory = "/home/camille";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
