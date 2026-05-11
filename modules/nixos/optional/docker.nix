{
  pkgs,
  ...
}:

{
  virtualisation.docker = {
    enable = true;

    enableOnBoot = true;

    daemon.settings = {
      features = {
        buildkit = true;
      };
    };
  };

  hardware.nvidia-container-toolkit.enable = true;

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
