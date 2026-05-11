{
  config,
  pkgs,
  ...
}:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;

    powerManagement.enable = false;

    open = false;

    nvidiaSettings = true;

    package =
      config.boot.kernelPackages.nvidiaPackages.production;
  };

  environment.systemPackages = with pkgs; [
    nvtopPackages.nvidia
  ];
}
