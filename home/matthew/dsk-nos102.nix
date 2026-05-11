{
  ...
}:

{
  imports = [
    ../../modules/home/core

    ../../modules/home/optional/git.nix
    ../../modules/home/optional/nh.nix
    ../../modules/home/optional/firefox.nix
  ];

  home.username = "matthew";
  home.homeDirectory = "/home/matthew";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

  programs.git.settings = {
    user ={
      name = "Elcarom";
      email = "signup@elcarom.me";
    };
  };
}
