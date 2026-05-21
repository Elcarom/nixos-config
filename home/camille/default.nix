{
  config,
  ...
}:

{
  imports = [
    ../../modules/home/core
  ];

  home.username = "camille";
  home.homeDirectory = "/home/camille";

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;

}
