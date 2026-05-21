{
  config,
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

  programs.git.settings.user = {

    name = "Elcarom";
    email = "signup@elcarom.me";

  };
}
