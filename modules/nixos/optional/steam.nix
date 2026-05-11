{
  pkgs,
  ...
}:

{
  programs.steam = {
    enable = true;

    remotePlay.openFirewall = false;
    dedicatedServer.openFirewall = false;
  };

  environment.systemPackages = with pkgs; [
    mangohud
    protonup-ng
  ];
}
