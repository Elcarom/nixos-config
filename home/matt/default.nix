{ pkgs, ... }:

{
  home.username = "matt";
  home.homeDirectory = "/home/matt";

  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
