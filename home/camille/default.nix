{ pkgs, ... }:

{
  home.username = "camille";
  home.homeDirectory = "/home/camille";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
