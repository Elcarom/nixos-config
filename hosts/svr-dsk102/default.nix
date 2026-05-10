{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    ../../modules/common
    ../../modules/desktop
    ../../modules/gaming
    ../../modules/audio
    ../../modules/docker
    ../../modules/services
    ../../modules/security
    ../../modules/users
  ];

  networking.hostName = "svr-dsk102";

  system.stateVersion = "26.05";
}
