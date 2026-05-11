{
  config,
  pkgs,
  lib,
  ...
}:

{
  networking.hostName = "dsk-nos102";

  system.stateVersion = "25.05";

  imports = [
    
    ./hardware.nix

    ../../modules/nixos/core/boot.nix
    ../../modules/nixos/core/locale.nix
    ../../modules/nixos/core/networking.nix
    ../../modules/nixos/core/nix.nix
    ../../modules/nixos/core/ssh.nix
    ../../modules/nixos/core/users.nix

    ../../modules/nixos/users/matthew.nix
    ../../modules/nixos/users/camille.nix
  ];
}
