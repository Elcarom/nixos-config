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
    ./disko.nix

    ../../modules/nixos/core/boot.nix
    ../../modules/nixos/core/locale.nix
    ../../modules/nixos/core/networking.nix
    ../../modules/nixos/core/nix.nix
    ../../modules/nixos/core/ssh.nix
    ../../modules/nixos/core/users.nix

    ../../modules/nixos/optional/zram.nix
    ../../modules/nixos/optional/snapshots.nix
    ../../modules/nixos/optional/nvidia.nix
    ../../modules/nixos/optional/audio.nix
    ../../modules/nixos/optional/docker.nix
    ../../modules/nixos/optional/plasma.nix
    ../../modules/nixos/optional/comfyui.nix
    ../../modules/nixos/optional/mediamtx.nix
    ../../modules/nixos/optional/restic.nix

    ../../modules/nixos/users/matthew.nix
    ../../modules/nixos/users/camille.nix
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    users = {
      matthew =
        import ../../home/matthew/dsk-nos102.nix;

      camille =
        import ../../home/camille/dsk-nos102.nix;
    };
  };
}
